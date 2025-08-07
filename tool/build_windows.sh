#!/bin/bash

# Definir a toolchain específica
RUST_TOOLCHAIN="1.88.0-x86_64-unknown-linux-gnu"

if [ "$1" = "x64" ]; then
  echo "Building for Windows x64"
  rustc --version
  cargo --version
  rustup target add x86_64-pc-windows-msvc --toolchain $RUST_TOOLCHAIN
  rustup run $RUST_TOOLCHAIN cargo build --target x86_64-pc-windows-msvc --release
  cp "target/x86_64-pc-windows-msvc/release/isar.dll" "isar_windows_x64.dll"
else
  echo "Building for Windows arm64"
  rustc --version
  cargo --version
  rustup target add aarch64-pc-windows-msvc --toolchain $RUST_TOOLCHAIN
  rustup run $RUST_TOOLCHAIN cargo build --target aarch64-pc-windows-msvc --release
  cp "target/aarch64-pc-windows-msvc/release/isar.dll" "isar_windows_arm64.dll"
fi