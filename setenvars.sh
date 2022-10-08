#!/bin/bash

UNDERVIEW_BUILD_OUTPUT_DIR="$(pwd)/working/build_output"
UNDERVIEW_PACKAGES_DIR="$(pwd)/working/packages"
export PKG_CONFIG_PATH="${UNDERVIEW_BUILD_OUTPUT_DIR}/lib/pkgconfig:${PKG_CONFIG_PATH}"
export LIBGL_DRIVERS_PATH="${UNDERVIEW_BUILD_OUTPUT_DIR}/lib/dri"
export LD_LIBRARY_PATH="${UNDERVIEW_BUILD_OUTPUT_DIR}/lib:${LD_LIBRARY_PATH}"
export VK_LAYER_PATH="${UNDERVIEW_BUILD_OUTPUT_DIR}/share/vulkan/explicit_layer.d"
export PATH="${UNDERVIEW_BUILD_OUTPUT_DIR}/bin:${PATH}"
export NS_CONFIG_PATH="${UNDERVIEW_PACKAGES_DIR}/monado/src/xrt/drivers/north_star/exampleconfigs/v2_deckx_50cm.json"
