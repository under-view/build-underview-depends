# Build xau v1.0.9


do_return_version_xau() {
  echo "xau v1.0.9"
}


do_return_depends_xau() {
  echo "xorg-macros"
}


do_clean_xau() {
  make clean -C "${PACKAGES_DIR}/xau"
}


do_fetch_xau() {
  msg="Cloning xau"
  clone_and_checkout "${PACKAGES_DIR}/xau" "master" "https://gitlab.freedesktop.org/xorg/lib/libxau.git" "d9443b2c57b512cfb250b35707378654d86c7dea" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_xau() {
  :
}


do_configure_xau() {
  cd "${PACKAGES_DIR}/xau"
  ./autogen.sh --prefix="$INSTALLPREFIX" || { cd "${CUR_DIR}" ; return $FAILURE ; }
  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_xau() {
  make -j $BUILDTHREADS -C "${PACKAGES_DIR}/xau" || return $FAILURE
  return $SUCCESS
}


do_install_xau() {
  make install -C "${PACKAGES_DIR}/xau" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_xau() {
  :
}


do_check_is_built_xau() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/xau.pc" ]] && return $SUCCESS
  return $FAILURE
}
