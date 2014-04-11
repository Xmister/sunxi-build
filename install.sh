#!/bin/bash
ADB=~/bin/android-sdk-linux/platform-tools/adb
${ADB} disconnect
${ADB} kill-server
${ADB} connect cubie
sleep 2
${ADB} shell mount -o remount,rw /system
cd /home/xmister/Cubie
${ADB} shell busybox rm -rf /system/vendor/modules/*
${ADB} push build/android /system/vendor/modules
${ADB} shell chmod 0755 /system/vendor/modules/*
${ADB} shell mount -o remount,ro /system
exec ./install-kernel.sh
