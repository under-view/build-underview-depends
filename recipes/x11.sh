# Build X11 1.7.5


do_return_version_x11() {
  echo "X11 v1.7.5"
}


do_return_depends_x11() {
  echo "xorg-macros x11proto xtrans xdmcp xau xcb"
}


do_clean_x11() {
  make clean -C "${PACKAGES_DIR}/x11"
}


do_fetch_x11() {
  msg="Cloning libX11"
  clone_and_checkout "${PACKAGES_DIR}/x11" "libX11-1.7.5" "https://gitlab.freedesktop.org/xorg/lib/libx11.git" "9ac6859c20be2fc5e70c2908de60c6e466ec04e1" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_x11() {
  :
}


do_configure_x11() {
  cd "${PACKAGES_DIR}/x11"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_x11() {
  make -j $BUILDTHREADS -C "${PACKAGES_DIR}/x11" || return $FAILURE
  return $SUCCESS
}


do_install_x11() {
  make install -C "${PACKAGES_DIR}/x11" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_x11() {
  :
}


do_check_is_built_x11() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/x11-xcb.pc" ]] && return $SUCCESS
  return $FAILURE
}
