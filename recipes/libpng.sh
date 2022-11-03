# Build libpng v1.6.37


do_return_version_libpng() {
  echo "libpng v1.6.37"
}


do_return_depends_libpng() {
  echo "zlib"
}


do_clean_libpng() {
  rm -rf "${PACKAGES_DIR}/libpng/build"
}


do_fetch_libpng() {

  [[ -f "${WORKING_DIR}/downloads/libpng-1.6.37.tar.gz" ]] || {
    wget "https://versaweb.dl.sourceforge.net/project/libpng/libpng16/1.6.37/libpng-1.6.37.tar.gz" -O "${WORKING_DIR}/downloads/libpng-1.6.37.tar.gz"
    [[ $? -ne 0 ]] && return $FAILURE

    # Just encase libpng directory get magically created
    rm -rf "${PACKAGES_DIR}/libpng" 2>/dev/null
  }

  [[ -d "${PACKAGES_DIR}/libpng" ]] || {
    tar xfz "${WORKING_DIR}/downloads/libpng-1.6.37.tar.gz" -C "${PACKAGES_DIR}"
    [[ $? -ne 0 ]] && return $FAILURE

    mv "${PACKAGES_DIR}/libpng-1.6.37" "${PACKAGES_DIR}/libpng"
  }

  return $SUCCESS
}


do_patch_libpng() {
  :
}


do_configure_libpng() {
  cmake -G "${CMAKEGENTYPE}" \
        -S "${PACKAGES_DIR}/libpng" \
        -B "${PACKAGES_DIR}/libpng/build" \
        -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

  return $SUCCESS
}


do_compile_libpng() {
  cmake --build "${PACKAGES_DIR}/libpng/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_libpng() {
  cmake --build "${PACKAGES_DIR}/libpng/build" --target install || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_libpng() {
  :
}


do_check_is_built_libpng() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/libpng16.pc" ]] && return $SUCCESS
  return $FAILURE
}
