# Build xxf86vm v1.1.4


do_return_version_xxf86vm() {
  echo "xxf86vm v1.1.4"
}


do_return_depends_xxf86vm() {
  echo "xorg-macros xdmcp xau xcb x11 xext"
}


do_clean_xxf86vm() {
  make clean -C "${PACKAGES_DIR}/xxf86vm"
}


do_fetch_xxf86vm() {
  msg="Cloning xxf86vm"
  clone_and_checkout "${PACKAGES_DIR}/xxf86vm" "libXxf86vm-1.1.4" "https://gitlab.freedesktop.org/xorg/lib/libXxf86vm.git" "92d18649e92566ccc3abeba244adabda249cce1b" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_xxf86vm() {
  :
}


do_configure_xxf86vm() {
  cd "${PACKAGES_DIR}/xxf86vm"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_xxf86vm() {
  make -C "${PACKAGES_DIR}/xxf86vm" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_xxf86vm() {
  make install -C "${PACKAGES_DIR}/xxf86vm" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_xxf86vm() {
  :
}


do_check_is_built_xxf86vm() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/xxf86vm.pc" ]] && return $SUCCESS
  return $FAILURE
}
