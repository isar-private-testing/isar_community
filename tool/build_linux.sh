if [ "$1" = "x64" ]; then
  echo "Building for Linux x64 with fixed Rust 1.88.0"
  rustup target add x86_64-unknown-linux-gnu --toolchain 1.88.0-x86_64-unknown-linux-gnu
  rustup run 1.88.0-x86_64-unknown-linux-gnu rustc --version
  rustup run 1.88.0-x86_64-unknown-linux-gnu cargo --version
  rustup run 1.88.0-x86_64-unknown-linux-gnu cargo build --target x86_64-unknown-linux-gnu --release
  mv "target/x86_64-unknown-linux-gnu/release/libisar.so" "libisar_linux_x64.so"
else
  echo "Building for Linux arm64 with fixed Rust 1.88.0"
  rustup target add aarch64-unknown-linux-gnu --toolchain 1.88.0-aarch64-unknown-linux-gnu
  rustup run 1.88.0-aarch64-unknown-linux-gnu rustc --version
  rustup run 1.88.0-aarch64-unknown-linux-gnu cargo --version
  rustup run 1.88.0-aarch64-unknown-linux-gnu cargo build --target aarch64-unknown-linux-gnu --release
  mv "target/aarch64-unknown-linux-gnu/release/libisar.so" "libisar_linux_arm64.so"
fi