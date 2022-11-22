# Build systemd v250


do_return_version_systemd() {
  echo "systemd v250"
}


do_return_depends_systemd() {
  echo "libcap"
}


do_clean_systemd() {
  rm -rf "${PACKAGES_DIR}/systemd/build"
  git -C "${PACKAGES_DIR}/systemd" reset --hard > /dev/null 2>&1
}


do_fetch_systemd() {
  msg="Cloning systemd"
  clone_and_checkout "${PACKAGES_DIR}/systemd" "v250" "https://github.com/systemd/systemd.git" "a420d71793bcbc1539a63be60f83cdc14373ea4a" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_systemd() {
  git -C "${PACKAGES_DIR}/systemd" apply "${PATCHES_DIR}/systemd/0001-remove-journalctl-command-from-executing.patch" > /dev/null 2>&1
  [[ $? -ne 0 ]] && return $FAILURE

  git -C "${PACKAGES_DIR}/systemd" apply "${PATCHES_DIR}/systemd/0002-check-filesystem-fix-not-in-filesystem-gperf.gperf.patch" > /dev/null 2>&1
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
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
        -Dsysvinit-path="${INSTALLPREFIX}/etc/init.d" \
        -Dsysvrcnd-path="${INSTALLPREFIX}/etc/rc.d" \
        -Dtelinit-path="${INSTALLPREFIX}/lib/sysvinit/telinit" \
        -Drc-local="${INSTALLPREFIX}/etc/rc.local" \
        -Dtests="false" -Dinstall-sysconfdir="false" \
        -Dpolkit="false" -Defi="false" -Delfutils="false" \
        "${PACKAGES_DIR}/systemd/build" \
        "${PACKAGES_DIR}/systemd" || return $FAILURE

  return $SUCCESS
}


do_compile_systemd() {
  meson compile -C "${PACKAGES_DIR}/systemd/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_systemd() {
  meson install -C "${PACKAGES_DIR}/systemd/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_systemd() {
  mv "${INSTALLPREFIX}/share/pkgconfig"/* "${INSTALLPREFIX}/lib/pkgconfig"
  rm -rf "${INSTALLPREFIX}/share/pkgconfig"
}


do_check_is_built_systemd() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/libsystemd.pc" ]] && return $SUCCESS
  return $FAILURE
}
