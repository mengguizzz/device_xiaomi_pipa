#
# Copyright (C) 2021-2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

TARGET_IS_VAB := true
TARGET_IS_TABLET := true

# Inherit from sm8250-common
$(call inherit-product, device/xiaomi/sm8250-common/kona.mk)

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Audio configs
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

# Boot animation (横屏平板专属方向配置)
TARGET_SCREEN_HEIGHT := 2880
TARGET_SCREEN_WIDTH := 1800
TARGET_BOOT_ANIMATION_RES := 1080
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.bootanim.set_orientation_logical_0=ORIENTATION_270

# Camera
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/camera/camera_cnf.txt:$(TARGET_COPY_OUT_VENDOR)/etc/camera/camera_cnf.txt

PRODUCT_PACKAGES += \
    libpiex_shim

# Display
PRODUCT_VENDOR_PROPERTIES += \
    debug.graphics.game_default_frame_rate.disabled=1 \

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

# =========================================================
# 平板专属外设与影音 (从完整的 Lineage 树补回)
# =========================================================
# 1. 磁吸键盘与智能保护壳支持
PRODUCT_PACKAGES += \
    XiaomiPeripheralManager

# 2. 触控笔与键盘的按键映射及 IDC 配置文件
PRODUCT_PACKAGES += \
    Xiaomi_Smart_Pen_Keyboard.kl \
    kona-mtp-snd-card_Button_Jack.kl \
    Xiaomi_Keyboard.idc

# 3. 杜比音效与设备专属设置 (XiaomiParts)
PRODUCT_PACKAGES += \
    XiaomiDolby \
    XiaomiParts \
    DSPVolumeSynchronizer

# 4. 杜比音效 Vendor 属性激活
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.dolby.dax.version=DAX3_3.6.1.6_r1 \
    ro.vendor.audio.dolby.dax.version=DAX3_3.6 \
    ro.vendor.audio.dolby.dax.support=true \
    ro.vendor.audio.dolby.surround.enable=true
# =========================================================

# Permissions (平板自由窗口与画中画权限)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.freeform_window_management.xml \
    frameworks/native/data/etc/android.software.picture_in_picture.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.picture_in_picture.xml

# Rootdir
PRODUCT_PACKAGES += \
    fstab.qcom \
    fstab.qcom.vendor_ramdisk \
    init.device.rc

PRODUCT_SHIPPING_API_LEVEL := 33

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# WiFi
PRODUCT_PACKAGES += \
    TargetWifiOverlay

# Inherit from vendor blobs
$(call inherit-product, vendor/xiaomi/pipa/pipa-vendor.mk)
