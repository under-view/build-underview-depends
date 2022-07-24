# Build xfixes v6.0.0


do_return_version_xfixes() {
  echo "xfixes v6.0.0"
}


do_return_depends_xfixes() {
  echo "xorg-macros xdmcp xau xcb x11"
}


do_clean_xfixes() {
  make clean -C "${PACKAGES_DIR}/xfixes"
}


do_fetch_xfixes() {
  msg="Cloning xfixes"
  clone_and_checkout "${PACKAGES_DIR}/xfixes" "libXfixes-6.0.0" "https://gitlab.freedesktop.org/xorg/lib/libxfixes.git" "6fe3bd64dd82f704ed91478acb4c99ab5c00be16" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_xfixes() {
  :
}


do_configure_xfixes() {
  cd "${PACKAGES_DIR}/xfixes"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_xfixes() {
  make -C "${PACKAGES_DIR}/xfixes" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_xfixes() {
  make install -C "${PACKAGES_DIR}/xfixes" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_xfixes() {
  :
}


do_check_is_built_xfixes() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/xfixes.pc" ]] && return $SUCCESS
  return $FAILURE
}
