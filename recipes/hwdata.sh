# Build hwdata v0.348-9.8


do_return_version_hwdata() {
  echo "hwdata v0.348-9.8"
}


do_return_depends_hwdata() {
  :
}


do_clean_hwdata() {
  make clean -C "${PACKAGES_DIR}/hwdata"
}


do_fetch_hwdata() {
  msg="Cloning hwdata"
  clone_and_checkout "${PACKAGES_DIR}/hwdata" "v0.348-9.8" "https://github.com/vcrhonek/hwdata.git" "e098f2a3f626c46835206afca262d0a7a1226a94" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_hwdata() {
  :
}


do_configure_hwdata() {
  cd "${PACKAGES_DIR}/hwdata"

  ./configure --prefix="${INSTALLPREFIX}" \
              --libdir="${INSTALLPREFIX}/lib" \
			  --bindir="${INSTALLPREFIX}/bin" \
			  --datadir="${INSTALLPREFIX}/usr/share" \
              || { cd "${CUR_DIR}" ; return $FAILURE ; }

  cd "${CUR_DIR}"

  return $SUCCESS
}


do_compile_hwdata() {
  make -C "${PACKAGES_DIR}/hwdata" download || return $FAILURE
  make -C "${PACKAGES_DIR}/hwdata" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_hwdata() {
  make install -C "${PACKAGES_DIR}/hwdata" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_hwdata() {
  mv "${INSTALLPREFIX}/usr/share/pkgconfig"/*.pc "${INSTALLPREFIX}/lib/pkgconfig"
  rm -rf "${INSTALLPREFIX}/usr/share/pkgconfig"
  sed -i "s/pc_sysrootdir/prefix/g" "${INSTALLPREFIX}/lib/pkgconfig/hwdata.pc"
  return $SUCCESS
}


do_check_is_built_hwdata() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/hwdata.pc" ]] && return $SUCCESS
  return $FAILURE
}
