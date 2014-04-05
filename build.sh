#!/bin/bash
KBE_PATH=/home/xmister/Cubie
KERNEL_DIR=linux-sunxi
KERNEL_PATH=${KBE_PATH}/${KERNEL_DIR}
TOOLCHAIN=/usr/bin/arm-linux-gnueabi-
BUILD_DIR=build
BUILD_LOG="../build.log"
NUM_THREADS=6
MAKE="make ARCH=arm CROSS_COMPILE=$TOOLCHAIN"
cd $KBE_PATH
cd $KERNEL_PATH
mv $BUILD_LOG ${BUILD_LOG}.old
echo "Initializing build..."
make clean >> $BUILD_LOG 2>&1
${MAKE} clean >> $BUILD_LOG 2>&1
echo "Building kernel..."
${MAKE} -j$NUM_THREADS uImage modules >> $BUILD_LOG 2>&1 &
MPID=$!
cd ..
watch -n1 tail build.log &
WPID=$!
wait $MPID
kill $WPID
cd ${KERNEL_PATH}/modules/mali
export MAKE
export KERNEL_PATH
${MAKE}
cd ${KERNEL_PATH}/modules/nand
${MAKE}
echo "Saving binaries..."
cd $KERNEL_PATH
rm -rf $BUILD_DIR
mkdir $BUILD_DIR
cd $KERNEL_DIR
${TOOLCHAIN}objcopy -R .note.gnu.build-id -S -O binary vmlinux ../$BUILD_DIR/bImage
cd ..
cp -f $KERNEL_DIR/arch/arm/boot/zImage $BUILD_DIR/
cp -f $KERNEL_DIR/arch/arm/boot/uImage $BUILD_DIR/
if [ $? -ne 0 ]; then
	exit
fi
cd $KERNEL_DIR
MOD_DIR=../$BUILD_DIR
rm -rf $MOD_DIR/android
rm -rf $MOD_DIR/lib
mkdir -p $MOD_DIR/android
for file in $(find drivers sound crypto block fs security net modules -name "*.ko"); do
	cp -f $file ${MOD_DIR}/android/
done
${MAKE} INSTALL_MOD_PATH=$MOD_DIR modules_install
echo "Build done."
