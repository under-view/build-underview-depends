# Build xcb-ewmh v0.4.1


do_return_version_xcb-ewmh() {
  echo "xcb-ewmh v0.4.1"
}


do_return_depends_xcb-ewmh() {
  echo "xorg-macros xcbproto xdmcp xau"
}


do_clean_xcb-ewmh() {
  make clean -C "${PACKAGES_DIR}/xcb-ewmh"
}


do_fetch_xcb-ewmh() {
  msg="Cloning libxcb-ewmh"
  clone_and_checkout "${PACKAGES_DIR}/xcb-ewmh" "0.4.1" "https://gitlab.freedesktop.org/xorg/lib/libxcb-wm.git" "24eb17df2e1245885e72c9d4bbb0a0f69f0700f2" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  git -C "${PACKAGES_DIR}/xcb-ewmh" submodule update --init
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_xcb-ewmh() {
  :
}


do_configure_xcb-ewmh() {
  cd "${PACKAGES_DIR}/xcb-ewmh"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_xcb-ewmh() {
  make -C "${PACKAGES_DIR}/xcb-ewmh" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_xcb-ewmh() {
  make install -C "${PACKAGES_DIR}/xcb-ewmh" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_xcb-ewmh() {
  :
}


do_check_is_built_xcb-ewmh() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/xcb-ewmh.pc" ]] && return $SUCCESS
  return $FAILURE
}
