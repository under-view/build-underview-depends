# Build at-spi2-atk v2.38.0


do_return_version_at-spi2-atk() {
  echo "at-spi2-atk v2.38.0"
}


do_return_depends_at-spi2-atk() {
  echo "dbus xtst at-spi2-core"
}


do_clean_at-spi2-atk() {
  rm -rf "${PACKAGES_DIR}/at-spi2-atk/build"
  git -C "${PACKAGES_DIR}/at-spi2-atk" reset --hard > /dev/null 2>&1
}


do_fetch_at-spi2-atk() {
  msg="Cloning at-spi2-atk"
  clone_and_checkout "${PACKAGES_DIR}/at-spi2-atk" "AT_SPI2_ATK_2_38_0" "https://gitlab.gnome.org/GNOME/at-spi2-atk.git" "b91a111f040a09e804428a81e6de214e4962247b" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_at-spi2-atk() {
  :
}


do_configure_at-spi2-atk() {
  rm -rf "${PACKAGES_DIR}/at-spi2-atk/subprojects"

  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        -Ddisable_p2p=true -Dtests=false \
        "${PACKAGES_DIR}/at-spi2-atk/build" \
        "${PACKAGES_DIR}/at-spi2-atk" || return $FAILURE

  return $SUCCESS
}


do_compile_at-spi2-atk() {
  ninja -j $BUILDTHREADS -C "${PACKAGES_DIR}/at-spi2-atk/build" || return $FAILURE
  return $SUCCESS
}


do_install_at-spi2-atk() {
  ninja install -C "${PACKAGES_DIR}/at-spi2-atk/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_at-spi2-atk() {
  :
}


do_check_is_built_at-spi2-atk() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/atk-bridge-2.0.pc" ]] && return $SUCCESS
  return $FAILURE
}
