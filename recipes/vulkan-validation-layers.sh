# Build vulkan-validation-layers v1.3.212


do_return_version_vulkan-validation-layers() {
  echo "vulkan-validation-layers v1.3.212"
}


do_return_depends_vulkan-validation-layers() {
  echo "vulkan-headers spirv-headers spirv-tools robin-hood-hashing"
}


do_clean_vulkan-validation-layers() {
  rm -rf "${PACKAGES_DIR}/vulkan-validation-layers/build"
}


do_fetch_vulkan-validation-layers() {
  msg="Cloning Vulkan-ValidationLayers"
  clone_and_checkout "${PACKAGES_DIR}/vulkan-validation-layers" "v1.3.212" "https://github.com/KhronosGroup/Vulkan-ValidationLayers.git" "42277168e8cd9a6f844de55714841b59196dc598" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_vulkan-validation-layers() {
  :
}


do_configure_vulkan-validation-layers() {
  cmake -G "${CMAKGENTYPE}" \
        -S "${PACKAGES_DIR}/vulkan-validation-layers" \
        -B "${PACKAGES_DIR}/vulkan-validation-layers/build" \
        -DVulkanRegistry_DIR="${INSTALLPREFIX}/share/vulkan/registry" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

  return $SUCCESS
}


do_compile_vulkan-validation-layers() {
  cmake --build "${PACKAGES_DIR}/vulkan-validation-layers/build" --config Release -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_vulkan-validation-layers() {
  cmake --build "${PACKAGES_DIR}/vulkan-validation-layers/build" --config Release --target install || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_vulkan-validation-layers() {
  :
}


do_check_is_built_vulkan-validation-layers() {
  [[ -f "${INSTALLPREFIX}/share/vulkan/explicit_layer.d/VkLayer_khronos_validation.json" ]] && return $SUCCESS
  return $FAILURE
}
