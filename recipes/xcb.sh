# Build xcb 1.14


do_return_version_xcb() {
  echo "xcb v1.14"
}


do_return_depends_xcb() {
  echo "xorg-macros xcbproto xdmcp xau"
}


do_clean_xcb() {
  make clean -C "${PACKAGES_DIR}/xcb"
}


do_fetch_xcb() {
  msg="Cloning libxcb"
  clone_and_checkout "${PACKAGES_DIR}/xcb" "libxcb-1.14" "https://gitlab.freedesktop.org/xorg/lib/libxcb.git" "4b40b44cb6d088b6ffa2fb5cf3ad8f12da588cef" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_xcb() {
  :
}


do_configure_xcb() {
  cd "${PACKAGES_DIR}/xcb"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_xcb() {
  make -C "${PACKAGES_DIR}/xcb" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_xcb() {
  make install -C "${PACKAGES_DIR}/xcb" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_xcb() {
  :
}


do_check_is_built_xcb() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/xcb.pc" ]] && return $SUCCESS
  return $FAILURE
}
