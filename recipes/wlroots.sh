# Build wlroots v0.17.1-dev


do_return_version_wlroots() {
  echo "wlroots v0.17.1-dev"
}


do_return_depends_wlroots() {
  echo "wayland wayland-protocols vulkan-loader libdrm mesa xkbcommon pixman libinput seatd xcb-render-util"
}


do_clean_wlroots() {
  rm -rf "${PACKAGES_DIR}/wlroots/build"
}


do_fetch_wlroots() {
  msg="Cloning wlroots"
  clone_and_checkout "${PACKAGES_DIR}/wlroots" "master" "https://gitlab.freedesktop.org/wlroots/wlroots.git" "5f264a7d6c8af27d41ff440c05262b022c055593" "${msg}" || return $FAILURE
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
        -Dbackends="drm,libinput,x11" \
        "${PACKAGES_DIR}/wlroots/build" \
        "${PACKAGES_DIR}/wlroots" || return $FAILURE

  return $SUCCESS
}


do_compile_wlroots() {
  meson compile -C "${PACKAGES_DIR}/wlroots/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_wlroots() {
  meson install -C "${PACKAGES_DIR}/wlroots/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_wlroots() {
  :
}


do_check_is_built_wlroots() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/wlroots.pc" ]] && return $SUCCESS
  return $FAILURE
}
