# Build vulkan-tools v1.3.213


do_return_version_vulkan-tools() {
  echo "vulkan-tools v1.3.213"
}


do_return_depends_vulkan-tools() {
  echo "wayland wayland-protocols xcb x11 xext vulkan-headers vulkan-loader"
}


do_clean_vulkan-tools() {
  rm -rf "${PACKAGES_DIR}/vulkan-tools/build"
}


do_fetch_vulkan-tools() {
  msg="Cloning vulkan-tools"
  clone_and_checkout "${PACKAGES_DIR}/vulkan-tools" "v1.3.213" "https://github.com/KhronosGroup/Vulkan-Tools.git" "fe5067838521f94f98f247b08bbdbeed812e4374" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_vulkan-tools() {
  :
}


do_configure_vulkan-tools() {
  cmake -G "${CMAKGENTYPE}" \
        -S "${PACKAGES_DIR}/vulkan-tools" \
        -B "${PACKAGES_DIR}/vulkan-tools/build" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

  return $SUCCESS
}


do_compile_vulkan-tools() {
  cmake --build "${PACKAGES_DIR}/vulkan-tools/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_vulkan-tools() {
  cmake --build "${PACKAGES_DIR}/vulkan-tools/build" --target install || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_vulkan-tools() {
  :
}


do_check_is_built_vulkan-tools() {
  [[ -f "${INSTALLPREFIX}/bin/vulkaninfo" ]] && return $SUCCESS
  return $FAILURE
}
