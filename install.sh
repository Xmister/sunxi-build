#!/bin/bash
ADB=~/bin/android-sdk-linux/platform-tools/adb
${ADB} disconnect
${ADB} kill-server
${ADB} connect cubie
${ADB} shell mount -o remount,rw /system
cd /home/xmister/Cubie
${ADB} push build/android /system/vendor/modules
${ADB} shell chmod 0755 /system/vendor/modules/*
${ADB} shell mount -o remount,ro /system
${ADB} push packing/boot.img /cache/boot.img
${ADB} shell dd if=/cache/boot.img of=/dev/block/nandc
