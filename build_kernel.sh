#!/bin/bash

rm -rf out
mkdir -p out

export CLANG_PATH=${HOME}/android_prebuilts_clang_kernel_linux-x86_clang-r416183b/bin
export PATH=${CLANG_PATH}:${PATH}
export CROSS_COMPILE=${HOME}/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=${HOME}/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export KERNEL_LLVM_BIN=${HOME}/android_prebuilts_clang_kernel_linux-x86_clang-r416183b/bin/clang
export LD_LIBRARY_PATH=${HOME}/android_prebuilts_clang_kernel_linux-x86_clang-r416183b/lib64:$LD_LIBRARY_PATH
export CLANG_TRIPLE=aarch64-linux-gnu-
export KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

make -j8 -C $(pwd) O=$(pwd)/out AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip $KERNEL_MAKE_ENV ARCH=arm64 CC=clang vendor/m23xq_eur_open_defconfig --no-print-directory

make -j8 -C $(pwd) O=$(pwd)/out AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip $KERNEL_MAKE_ENV ARCH=arm64 CC=clang --no-print-directory

$(pwd)/tools/mkdtimg create $(pwd)/out/arch/arm64/boot/dtbo.img --page_size=4096 $(find out/arch/arm64/boot/dts/samsung/m23/m23xq/ -name *.dtbo)