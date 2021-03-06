# Build wayland-protocols 1.25


do_return_version_wayland-protocols() {
  echo "wayland-protocols v1.25"
}


do_return_depends_wayland-protocols() {
  echo "wayland"
}


do_clean_wayland-protocols() {
  rm -rf "${PACKAGES_DIR}/wayland-protocols/build"
}


do_fetch_wayland-protocols() {
  msg="Cloning wayland-protocols"
  clone_and_checkout "${PACKAGES_DIR}/wayland-protocols" "1.26" "https://gitlab.freedesktop.org/wayland/wayland-protocols.git" "83866f19d3d61b28e94d71781646466b3a6623d8" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_wayland-protocols() {
  :
}


do_configure_wayland-protocols() {
  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        "${PACKAGES_DIR}/wayland-protocols/build" \
        "${PACKAGES_DIR}/wayland-protocols" || return $FAILURE

  return $SUCCESS
}


do_compile_wayland-protocols() {
  meson compile -C "${PACKAGES_DIR}/wayland-protocols/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_wayland-protocols() {
  meson install -C "${PACKAGES_DIR}/wayland-protocols/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_wayland-protocols() {
  mv "${INSTALLPREFIX}/share/pkgconfig/wayland-protocols.pc" "${INSTALLPREFIX}/lib/pkgconfig"
  rm -rf "${INSTALLPREFIX}/share/pkgconfig"
  return $SUCCESS
}


do_check_is_built_wayland-protocols() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/wayland-protocols.pc" ]] && return $SUCCESS
  return $FAILURE
}
