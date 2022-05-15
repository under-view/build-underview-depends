# Build wayland 1.20.0


do_return_version_wayland() {
  echo "wayland v1.20.0"
}


do_return_depends_wayland() {
  echo "libffi"
}


do_clean_wayland() {
  rm -rf "${PACKAGES_DIR}/wayland/build"
}


do_fetch_wayland() {
  msg="Cloning wayland"
  clone_and_checkout "${PACKAGES_DIR}/wayland" "1.20.0" "https://gitlab.freedesktop.org/wayland/wayland.git" "75c1a93e2067220fa06208f20f8f096bb463ec08" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_wayland() {
  :
}


do_configure_wayland() {
  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        -Ddocumentation=false \
        -Dtests=false \
        -Ddtd_validation=false \
        "${PACKAGES_DIR}/wayland/build" \
        "${PACKAGES_DIR}/wayland" || return $FAILURE

  return $SUCCESS
}


do_compile_wayland() {
  ninja -j $BUILDTHREADS -C "${PACKAGES_DIR}/wayland/build" || return $FAILURE
  return $SUCCESS
}


do_install_wayland() {
  ninja install -C "${PACKAGES_DIR}/wayland/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_wayland() {
  :
}


do_check_is_built_wayland() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/wayland-client.pc" ]] && return $SUCCESS
  return $FAILURE
}
