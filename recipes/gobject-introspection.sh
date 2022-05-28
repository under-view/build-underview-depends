# Build gobject-introspection v1.72.0


do_return_version_gobject-introspection() {
  echo "gobject-introspection v1.72.0"
}


do_return_depends_gobject-introspection() {
  echo "libz libffi glib"
}


do_clean_gobject-introspection() {
  rm -rf "${PACKAGES_DIR}/gobject-introspection/build"
}


do_fetch_gobject-introspection() {
  msg="Cloning gobject-introspection"
  clone_and_checkout "${PACKAGES_DIR}/gobject-introspection" "1.72.0" "https://gitlab.gnome.org/GNOME/gobject-introspection.git" "c1ce7d179cfce327162bd206cdf2808bd9bd0cc7" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_gobject-introspection() {
  :
}


do_configure_gobject-introspection() {
  meson setup \
        --prefix="${INSTALLPREFIX}" \
        --libdir="${INSTALLPREFIX}/lib" \
        "${PACKAGES_DIR}/gobject-introspection/build" \
        "${PACKAGES_DIR}/gobject-introspection" || return $FAILURE

  return $SUCCESS
}


do_compile_gobject-introspection() {
  ninja -j $BUILDTHREADS -C "${PACKAGES_DIR}/gobject-introspection/build" || return $FAILURE
  return $SUCCESS
}


do_install_gobject-introspection() {
  ninja install -C "${PACKAGES_DIR}/gobject-introspection/build" || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_gobject-introspection() {
  :
}


do_check_is_built_gobject-introspection() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/gobject-introspection-1.0.pc" ]] && return $SUCCESS
  return $FAILURE
}
