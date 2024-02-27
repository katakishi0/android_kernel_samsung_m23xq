#!/bin/bash

export ARCH=arm64
export PROJECT_NAME=m23xq
export CROSS_COMPILE=${HOME}/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CC=${HOME}/linux-x86/clang-r416183b/bin/clang
export CLANG_TRIPLE=aarch64-linux-gnu-
export DTC_EXT=$(pwd)/tools/dtc

make -j$(nproc --all) -C $(pwd) O=$(pwd)/out vendor/m23xq_eur_open_defconfig REAL_CC=$CC
make -j$(nproc --all) -C $(pwd) O=$(pwd)/out REAL_CC=$CC

$(pwd)/tools/mkdtimg create $(pwd)/out/arch/arm64/boot/dtbo.img --page_size=4096 $(find out/arch/arm64/boot/dts/samsung/m23/m23xq/ -name *.dtbo)