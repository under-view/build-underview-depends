# Build glibc v2.34


do_return_version_glibc() {
  echo "glibc v2.34"
}


do_return_depends_glibc() {
  echo "libcap"
}


do_clean_glibc() {
  rm -rf "${PACKAGES_DIR}/glibc/build"
}


do_fetch_glibc() {
  msg="Cloning glibc"
  clone_and_checkout "${PACKAGES_DIR}/glibc" "glibc-2.34" "git://sourceware.org/git/glibc.git" "ae37d06c7d127817ba43850f0f898b793d42aea7" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_glibc() {
  :
}


do_configure_glibc() {
  mkdir -p "${PACKAGES_DIR}/glibc/build"
  cd "${PACKAGES_DIR}/glibc/build"

  ../configure --prefix="${INSTALLPREFIX}" \
               --libdir="${INSTALLPREFIX}/lib" \
               --includedir="${INSTALLPREFIX}/include" \
               --bindir="${INSTALLPREFIX}/bin" || { cd "${CUR_DIR}" ; return $FAILURE ; }

  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_glibc() {
  make -j $BUILDTHREADS -C "${PACKAGES_DIR}/glibc/build" || return $FAILURE
  return $SUCCESS
}


do_install_glibc() {
  make install -j $BUILDTHREADS -C "${PACKAGES_DIR}/glibc/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_glibc() {
  chrpath --delete "${INSTALLPREFIX}/lib/ld-linux-x86-64.so.2" || return $FAILURE
  return $SUCCESS
}


do_check_is_built_glibc() {
  [[ -f "${INSTALLPREFIX}/lib/libc.so.6" ]] && return $SUCCESS
  return $FAILURE
}
