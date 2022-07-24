# Build xdmcp v1.1.3


do_return_version_xdmcp() {
  echo "xdmcp v1.1.3"
}


do_return_depends_xdmcp() {
  echo "xorg-macros"
}


do_clean_xdmcp() {
  make clean -C "${PACKAGES_DIR}/xdmcp"
}


do_fetch_xdmcp() {
  msg="Cloning xdmcp"
  clone_and_checkout "${PACKAGES_DIR}/xdmcp" "libXdmcp-1.1.3" "https://gitlab.freedesktop.org/xorg/lib/libXdmcp.git" "618b3ba5f826d930df2ca6a6a0ce212fa75cef42" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_xdmcp() {
  :
}


do_configure_xdmcp() {
  cd "${PACKAGES_DIR}/xdmcp"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_xdmcp() {
  make -C "${PACKAGES_DIR}/xdmcp" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_xdmcp() {
  make install -C "${PACKAGES_DIR}/xdmcp" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_xdmcp() {
  :
}


do_check_is_built_xdmcp() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/xdmcp.pc" ]] && return $SUCCESS
  return $FAILURE
}
