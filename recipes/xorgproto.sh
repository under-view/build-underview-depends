# Build inputproto 2021.5


do_return_version_xorgproto() {
  echo "xorgproto 2021.5"
}


do_return_depends_xorgproto() {
  echo "xorg-macros"
}


# Cleaning xorgproto seems to remove inputproto
# which is needed by libxi, Xserver
do_clean_xorgproto() {
  :
}


do_fetch_xorgproto() {
  msg="Cloning xorgproto"
  clone_and_checkout "${WORKING_DIR}/xorgproto" "xorgproto-2021.5" "https://gitlab.freedesktop.org/xorg/proto/xorgproto" "57acac1d4c7967f4661fb1c9f86f48f34a46c48d" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_xorgproto() {
  :
}


do_configure_xorgproto() {
  cd "${WORKING_DIR}/xorgproto"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_xorgproto() {
  make -j $BUILDTHREADS -C "${WORKING_DIR}/xorgproto" || return $FAILURE
  return $SUCCESS
}


do_install_xorgproto() {
  make install -C "${WORKING_DIR}/xorgproto" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_xorgproto() {
  mv "${INSTALLPREFIX}/share/pkgconfig"/* "${INSTALLPREFIX}/lib/pkgconfig"
  rm -rf "${INSTALLPREFIX}/share/pkgconfig"
  return $SUCCESS
}


do_check_is_built_xorgproto() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/xcmiscproto.pc" ]] && return $SUCCESS
  return $FAILURE
}
