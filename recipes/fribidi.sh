# Build fribidi 1.0.11


do_return_version_fribidi() {
  echo "fribidi v1.0.11"
}


do_return_depends_fribidi() {
  :
}


do_clean_fribidi() {
  rm -rf "${PACKAGES_DIR}/fribidi/build"
}


do_fetch_fribidi() {
  msg="Cloning fribidi"
  clone_and_checkout "${PACKAGES_DIR}/fribidi" "v1.0.11" "https://github.com/fribidi/fribidi.git" "247fddc3599e3fe7b1b5cc21020c9eb51e662637" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_fribidi() {
  :
}


do_configure_fribidi() {
  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        -Ddocs=false \
        "${PACKAGES_DIR}/fribidi/build" \
        "${PACKAGES_DIR}/fribidi" || return $FAILURE

  return $SUCCESS
}


do_compile_fribidi() {
  meson compile -j $BUILDTHREADS -C "${PACKAGES_DIR}/fribidi/build" || return $FAILURE
  return $SUCCESS
}


do_install_fribidi() {
  meson install -C "${PACKAGES_DIR}/fribidi/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_fribidi() {
  :
}


do_check_is_built_fribidi() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/fribidi.pc" ]] && return $SUCCESS
  return $FAILURE
}
