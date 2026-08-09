#
# Copyright (C) 2021 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/pipa

# Inherit from sm8250-common
include device/xiaomi/sm8250-common/BoardConfigCommon.mk

# Board
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# Display
TARGET_SCREEN_DENSITY := 400

# ---------------------------------------------------------
# Kernel & Boot (修复掉 Fastboot 的核心配置)
# ---------------------------------------------------------
BOARD_BOOT_HEADER_VERSION := 3
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# 强制打包 DTB 和独立的 DTBO，防止 Bootloader 拒绝引导
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true

TARGET_KERNEL_SOURCE := kernel/xiaomi/sm8250
# 使用体积较小（约 20kb）的 user_config，避免编译时内存溢出导致内核损坏
TARGET_KERNEL_CONFIG := pipa_user_config

# 完整的启动参数 (CMDLINE)
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=2048 loop.max_part=7 cgroup.memory=nokmem,nosocket reboot=panic_warm
BOARD_KERNEL_CMDLINE += androidboot.fstab_suffix=qcom
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery
BOARD_KERNEL_CMDLINE += kpti=off

# ---------------------------------------------------------
# Partitions & A/B (修复卡米和挂载崩溃的关键配置)
# ---------------------------------------------------------
BOARD_BOOTIMAGE_PARTITION_SIZE := 201326592
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 33554432

BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := product system system_ext odm vendor
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200

BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
AB_OTA_UPDATER := true

# ---------------------------------------------------------
# Properties & Sepolicy
# ---------------------------------------------------------
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Wi-Fi
SOONG_CONFIG_XIAOMI_KONA_WIFI_SYMLINK_VERSION := v2

# Inherit from the proprietary version
include vendor/xiaomi/pipa/BoardConfigVendor.mk
