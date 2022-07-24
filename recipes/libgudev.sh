# Build libgudev v1.0


do_return_version_libgudev() {
  echo "libgudev v1.0"
}


do_return_depends_libgudev() {
  :
}


do_clean_libgudev() {
  rm -rf "${PACKAGES_DIR}/libgudev/build"
}


do_fetch_libgudev() {
  msg="Cloning libgudev"
  clone_and_checkout "${PACKAGES_DIR}/libgudev" "237" "https://gitlab.gnome.org/GNOME/libgudev.git" "dff7a794e55d6ad7a10e8edacd73aa047593e74c" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_libgudev() {
  :
}


do_configure_libgudev() {
  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        -Dtests="disabled" \
        -Dvapi="disabled" \
        "${PACKAGES_DIR}/libgudev/build" \
        "${PACKAGES_DIR}/libgudev" || return $FAILURE

  return $SUCCESS
}


do_compile_libgudev() {
  meson compile -C "${PACKAGES_DIR}/libgudev/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_libgudev() {
  meson install -C "${PACKAGES_DIR}/libgudev/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_libgudev() {
  :
}


do_check_is_built_libgudev() {
  [[ -f "${INSTALLPREFIX}/lib/libgudev-1.0.so" ]] && return $SUCCESS
  return $FAILURE
}
