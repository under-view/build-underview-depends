# Build xorg-font-util v1.3.2


do_return_version_xorg-font-util() {
  echo "xorg-font-util v1.3.2"
}


do_return_depends_xorg-font-util() {
  echo "xorg-macros"
}


do_clean_xorg-font-util() {
  make clean -C "${PACKAGES_DIR}/xorg-font-util"
}


do_fetch_xorg-font-util() {
  msg="Cloning xorg-font-util"
  clone_and_checkout "${PACKAGES_DIR}/xorg-font-util" "font-util-1.3.2" "https://gitlab.freedesktop.org/xorg/font/util.git" "d45011b8324fecebb4fc79e57491d341dd96e325" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_xorg-font-util() {
  :
}


do_configure_xorg-font-util() {
  cd "${PACKAGES_DIR}/xorg-font-util"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_xorg-font-util() {
  make -C "${PACKAGES_DIR}/xorg-font-util" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_xorg-font-util() {
  make install -C "${PACKAGES_DIR}/xorg-font-util" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_xorg-font-util() {
  :
}


do_check_is_built_xorg-font-util() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/fontutil.pc" ]] && return $SUCCESS
  return $FAILURE
}
