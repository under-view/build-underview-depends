# Build xrender v0.9.10


do_return_version_xrender() {
  echo "libXrender v0.9.10"
}


do_return_depends_xrender() {
  echo "xorg-macros"
}


do_clean_xrender() {
  make clean -C "${PACKAGES_DIR}/xrender"
}


do_fetch_xrender() {
  msg="Cloning xrender"
  clone_and_checkout "${PACKAGES_DIR}/xrender" "libXrender-0.9.10" "https://gitlab.freedesktop.org/xorg/lib/libxrender.git" "845716f8f14963d338e5a8d5d2424baafc90fb30" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_xrender() {
  :
}


do_configure_xrender() {
  cd "${PACKAGES_DIR}/xrender"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_xrender() {
  make -j $BUILDTHREADS -C "${PACKAGES_DIR}/xrender" || return $FAILURE
  return $SUCCESS
}


do_install_xrender() {
  make install -C "${PACKAGES_DIR}/xrender" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_xrender() {
  :
}


do_check_is_built_xrender() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/xrender.pc" ]] && return $SUCCESS
  return $FAILURE
}
