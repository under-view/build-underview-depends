# Build zlib v1.2.12


do_return_version_zlib() {
  echo "zlib v1.2.12"
}


do_return_depends_zlib() {
  :
}


do_clean_zlib() {
  rm -rf "${PACKAGES_DIR}/zlib/build"
}


do_fetch_zlib() {
  msg="Cloning zlib"
  clone_and_checkout "${PACKAGES_DIR}/zlib" "v1.2.12" "https://github.com/madler/zlib.git" "21767c654d31d2dccdde4330529775c6c5fd5389" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_zlib() {
  :
}


do_configure_zlib() {
  cmake -G "${CMAKGENTYPE}" \
        -S "${PACKAGES_DIR}/zlib" \
        -B "${PACKAGES_DIR}/zlib/build" \
        -DBUILD_SHARED_LIBS=ON \
        -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

  return $SUCCESS
}


do_compile_zlib() {
  cmake --build "${PACKAGES_DIR}/zlib/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_zlib() {
  cmake --build "${PACKAGES_DIR}/zlib/build" --target install || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_zlib() {
  mv "${INSTALLPREFIX}/share/pkgconfig"/* "${INSTALLPREFIX}/lib/pkgconfig"
  rm -rf "${INSTALLPREFIX}/share/pkgconfig"
  return $SUCCESS
}


do_check_is_built_zlib() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/zlib.pc" ]] && return $SUCCESS
  return $FAILURE
}
