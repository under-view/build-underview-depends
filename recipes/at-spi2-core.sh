# Build at-spi2-core v2.44.1


do_return_version_at-spi2-core() {
  echo "at-spi2-core v2.44.1"
}


do_return_depends_at-spi2-core() {
  echo "zlib libffi glib x11"
}


do_clean_at-spi2-core() {
  rm -rf "${PACKAGES_DIR}/at-spi2-core/build"
}


do_fetch_at-spi2-core() {
  msg="Cloning at-spi2-core"
  clone_and_checkout "${PACKAGES_DIR}/at-spi2-core" "AT_SPI2_CORE_2_44_1" "https://gitlab.gnome.org/GNOME/at-spi2-core.git" "9a1f0aec0b7dc55360310b6d02c2b7798511268f" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_at-spi2-core() {
  :
}


do_configure_at-spi2-core() {
  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        -Ddocs="false" -Dx11="yes" \
        "${PACKAGES_DIR}/at-spi2-core/build" \
        "${PACKAGES_DIR}/at-spi2-core" || return $FAILURE

  return $SUCCESS
}


do_compile_at-spi2-core() {
  ninja -j $BUILDTHREADS -C "${PACKAGES_DIR}/at-spi2-core/build" || return $FAILURE
  return $SUCCESS
}


do_install_at-spi2-core() {
  ninja install -C "${PACKAGES_DIR}/at-spi2-core/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_at-spi2-core() {
  :
}


do_check_is_built_at-spi2-core() {
  [[ -f "${INSTALLPREFIX}/include/at-spi-2.0/atspi/atspi.h" ]] && return $SUCCESS
  return $FAILURE
}
