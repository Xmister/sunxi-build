#!/bin/bash
ADB=~/bin/android-sdk-linux/platform-tools/adb
${ADB} connect cubie
sleep 2
cd /home/xmister/Cubie
${ADB} push packing/boot.img /cache/boot.img
${ADB} shell dd if=/cache/boot.img of=/dev/block/nandc
