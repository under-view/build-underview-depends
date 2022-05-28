# Build freetype v6.18.2


do_return_version_freetype() {
  echo "freetype v6.18.2"
}


do_return_depends_freetype() {
  echo "zlib glib libpng"
}


do_clean_freetype() {
  rm -rf "${PACKAGES_DIR}/freetype/build"
}


do_fetch_freetype() {
  msg="Cloning freetype"
  clone_and_checkout "${PACKAGES_DIR}/freetype" "VER-2-12-0" "https://gitlab.freedesktop.org/freetype/freetype" "e50798b72043c8b378caa46e0a854519f9028ae4" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_freetype() {
  :
}


do_configure_freetype() {
  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        -Dbrotli="disabled" -Dbzip2="disabled" \
        -Dharfbuzz="disabled" -Dzlib="enabled" -Dpng="enabled" \
        "${PACKAGES_DIR}/freetype/build" \
        "${PACKAGES_DIR}/freetype" || return $FAILURE

  return $SUCCESS
}


do_compile_freetype() {
  ninja -j $BUILDTHREADS -C "${PACKAGES_DIR}/freetype/build" || return $FAILURE
  return $SUCCESS
}


do_install_freetype() {
  ninja install -C "${PACKAGES_DIR}/freetype/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_freetype() {
  :
}


do_check_is_built_freetype() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/freetype2.pc" ]] && return $SUCCESS
  return $FAILURE
}
