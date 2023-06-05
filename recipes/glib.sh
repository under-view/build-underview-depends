# Build glib v2.72.1


do_return_version_glib() {
	echo "glib 2.72.1"
}


do_return_depends_glib() {
	:
}


do_clean_glib() {
	rm -rf "${PACKAGES_DIR}/glib/build"
}


do_fetch_glib() {
	msg="Cloning glib"
	clone_and_checkout "${PACKAGES_DIR}/glib" "2.72.1" "https://gitlab.gnome.org/GNOME/glib.git" "38d076a5fda2714c3d494ad805d8fe993bc371bc" "${msg}" || return $FAILURE
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
