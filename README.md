# Device tree for Xiaomi 12 (codename Cupid)


## Device specifications

| Device                  | Xiaomi 12                                              |
| ----------------------- | :---------------------------------------------------------- |
| SoC     		  | Qualcomm SM8450 Snapdragon 8 Gen 1 (4 nm)                            |
| CPU     		  | Octa-core (1x3.00 GHz Cortex-X2 & 3x2.50 GHz Cortex-A710 & 4x1.80 GHz Cortex-A510)|
| GPU     		  | Adreno 730                                               |
| Memory                  |  128GB 8GB RAM, 256GB 8GB RAM, 256GB 12GB RAM                                   |
| Shipped Android Version | 12 (MIUI 13)                                                |
| Storage                 | 128/256GB                                                   |                                                |
| Battery 		  | Li-Po 4500 mAh non-removable                               |
| Display 		  | AMOLED, 68B colors, 120Hz, Dolby Vision, HDR10+, 1100 nits (peak)|

## Device picture

![Xiaomi 12](https://fdn2.gsmarena.com/vv/pics/xiaomi/xiaomi-12-2.jpg "Xiaomi 12")

## Features

Works:

- [X] ADB
- [X] Decryption of /data (MIUI - 13)
- [X] Screen brightness settings
- [X] MTP
- [X] Flashing (roms, images and so on)
- [X] USB OTG
- [X] Fasbootd
- [X] Sideload (adb sideload update.zip)
- [X] Reboot to bootloader/recovery/system/fasbootd
- [X] F2FS/EXT4 Support
- [x] Vibration support

## Compile

First checkout minimal twrp with aosp tree:

```
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync
```

Then add these projects to .repo/manifest.xml:

```xml
<project path="device/xiaomi/cupid" name="yarpiin/twrp_device_xiaomi_cupid" remote="github" revision="android-12.1" />
```

Finally execute these:

```
. build/envsetup.sh
lunch twrp_cupid-eng
mka recoveryimage ALLOW_MISSING_DEPENDENCIES=true # Only if you use minimal twrp tree.

```
## To use it:

```
fastboot flash recovery out/target/product/cupid/recovery.img
