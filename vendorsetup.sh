#!/bin/bash
# Minimal vendorsetup.sh for Evolution X 12.1 (Android 17) - Xiaomi Pad 6 (pipa)

echo ">>> Fetching required hardware dependencies for sm8250..."

# 1. 克隆小米通用的硬件 HAL 库 (必须使用 A17 / lineage-24.0 分支)
if [ ! -d "hardware/xiaomi" ]; then
    echo "Cloning hardware/xiaomi..."
    git clone https://github.com/taoyao-aosp/android_hardware_xiaomi -b lineage-24.0 hardware/xiaomi
fi

# 2. 如果 EvoX 源码没有自带 Lineage 的 compat 依赖，则需要拉取
if [ ! -d "hardware/lineage/compat" ]; then
    echo "Cloning hardware/lineage/compat..."
    git clone https://github.com/LineageOS/android_hardware_lineage_compat.git -b lineage-24.0 hardware/lineage/compat
fi

echo ">>> Setup complete! Ready to build."
