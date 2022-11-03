# Build robin-hood-hashing v3.11.5


do_return_version_robin-hood-hashing() {
  echo "robin-hood-hashing v3.11.5"
}


do_return_depends_robin-hood-hashing() {
  :
}


do_clean_robin-hood-hashing() {
  rm -rf "${PACKAGES_DIR}/robin-hood-hashing/build"
}


do_fetch_robin-hood-hashing() {
  msg="Cloning robin-hood-hashing"
  clone_and_checkout "${PACKAGES_DIR}/robin-hood-hashing" "3.11.5" "https://github.com/martinus/robin-hood-hashing.git" "9145f963d80d6a02f0f96a47758050a89184a3ed" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_robin-hood-hashing() {
  :
}


do_configure_robin-hood-hashing() {
  cmake -G "${CMAKEGENTYPE}" \
        -S "${PACKAGES_DIR}/robin-hood-hashing" \
        -B "${PACKAGES_DIR}/robin-hood-hashing/build" \
        -DRH_STANDALONE_PROJECT=OFF \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_LIBDIR="${INSTALLPREFIX}/lib" \
        -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

  return $SUCCESS
}


do_compile_robin-hood-hashing() {
  cmake --build "${PACKAGES_DIR}/robin-hood-hashing/build" --config Release -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_robin-hood-hashing() {
  cmake --build "${PACKAGES_DIR}/robin-hood-hashing/build" --config Release --target install || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_robin-hood-hashing() {
  :
}


do_check_is_built_robin-hood-hashing() {
  [[ -f "${INSTALLPREFIX}/lib/cmake/robin_hood/robin_hoodConfig.cmake" ]] && return $SUCCESS
  return $FAILURE
}
