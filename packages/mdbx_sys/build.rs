use bindgen::{
    Formatter,
    callbacks::{IntKind, ParseCallbacks},
};
use std::{env, path::PathBuf, process::Command, fs};

#[derive(Debug)]
struct Callbacks;

impl ParseCallbacks for Callbacks {
    fn int_macro(&self, name: &str, _value: i64) -> Option<IntKind> {
        match name {
            "MDBX_SUCCESS"
            | "MDBX_KEYEXIST"
            | "MDBX_NOTFOUND"
            | "MDBX_PAGE_NOTFOUND"
            | "MDBX_CORRUPTED"
            | "MDBX_PANIC"
            | "MDBX_VERSION_MISMATCH"
            | "MDBX_INVALID"
            | "MDBX_MAP_FULL"
            | "MDBX_DBS_FULL"
            | "MDBX_READERS_FULL"
            | "MDBX_TLS_FULL"
            | "MDBX_TXN_FULL"
            | "MDBX_CURSOR_FULL"
            | "MDBX_PAGE_FULL"
            | "MDBX_MAP_RESIZED"
            | "MDBX_INCOMPATIBLE"
            | "MDBX_BAD_RSLOT"
            | "MDBX_BAD_TXN"
            | "MDBX_BAD_VALSIZE"
            | "MDBX_BAD_DBI"
            | "MDBX_LOG_DONTCHANGE"
            | "MDBX_DBG_DONTCHANGE"
            | "MDBX_RESULT_TRUE"
            | "MDBX_UNABLE_EXTEND_MAPSIZE"
            | "MDBX_PROBLEM"
            | "MDBX_LAST_LMDB_ERRCODE"
            | "MDBX_BUSY"
            | "MDBX_EMULTIVAL"
            | "MDBX_EBADSIGN"
            | "MDBX_WANNA_RECOVERY"
            | "MDBX_EKEYMISMATCH"
            | "MDBX_TOO_LARGE"
            | "MDBX_THREAD_MISMATCH"
            | "MDBX_TXN_OVERLAPPING"
            | "MDBX_BACKLOG_DEPLETED"
            | "MDBX_DUPLICATED_CLK"
            | "MDBX_DANGLING_DBI"
            | "MDBX_OUSTED"
            | "MDBX_MVCC_RETARDED"
            | "MDBX_LAST_ERRCODE" => Some(IntKind::Int),
            _ => Some(IntKind::UInt),
        }
    }
}

const LIBMDBX_REPO: &str = "https://github.com/erthink/libmdbx.git";
const LIBMDBX_TAG: &str = "v0.13.7";

fn main() {
    println!("cargo:rerun-if-changed=build.rs");
    unsafe {
        env::set_var("IPHONEOS_DEPLOYMENT_TARGET", "12.0");
    }

    let is_android = env::var("CARGO_CFG_TARGET_OS").unwrap() == "android";
    let target = env::var("TARGET").unwrap_or_default();

    let _ = fs::remove_dir_all("libmdbx");

    Command::new("git")
        .arg("clone")
        .arg(LIBMDBX_REPO)
        .arg("--branch")
        .arg(LIBMDBX_TAG)
        .output()
        .unwrap();

    let mut mdbx = PathBuf::from(&env::var("CARGO_MANIFEST_DIR").unwrap());
    mdbx.push("libmdbx");

    let out_path = PathBuf::from(env::var("OUT_DIR").unwrap());

    let bindings = bindgen::Builder::default()
        .header(mdbx.join("mdbx.h").to_string_lossy())
        .allowlist_var("^(MDBX|mdbx)_.*")
        .allowlist_type("^(MDBX|mdbx)_.*")
        .allowlist_function("^(MDBX|mdbx)_.*")
        .size_t_is_usize(true)
        .ctypes_prefix("::libc")
        .parse_callbacks(Box::new(Callbacks))
        .layout_tests(false)
        .prepend_enum_name(false)
        .generate_comments(true)
        .disable_header_comment()
        .formatter(Formatter::None)
        // Ensure cursor ops are generated with variants; leave options as consts for cross-platform stability
        .rustified_enum("^MDBX_cursor_op$")
        .generate()
        .expect("Unable to generate bindings");

    bindings
        .write_to_file(out_path.join("bindings.rs"))
        .expect("Couldn't write bindings!");

    let mut cc_builder = cc::Build::new();
    cc_builder
        .flag_if_supported("-Wall")
        .flag_if_supported("-Werror")
        .flag_if_supported("-ffunction-sections")
        .flag_if_supported("-Wno-error=attributes");
    // Avoid hiding C symbols on Apple targets; otherwise the resulting archive may have no exported symbols
    if target.contains("apple") {
        cc_builder.flag("-fvisibility=default");
    } else {
        cc_builder.flag_if_supported("-fvisibility=hidden");
    }

    // Ensure position independent code for linking into shared libs (Android i686 needs this)
    if !cfg!(windows) {
        cc_builder.pic(true);
    }

    let flags = format!(
        "\"-NDEBUG={} {}\"",
        u8::from(!cfg!(debug_assertions)),
        cc_builder
            .get_compiler()
            .cflags_env()
            .to_str()
            .unwrap()
            .trim()
    );

    cc_builder
        .define("MDBX_BUILD_FLAGS", flags.as_str())
        .define("MDBX_TXN_CHECKOWNER", "0");

    // Android-specific tweaks: disable builtin CPU feature probes and PID checks
    if is_android {
        cc_builder.define("MDBX_HAVE_BUILTIN_CPU_SUPPORTS", "0");
        cc_builder.define("MDBX_ENV_CHECKPID", "0");
    }

    // __cpu_model is not available in musl
    if target.ends_with("-musl") {
        cc_builder.define("MDBX_HAVE_BUILTIN_CPU_SUPPORTS", "0");
    }

    if cfg!(windows) {
        println!(r"cargo:rustc-link-lib=dylib=ntdll");
        println!(r"cargo:rustc-link-lib=dylib=user32");
        // Required by registry and CryptoAPI functions used by libmdbx
        println!(r"cargo:rustc-link-lib=dylib=advapi32");
    }

    // Build static lib with a canonical name so Cargo links it correctly across platforms
    cc_builder.file(mdbx.join("mdbx.c")).compile("mdbx");
}