# Build xkbcommon v1.4.0


do_return_version_xkbcommon() {
  echo "libxkbcommon v1.4.0"
}


do_return_depends_xkbcommon() {
  echo "libxml2 x11 wayland"
}


do_clean_xkbcommon() {
  rm -rf "${PACKAGES_DIR}/xkbcommon/build"
}


do_fetch_xkbcommon() {
  msg="Cloning xkbcommon"
  clone_and_checkout "${PACKAGES_DIR}/xkbcommon" "xkbcommon-1.4.0" "https://github.com/xkbcommon/libxkbcommon.git" "ea6580cc3913d93655ecf92a5913de652315efc3" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_xkbcommon() {
  :
}


do_configure_xkbcommon() {
  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        -Denable-x11=true -Denable-wayland=true \
        -Denable-docs=false \
        "${PACKAGES_DIR}/xkbcommon/build" \
        "${PACKAGES_DIR}/xkbcommon" || return $FAILURE

  return $SUCCESS
}


do_compile_xkbcommon() {
  meson compile -C "${PACKAGES_DIR}/xkbcommon/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_xkbcommon() {
  meson install -C "${PACKAGES_DIR}/xkbcommon/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_xkbcommon() {
  :
}


do_check_is_built_xkbcommon() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/xkbcommon.pc" ]] && return $SUCCESS
  return $FAILURE
}
