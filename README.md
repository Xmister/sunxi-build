sunxi-build
===========

Build system for linux-sunxi

1. Update all your path in build.sh, repack.sh, and install.sh
1.a If you have cubie with USB adb then remove the adb connect from install.sh
2. Now you should have a structure like:
```shell
    |
    |--build.sh
    |--repack.sh
    |--install.sh
    |--linux-sunxi/
```
4. Use cubie config:
```shell
  cd linux-sunxi
  cp arch/arm/configs/cubieboard_defconfig ./.config
```
3. Build kernel
```shell
  ./build.sh
```
4. If it was successful, repack it:
```shell
  ./repack.sh
```
5. And install to device:
```shell
  ./install.sh
```
