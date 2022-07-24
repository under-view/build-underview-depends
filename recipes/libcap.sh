# Build libcap v2.64


do_return_version_libcap() {
  echo "libcap v2.64"
}


do_return_depends_libcap() {
  :
}


do_clean_libcap() {
  make clean -C "${PACKAGES_DIR}/libcap"
}


do_fetch_libcap() {
  [[ -f "${WORKING_DIR}/downloads/libcap-2.64.tar.xz" ]] || {
    wget https://mirrors.edge.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.64.tar.xz -O "${WORKING_DIR}/downloads/libcap-2.64.tar.xz" > /dev/null
    [[ $? -ne 0 ]] && return $FAILURE

    # Just encase libcap folder was created somehow
    rm -rf "${WORKING_DIR}/libcap"
  }

  [[ -d "${PACKAGES_DIR}/libcap" ]] || {
    tar xf "${WORKING_DIR}/downloads/libcap-2.64.tar.xz" -C "${PACKAGES_DIR}" || return $FAILURE
    [[ $? -ne 0 ]] && return $FAILURE

    wait $!

    mv "${PACKAGES_DIR}/libcap-2.64" "${PACKAGES_DIR}/libcap"
  }

  return $SUCCESS
}


do_patch_libcap() {
  :
}


do_configure_libcap() {
  :
}


do_compile_libcap() {
  DESTDIR="${INSTALLPREFIX}" \
  make -C "${PACKAGES_DIR}/libcap" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_libcap() {
  DESTDIR="${INSTALLPREFIX}" \
  make install -C "${PACKAGES_DIR}/libcap" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_libcap() {
  cp -ar "${INSTALLPREFIX}/lib64"/* "${INSTALLPREFIX}/lib"
  cp -ar "${INSTALLPREFIX}/usr/include"/* "${INSTALLPREFIX}/include"
  cp -ar "${INSTALLPREFIX}/usr/share"/* "${INSTALLPREFIX}/share"
  rm -rf "${INSTALLPREFIX}/lib64" "${INSTALLPREFIX}/usr"
}


do_check_is_built_libcap() {
  [[ -f "${INSTALLPREFIX}/include/sys/capability.h" ]] && return $SUCCESS
  return $FAILURE
}
