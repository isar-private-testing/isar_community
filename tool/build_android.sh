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

echo "Current working directory: $(pwd)"
cd packages/isar_core_ffi
echo "Changed to: $(pwd)"

if [ "$1" = "x86" ]; then
  rustup target add i686-linux-android
  cargo build --target i686-linux-android --release
  echo "Build completed, checking files:"
  ls -la target/i686-linux-android/release/ | grep libisar || echo "No libisar.so found"
  # Check for different possible library names
  if [ -f "target/i686-linux-android/release/libisar.so" ]; then
    mv "target/i686-linux-android/release/libisar.so" "../../libisar_android_x86.so"
  else
    echo "ERROR: No library found, available files:"
    ls -la target/i686-linux-android/release/
    find target/i686-linux-android/release/ -name "*.so" || echo "No .so files found"
  fi
elif [ "$1" = "x64" ]; then
  rustup target add x86_64-linux-android
  cargo build --target x86_64-linux-android --release
  echo "Build completed, checking files:"
  ls -la target/x86_64-linux-android/release/ | grep libisar || echo "No libisar.so found"
  # Check for different possible library names
  if [ -f "target/x86_64-linux-android/release/libisar.so" ]; then
    mv "target/x86_64-linux-android/release/libisar.so" "../../libisar_android_x64.so"
  elif [ -f "target/x86_64-linux-android/release/libisar_core_ffi.so" ]; then
    mv "target/x86_64-linux-android/release/libisar_core_ffi.so" "../../libisar_android_x64.so"
  else
    echo "ERROR: No library found in target/x86_64-linux-android/release/"
    echo "Available files:"
    ls -la target/x86_64-linux-android/release/
    echo "Looking for any .so files:"
    find target/x86_64-linux-android/release/ -name "*.so" || echo "No .so files found"
  fi
elif [ "$1" = "armv7" ]; then
  rustup target add armv7-linux-androideabi
  cargo build --target armv7-linux-androideabi --release
  echo "Build completed, checking files:"
  ls -la target/armv7-linux-androideabi/release/ | grep libisar || echo "No libisar.so found"
  # Check for different possible library names
  if [ -f "target/armv7-linux-androideabi/release/libisar.so" ]; then
    mv "target/armv7-linux-androideabi/release/libisar.so" "../../libisar_android_armv7.so"
  else
    echo "ERROR: No library found, available files:"
    ls -la target/armv7-linux-androideabi/release/
    find target/armv7-linux-androideabi/release/ -name "*.so" || echo "No .so files found"
  fi
else
  rustup target add aarch64-linux-android
  cargo build --target aarch64-linux-android --release
  echo "Build completed, checking files:"
  ls -la target/aarch64-linux-android/release/ | grep libisar || echo "No libisar.so found"
  # Check for different possible library names
  if [ -f "target/aarch64-linux-android/release/libisar.so" ]; then
    mv "target/aarch64-linux-android/release/libisar.so" "../../libisar_android_arm64.so"
  else
    echo "ERROR: No library found, available files:"
    ls -la target/aarch64-linux-android/release/
    find target/aarch64-linux-android/release/ -name "*.so" || echo "No .so files found"
  fi
fi






