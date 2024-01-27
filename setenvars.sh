#!/bin/bash

UNDERVIEW_BUILD_OUTPUT_DIR="$(pwd)/working/build_output"
UNDERVIEW_PACKAGES_DIR="$(pwd)/working/packages"
export PKG_CONFIG_PATH="${UNDERVIEW_BUILD_OUTPUT_DIR}/lib/pkgconfig:${PKG_CONFIG_PATH}"
export LIBGL_DRIVERS_PATH="${UNDERVIEW_BUILD_OUTPUT_DIR}/lib/dri"
export LD_LIBRARY_PATH="${UNDERVIEW_BUILD_OUTPUT_DIR}/lib:${LD_LIBRARY_PATH}"
export PATH="${UNDERVIEW_BUILD_OUTPUT_DIR}/bin:${UNDERVIEW_BUILD_OUTPUT_DIR}/sbin:${PATH}"
export NS_CONFIG_PATH="${UNDERVIEW_PACKAGES_DIR}/monado/src/xrt/drivers/north_star/exampleconfigs/v2_deckx_50cm.json"
VK_DRIVER_FILES="${UNDERVIEW_BUILD_OUTPUT_DIR}/share/vulkan/icd.d/radeon_icd.x86_64.json"
VK_DRIVER_FILES="$VK_DRIVER_FILES:${UNDERVIEW_BUILD_OUTPUT_DIR}/share/vulkan/icd.d/intel_icd.x86_64.json"
export VK_DRIVER_FILES="$VK_DRIVER_FILES:${UNDERVIEW_BUILD_OUTPUT_DIR}/share/vulkan/icd.d/lvp_icd.x86_64.json"
export VK_LAYER_PATH="${UNDERVIEW_BUILD_OUTPUT_DIR}/share/vulkan/explicit_layer.d"
