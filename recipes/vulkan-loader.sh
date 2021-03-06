# Build vulkan-loader v1.3.213


do_return_version_vulkan-loader() {
  echo "vulkan-loader v1.3.213"
}


do_return_depends_vulkan-loader() {
  echo "wayland wayland-protocols xcb x11 xext xrandr vulkan-headers"
}


do_clean_vulkan-loader() {
  rm -rf "${PACKAGES_DIR}/vulkan-loader/build"
}


do_fetch_vulkan-loader() {
  msg="Cloning vulkan-loader"
  clone_and_checkout "${PACKAGES_DIR}/vulkan-loader" "v1.3.213" "https://github.com/KhronosGroup/Vulkan-Loader.git" "5aa2ee48c9da55ff6682ff2e5802d60eb52dcf1f" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_vulkan-loader() {
  :
}


do_configure_vulkan-loader() {
  cmake -G "${CMAKGENTYPE}" \
        -S "${PACKAGES_DIR}/vulkan-loader" \
        -B "${PACKAGES_DIR}/vulkan-loader/build" \
        -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

  return $SUCCESS
}


do_compile_vulkan-loader() {
  cmake --build "${PACKAGES_DIR}/vulkan-loader/build" --config Release -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_vulkan-loader() {
  cmake --build "${PACKAGES_DIR}/vulkan-loader/build" --config Release --target install || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_vulkan-loader() {
  :
}


do_check_is_built_vulkan-loader() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/vulkan.pc" ]] && return $SUCCESS
  return $FAILURE
}
