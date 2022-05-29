# Build seatd v0.7.0


do_return_version_seatd() {
  echo "seatd v0.7.0"
}


do_return_depends_seatd() {
  :
}


do_clean_seatd() {
  rm -rf "${PACKAGES_DIR}/seatd/build"
}


do_fetch_seatd() {
  msg="Cloning seatd"
  clone_and_checkout "${PACKAGES_DIR}/seatd" "0.7.0" "https://github.com/kennylevinsen/seatd.git" "a803ba0502cccf147eec7fbcacd11c5b8643c0e0" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_seatd() {
  :
}


do_configure_seatd() {
  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        -Dwerror="false" \
        -Dman-pages="disabled" -Dexamples="disabled" \
        "${PACKAGES_DIR}/seatd/build" \
        "${PACKAGES_DIR}/seatd" || return $FAILURE

  return $SUCCESS
}


do_compile_seatd() {
  ninja -j $BUILDTHREADS -C "${PACKAGES_DIR}/seatd/build" || return $FAILURE
  return $SUCCESS
}


do_install_seatd() {
  ninja install -C "${PACKAGES_DIR}/seatd/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_seatd() {
  :
}


do_check_is_built_seatd() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/libseat.pc" ]] && return $SUCCESS
  return $FAILURE
}
