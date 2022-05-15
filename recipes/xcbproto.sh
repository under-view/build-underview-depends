# Build xcbproto 1.14.1


do_return_version_xcbproto() {
  echo "xcbproto-1.14.1"
}


do_return_depends_xcbproto() {
  echo "xorg-macros"
}


# Don't clean!!
do_clean_xcbproto() {
  :
}


do_fetch_xcbproto() {
  msg="Cloning xcbproto"
  clone_and_checkout "${PACKAGES_DIR}/xcbproto" "xcb-proto-1.14.1" "https://gitlab.freedesktop.org/xorg/proto/xcbproto.git" "496e3ce329c3cc9b32af4054c30fa0f306deb007" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_xcbproto() {
  :
}


do_configure_xcbproto() {
  cd "${PACKAGES_DIR}/xcbproto"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_xcbproto() {
  make -j $BUILDTHREADS -C "${PACKAGES_DIR}/xcbproto" || return $FAILURE
  return $SUCCESS
}


do_install_xcbproto() {
  make install -j $BUILDTHREADS -C "${PACKAGES_DIR}/xcbproto" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_xcbproto() {
  :
}


do_check_is_built_xcbproto() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/xcb-proto.pc" ]] && return $SUCCESS
  return $FAILURE
}
