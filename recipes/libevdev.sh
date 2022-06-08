# Build libevdev v1.12.1


do_return_version_libevdev() {
  echo "libevdev v1.12.1"
}


do_return_depends_libevdev() {
  :
}


do_clean_libevdev() {
  rm -rf "${PACKAGES_DIR}/libevdev/build"
}


do_fetch_libevdev() {
  msg="Cloning libevdev"
  clone_and_checkout "${PACKAGES_DIR}/libevdev" "libevdev-1.12.1" "https://gitlab.freedesktop.org/libevdev/libevdev.git" "8ced382eb800ce01da1d6a9b9da2f1159f9042e0" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_libevdev() {
  :
}


do_configure_libevdev() {
  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        -Dtests="disabled" \
        -Ddocumentation="disabled" \
        "${PACKAGES_DIR}/libevdev/build" \
        "${PACKAGES_DIR}/libevdev" || return $FAILURE

  return $SUCCESS
}


do_compile_libevdev() {
  ninja -j $BUILDTHREADS -C "${PACKAGES_DIR}/libevdev/build" || return $FAILURE
  return $SUCCESS
}


do_install_libevdev() {
  ninja install -C "${PACKAGES_DIR}/libevdev/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_libevdev() {
  :
}


do_check_is_built_libevdev() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/libevdev.pc" ]] && return $SUCCESS
  return $FAILURE
}
