#!/bin/bash
#now=$(date +"%Y%m%d_%H%M")
now=$(cat /home/xmister/Cubie/linux-sunxi/.version)
cd /home/xmister/Cubie/build
cp -f android/nand.ko ../packing/ramdisk/
cp -f *Image* ../packing
cd ../packing
rm boot.img
cd ..
mkboot packing packing/boot.img
#mkbootimg --kernel bImage \
        --ramdisk rootfs.cpio.gz \
        --board 'cubieboard' \
        --base 0x40000000 \
        -o boot.img
