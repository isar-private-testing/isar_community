#!/bin/bash

if [[ "$(uname -s)" == "Darwin" ]]; then
    export NDK_HOST_TAG="darwin-x86_64"
elif [[ "$(uname -s)" == "Linux" ]]; then
    export NDK_HOST_TAG="linux-x86_64"
else
    echo "Unsupported OS."
    exit
fi

NDK=${ANDROID_NDK_HOME:-${ANDROID_NDK_ROOT:-"$ANDROID_SDK_ROOT/ndk"}}
COMPILER_DIR="$NDK/toolchains/llvm/prebuilt/$NDK_HOST_TAG/bin"
export PATH="$COMPILER_DIR:$PATH"

echo "$COMPILER_DIR"

export CC_i686_linux_android=$COMPILER_DIR/i686-linux-android21-clang
export AR_i686_linux_android=$COMPILER_DIR/llvm-ar
export CARGO_TARGET_I686_LINUX_ANDROID_LINKER=$COMPILER_DIR/i686-linux-android21-clang
export CARGO_TARGET_I686_LINUX_ANDROID_AR=$COMPILER_DIR/llvm-ar

export CC_x86_64_linux_android=$COMPILER_DIR/x86_64-linux-android21-clang
export AR_x86_64_linux_android=$COMPILER_DIR/llvm-ar
export CARGO_TARGET_X86_64_LINUX_ANDROID_LINKER=$COMPILER_DIR/x86_64-linux-android21-clang
export CARGO_TARGET_X86_64_LINUX_ANDROID_AR=$COMPILER_DIR/llvm-ar

export CC_armv7_linux_androideabi=$COMPILER_DIR/armv7a-linux-androideabi21-clang
export AR_armv7_linux_androideabi=$COMPILER_DIR/llvm-ar
export CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_LINKER=$COMPILER_DIR/armv7a-linux-androideabi21-clang
export CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_AR=$COMPILER_DIR/llvm-ar

export CC_aarch64_linux_android=$COMPILER_DIR/aarch64-linux-android21-clang
export AR_aarch64_linux_android=$COMPILER_DIR/llvm-ar
export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=$COMPILER_DIR/aarch64-linux-android21-clang
export CARGO_TARGET_AARCH64_LINUX_ANDROID_AR=$COMPILER_DIR/llvm-ar

cd packages/isar_core_ffi

if [ "$1" = "x86" ]; then
  rustup target add i686-linux-android
  cargo build --target i686-linux-android --release
  
  # Check both possible locations for the library
  if [ -f "target/i686-linux-android/release/libisar.so" ]; then
    mv "target/i686-linux-android/release/libisar.so" "../../libisar_android_x86.so"
  elif [ -f "../../target/i686-linux-android/release/libisar.so" ]; then
    mv "../../target/i686-linux-android/release/libisar.so" "../../libisar_android_x86.so"
  else
    echo "ERROR: Library not found for i686-linux-android"
    exit 1
  fi
elif [ "$1" = "x64" ]; then
  echo "Building x64 with 16KB page size support..."
  rustup target add x86_64-linux-android
  
  echo "=== Checking cargo config ==="
  echo "Current directory: $(pwd)"
  echo "Checking if .cargo/config.toml exists:"
  ls -la .cargo/config.toml 2>/dev/null || echo ".cargo/config.toml not found in current directory"
  
  echo "Checking cargo config for x86_64-linux-android target:"
  cargo config get target.x86_64-linux-android.rustflags 2>/dev/null || echo "No rustflags found for x86_64-linux-android"
  
  echo "Checking all target configurations:"
  cargo config get --show-origin 2>/dev/null | grep -A5 -B5 "x86_64-linux-android\|rustflags\|max-page-size" || echo "No relevant config found"
  
  echo "=== Starting build ==="
  echo "Running: cargo build --target x86_64-linux-android --release"
  
  if cargo build --target x86_64-linux-android --release; then
    echo "Build succeeded, looking for library..."
    
    # Check local target directory first
    if [ -f "target/x86_64-linux-android/release/libisar.so" ]; then
      echo "Found library in local target directory"
      mv "target/x86_64-linux-android/release/libisar.so" "../../libisar_android_x64.so"
    # Check workspace root target directory  
    elif [ -f "../../target/x86_64-linux-android/release/libisar.so" ]; then
      echo "Found library in workspace root target directory"
      mv "../../target/x86_64-linux-android/release/libisar.so" "../../libisar_android_x64.so"
    else
      echo "ERROR: Library not found in either location"
      echo "Local target contents:"
      ls -la target/ 2>/dev/null || echo "No local target directory"
      echo "Workspace target contents:"
      ls -la ../../target/ 2>/dev/null || echo "No workspace target directory"
      exit 1
    fi
    echo "Library moved successfully"
  else
    echo "ERROR: cargo build failed with exit code $?"
    exit 1
  fi
elif [ "$1" = "armv7" ]; then
  rustup target add armv7-linux-androideabi
  cargo build --target armv7-linux-androideabi --release
  
  # Check both possible locations for the library
  if [ -f "target/armv7-linux-androideabi/release/libisar.so" ]; then
    mv "target/armv7-linux-androideabi/release/libisar.so" "../../libisar_android_armv7.so"
  elif [ -f "../../target/armv7-linux-androideabi/release/libisar.so" ]; then
    mv "../../target/armv7-linux-androideabi/release/libisar.so" "../../libisar_android_armv7.so"
  else
    echo "ERROR: Library not found for armv7-linux-androideabi"
    exit 1
  fi
else
  rustup target add aarch64-linux-android
  cargo build --target aarch64-linux-android --release
  
  # Check both possible locations for the library
  if [ -f "target/aarch64-linux-android/release/libisar.so" ]; then
    mv "target/aarch64-linux-android/release/libisar.so" "../../libisar_android_arm64.so"
  elif [ -f "../../target/aarch64-linux-android/release/libisar.so" ]; then
    mv "../../target/aarch64-linux-android/release/libisar.so" "../../libisar_android_arm64.so"
  else
    echo "ERROR: Library not found for aarch64-linux-android"
    exit 1
  fi
fi






