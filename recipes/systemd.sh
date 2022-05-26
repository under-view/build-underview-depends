# Build systemd v250


do_return_version_systemd() {
  echo "systemd v250"
}


do_return_depends_systemd() {
  echo "libcap"
}


do_clean_systemd() {
  rm -rf "${PACKAGES_DIR}/systemd/build"
}


do_fetch_systemd() {
  msg="Cloning systemd"
  clone_and_checkout "${PACKAGES_DIR}/systemd" "v250" "https://github.com/systemd/systemd.git" "a420d71793bcbc1539a63be60f83cdc14373ea4a" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_systemd() {
  :
}


do_configure_systemd() {
  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        --includedir="${INSTALLPREFIX}/include" \
        -Dc_args="-I${INSTALLPREFIX}/include" \
        -Drootprefix="${INSTALLPREFIX}" \
        -Dbashcompletiondir="${INSTALLPREFIX}/usr/share/bash-completion/completions" \
        -Dzshcompletiondir="${INSTALLPREFIX}/share/zsh/site-functions" \
        -Dinstall-sysconfdir="false" -Dpolkit="false" -Defi="false" -Delfutils="false" \
        "${PACKAGES_DIR}/systemd/build" \
        "${PACKAGES_DIR}/systemd" || return $FAILURE

  return $SUCCESS
}


do_compile_systemd() {
  ninja -j $BUILDTHREADS -C "${PACKAGES_DIR}/systemd/build" || return $FAILURE
  return $SUCCESS
}


# Done on purpose. Allow install step to fail
# TODO: pinpoint all locations systemd recipe attempts to install files into
do_install_systemd() {
  ninja install -C "${PACKAGES_DIR}/systemd/build"
  return $SUCCESS
}


do_update_artifacts_systemd() {
  :
}


do_check_is_built_systemd() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/libsystemd.pc" ]] && return $SUCCESS
  return $FAILURE
}
