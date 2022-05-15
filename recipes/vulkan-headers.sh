# Build vulkan-headers v1.3.213


do_return_version_vulkan-headers() {
  echo "vulkan-headers v1.3.213"
}


do_return_depends_vulkan-headers() {
  echo "zlib vulkan-headers"
}


do_clean_vulkan-headers() {
  rm -rf "${PACKAGES_DIR}/vulkan-headers/build"
}


do_fetch_vulkan-headers() {
  msg="Cloning vulkan-headers"
  clone_and_checkout "${PACKAGES_DIR}/vulkan-headers" "v1.3.213" "https://github.com/KhronosGroup/Vulkan-Headers.git" "33d4dd987fc8fc6475ff9ca2b4f0c3cc6e793337" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_vulkan-headers() {
  :
}


do_configure_vulkan-headers() {
  cmake -G "${CMAKGENTYPE}" \
        -S "${PACKAGES_DIR}/vulkan-headers" \
        -B "${PACKAGES_DIR}/vulkan-headers/build" \
        -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

  return $SUCCESS
}


do_compile_vulkan-headers() {
  cmake --build "${PACKAGES_DIR}/vulkan-headers/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_vulkan-headers() {
  cmake --build "${PACKAGES_DIR}/vulkan-headers/build" --target install || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_vulkan-headers() {
  :
}


do_check_is_built_vulkan-headers() {
  [[ -f "${INSTALLPREFIX}/include/vulkan/vulkan.h" ]] && return $SUCCESS
  return $FAILURE
}
