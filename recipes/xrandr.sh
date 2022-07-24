# Build Xrandr 1.5.2


do_return_version_xrandr() {
  echo "Xrandr v1.5.2"
}


do_return_depends_xrandr() {
  echo "xorg-macros xcb x11 xext xrender"
}


do_clean_xrandr() {
  make clean -C "${PACKAGES_DIR}/xrandr"
}


do_fetch_xrandr() {
  msg="Cloning xrandr"
  clone_and_checkout "${PACKAGES_DIR}/xrandr" "libXrandr-1.5.2" "https://gitlab.freedesktop.org/xorg/lib/libxrandr" "55dcda4518eda8ae03ef25ea29d3c994ad71eb0a" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_xrandr() {
  :
}


do_configure_xrandr() {
  cd "${PACKAGES_DIR}/xrandr"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_xrandr() {
  make -C "${PACKAGES_DIR}/xrandr" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_xrandr() {
  make install -C "${PACKAGES_DIR}/xrandr" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_xrandr() {
  :
}


do_check_is_built_xrandr() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/xrandr.pc" ]] && return $SUCCESS
  return $FAILURE
}
