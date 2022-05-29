# Build gtk v3.24.33


do_return_version_gtk() {
  echo "gtk v3.24.33"
}


do_return_depends_gtk() {
  echo "glib gobject-introspection wayland x11 xext xrender xrandr xfixes xkbcommon xi" \
       "freetype cairo fribidi pango gdk-pixbuf epoxy atk at-spi2-atk"
}


do_clean_gtk() {
  rm -rf "${PACKAGES_DIR}/gtk/build"
  git -C "${PACKAGES_DIR}/gtk" reset --hard > /dev/null 2>&1
}


do_fetch_gtk() {
  msg="Cloning gtk"
  clone_and_checkout "${PACKAGES_DIR}/gtk" "3.24.33" "https://gitlab.gnome.org/GNOME/gtk.git" "8ff9b2f83ff491cbfcbf9b30c706bd917679e7cc" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_gtk() {
  :
}


do_configure_gtk() {
  rm -rf "${PACKAGES_DIR}/gtk/subprojects"

  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        --bindir="${INSTALLPREFIX}/bin" \
        --includedir="${INSTALLPREFIX}/include" \
        -Ddemos=false -Dtests=false -Dexamples=false \
        -Dgtk_doc=false -Dprint_backends="auto" -Dcolord=no \
        "${PACKAGES_DIR}/gtk/build" \
        "${PACKAGES_DIR}/gtk" || return $FAILURE

  return $SUCCESS
}


do_compile_gtk() {
  ninja -j $BUILDTHREADS -C "${PACKAGES_DIR}/gtk/build" || return $FAILURE
  return $SUCCESS
}


do_install_gtk() {
  ninja install -C "${PACKAGES_DIR}/gtk/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_gtk() {
  :
}


do_check_is_built_gtk() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/gdk-3.0.pc" ]] && return $SUCCESS
  return $FAILURE
}
