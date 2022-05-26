# Build libdrm 2.4.109


do_return_version_libdrm() {
  echo "libdrm 2.4.109"
}


do_return_depends_libdrm() {
  echo "zlib pciaccess"
}


do_clean_libdrm() {
  rm -rf "${PACKAGES_DIR}/libdrm/build"
}


do_fetch_libdrm() {
  msg="Cloning mesa drm (libdrm)"
  clone_and_checkout "${PACKAGES_DIR}/libdrm" "libdrm-2.4.109" "https://gitlab.freedesktop.org/mesa/drm" "febfe0addd51a48c7c9dd7fd9ddf9b5a3b5cd7c6" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_libdrm() {
  :
}


do_configure_libdrm() {
  meson setup \
        --prefix="$INSTALLPREFIX" \
        --libdir="${INSTALLPREFIX}/lib" \
        "${PACKAGES_DIR}/libdrm/build" \
        "${PACKAGES_DIR}/libdrm" || return $FAILURE

  return $SUCCESS
}


do_compile_libdrm() {
  ninja -j $BUILDTHREADS -C "${PACKAGES_DIR}/libdrm/build" || return $FAILURE
  return $SUCCESS
}


do_install_libdrm() {
  ninja install -C "${PACKAGES_DIR}/libdrm/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_libdrm() {
  :
}


do_check_is_built_libdrm() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/libdrm.pc" ]] && return $SUCCESS
  return $FAILURE
}
