# Build gdb v12.1


do_return_version_gdb() {
  echo "gdb v12.1"
}


do_return_depends_gdb() {
  echo "zlib gmp"
}


do_clean_gdb() {
  make clean -C "${PACKAGES_DIR}/gdb"
}


do_fetch_gdb() {
  msg="Cloning gdb"
  clone_and_checkout "${PACKAGES_DIR}/gdb" "gdb-12.1-release" "git://sourceware.org/git/binutils-gdb.git" "e53a8e8685685c97588f8319d993ea6cd5635e47" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_gdb() {
  :
}


do_configure_gdb() {
  cd "${PACKAGES_DIR}/gdb"

  ./configure --prefix="${INSTALLPREFIX}" \
              --includedir="${INSTALLPREFIX}/include" \
              --libdir="${INSTALLPREFIX}/lib" \
              --bindir="${INSTALLPREFIX}/bin" || { cd "${CUR_DIR}" ; return $FAILURE ; }

  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_gdb() {
  make -C "${PACKAGES_DIR}/gdb" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_gdb() {
  make install -C "${PACKAGES_DIR}/gdb" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_gdb() {
  :
}


do_check_is_built_gdb() {
  [[ -f "${INSTALLPREFIX}/bin/gdb" ]] && return $SUCCESS
  return $FAILURE
}
