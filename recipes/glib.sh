# Build glib v2.78.3

PV="2.78.3"

do_return_version_glib() {
	echo "glib v${PV}"
}


do_return_depends_glib() {
	:
}


do_clean_glib() {
	rm -rf "${PACKAGES_DIR}/glib/build"
}


do_fetch_glib() {
	msg="Cloning glib"
	clone_and_checkout "${PACKAGES_DIR}/glib" "${PV}" "https://gitlab.gnome.org/GNOME/glib.git" "03f7c1fbf3a3784cb4c3604f83ca3645e9225577" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_glib() {
	:
}


do_configure_glib() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      "${PACKAGES_DIR}/glib/build" \
	      "${PACKAGES_DIR}/glib" || return $FAILURE

	return $SUCCESS
}


do_compile_glib() {
	meson compile -C "${PACKAGES_DIR}/glib/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_glib() {
	meson install -C "${PACKAGES_DIR}/glib/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_glib() {
	cp "${INSTALLPREFIX}/lib/glib-2.0/include/glibconfig.h" "${INSTALLPREFIX}/include/glib-2.0"
	return $SUCCESS
}


do_check_is_built_glib() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/glib-2.0.pc" ]] && return $SUCCESS
	return $FAILURE
}
