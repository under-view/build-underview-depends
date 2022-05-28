# Build pixman v0.40.0


do_return_version_pixman() {
  echo "pixman v0.40.0"
}


do_return_depends_pixman() {
  :
}


do_clean_pixman() {
  make clean -C "${PACKAGES_DIR}/pixman"
}


do_fetch_pixman() {
  msg="Cloning pixman"
  clone_and_checkout "${PACKAGES_DIR}/pixman" "pixman-0.40.0" "https://gitlab.freedesktop.org/pixman/pixman" "244383bf9f3493c014985de46876e40fd5db43f3" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_pixman() {
  :
}


do_configure_pixman() {
  cd "${PACKAGES_DIR}/pixman"
  ./autogen.sh --prefix="$INSTALLPREFIX" --disable-gtk || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_pixman() {
  make -j $BUILDTHREADS -C "${PACKAGES_DIR}/pixman" || return $FAILURE
  return $SUCCESS
}


do_install_pixman() {
  make install -C "${PACKAGES_DIR}/pixman" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_pixman() {
  :
}


do_check_is_built_pixman() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/pixman-1.pc" ]] && return $SUCCESS
  return $FAILURE
}
