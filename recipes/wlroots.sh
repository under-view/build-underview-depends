# Build wlroots v0.15.1


do_return_version_wlroots() {
  echo "wlroots v0.15.1"
}


do_return_depends_wlroots() {
  echo "wayland wayland-protocols vulkan-loader libdrm mesa xkbcommon pixman libinput seatd"
}


do_clean_wlroots() {
  rm -rf "${PACKAGES_DIR}/wlroots/build"
}


do_fetch_wlroots() {
  msg="Cloning wlroots"
  clone_and_checkout "${PACKAGES_DIR}/wlroots" "0.15.1" "https://gitlab.freedesktop.org/wlroots/wlroots.git" "29938b74251e826f3778f6bf9c54974a30488cc1" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_wlroots() {
  :
}


do_configure_wlroots() {
  meson setup \
        --prefix="$INSTALLPREFIX" \
        --libdir="${INSTALLPREFIX}/lib" \
        "${PACKAGES_DIR}/wlroots/build" \
        "${PACKAGES_DIR}/wlroots" || return $FAILURE

  return $SUCCESS
}


do_compile_wlroots() {
  ninja -j $BUILDTHREADS -C "${PACKAGES_DIR}/wlroots/build" || return $FAILURE
  return $SUCCESS
}


do_install_wlroots() {
  ninja install -C "${PACKAGES_DIR}/wlroots/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_wlroots() {
  :
}


do_check_is_built_wlroots() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/wlroots.pc" ]] && return $SUCCESS
  return $FAILURE
}
