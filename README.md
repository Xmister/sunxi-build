sunxi-build
===========

Build system for linux-sunxi

1. Update all your path in build.sh, repack.sh, and install.sh
1.a If you have cubie with USB adb then remove the adb connect from install.sh
2. Now you should have a structure like:
    |
    |--build.sh
    |--repack.sh
    |--install.sh
    |--linux-sunxi/
4. Use cubie config:
  cd linux-sunxi
  cp arch/arm/configs/cubieboard_defconfig ./.config
3. Build kernel
  ./build.sh
4. If it was successful, repack it:
  ./repack.sh
5. And install to device:
  ./install.sh
