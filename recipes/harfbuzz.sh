# Build harfbuzz 4.2.0


do_return_version_harfbuzz() {
  echo "harfbuzz v4.2.0"
}


do_return_depends_harfbuzz() {
  echo "zlib libffi glib gobject-introspection libpng freetype"
}


do_clean_harfbuzz() {
  rm -rf "${PACKAGES_DIR}/harfbuzz/build"
  git -C "${PACKAGES_DIR}/harfbuzz/" reset --hard 2>/dev/null
}


do_fetch_harfbuzz() {
  msg="Cloning harfbuzz"
  clone_and_checkout "${PACKAGES_DIR}/harfbuzz" "4.2.0" "https://github.com/harfbuzz/harfbuzz.git" "9d5730b958974bc9db95e46e6bad52e9e9cd6e1c" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_harfbuzz() {
  :
}


do_configure_harfbuzz() {
  rm -rf "${PACKAGES_DIR}/harfbuzz/subprojects"

  meson setup \
        --prefix="$INSTALLPREFIX" \
        --libdir="${INSTALLPREFIX}/lib" \
        -Dglib="enabled" -Dgobject="enabled" \
        -Dcairo="disabled" -Dtests="disabled" \
        -Dfreetype="enabled" -Ddocs="disabled" \
        "${PACKAGES_DIR}/harfbuzz/build" \
        "${PACKAGES_DIR}/harfbuzz" || return $FAILURE

  return $SUCCESS
}


do_compile_harfbuzz() {
  ninja -j $BUILDTHREADS -C "${PACKAGES_DIR}/harfbuzz/build" || return $FAILURE
  return $SUCCESS
}


do_install_harfbuzz() {
  ninja install -C "${PACKAGES_DIR}/harfbuzz/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_harfbuzz() {
  :
}


do_check_is_built_harfbuzz() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/harfbuzz.pc" ]] && return $SUCCESS
  return $FAILURE
}
