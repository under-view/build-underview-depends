# Build gobject-introspection v1.78.1

PV="1.78.1"

do_return_version_gobject-introspection() {
	echo "gobject-introspection v${PV}"
}


do_return_depends_gobject-introspection() {
	echo "libz libffi glib"
}


do_clean_gobject-introspection() {
	rm -rf "${PACKAGES_DIR}/gobject-introspection/build"
}


do_fetch_gobject-introspection() {
	msg="Cloning gobject-introspection"
	clone_and_checkout "${PACKAGES_DIR}/gobject-introspection" "${PV}" "https://gitlab.gnome.org/GNOME/gobject-introspection.git" "a0e8c17fcf58c6ea79f2887fa7d9f2b180f152b1" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_gobject-introspection() {
	:
}


do_configure_gobject-introspection() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      "${PACKAGES_DIR}/gobject-introspection/build" \
	      "${PACKAGES_DIR}/gobject-introspection" || return $FAILURE

	return $SUCCESS
}


do_compile_gobject-introspection() {
	meson compile -C "${PACKAGES_DIR}/gobject-introspection/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_gobject-introspection() {
	meson install -C "${PACKAGES_DIR}/gobject-introspection/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_gobject-introspection() {
	:
}


do_check_is_built_gobject-introspection() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/gobject-introspection-1.0.pc" ]] && return $SUCCESS
	return $FAILURE
}
