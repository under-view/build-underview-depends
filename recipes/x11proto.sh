# Build x11proto 1.19.3


do_return_version_x11proto() {
  echo "x11proto-7.0.31"
}


do_return_depends_x11proto() {
  echo "xorg-macros"
}


# Don't clean!!
do_clean_x11proto() {
  :
}


do_fetch_x11proto() {
  msg="Cloning x11proto"
  clone_and_checkout "${PACKAGES_DIR}/x11proto" "xproto-7.0.31" "https://gitlab.freedesktop.org/xorg/proto/xproto" "f3b7b856777500113cee524dbd295fcbbce11fab" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_x11proto() {
  :
}


do_configure_x11proto() {
  cd "${PACKAGES_DIR}/x11proto"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_x11proto() {
  make -j $BUILDTHREADS -C "${PACKAGES_DIR}/x11proto" || return $FAILURE
  return $SUCCESS
}


do_install_x11proto() {
  make install -j $BUILDTHREADS -C "${PACKAGES_DIR}/x11proto" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_x11proto() {
  :
}


do_check_is_built_x11proto() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/xproto.pc" ]] && return $SUCCESS
  return $FAILURE
}
