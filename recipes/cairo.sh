# Build cairo v1.18.0

PV="1.18.0"

do_return_version_cairo() {
	echo "cairo v${PV}"
}


do_return_depends_cairo() {
	echo "zlib libffi xrender glib libpng pixman freetype fontconfig"
}


do_clean_cairo() {
	rm -rf "${PACKAGES_DIR}/cairo/build"
	git -C "${PACKAGES_DIR}/cairo" reset --hard 2>/dev/null
}


do_fetch_cairo() {
	msg="Cloning cairo"
	clone_and_checkout "${PACKAGES_DIR}/cairo" "${PV}" "https://gitlab.freedesktop.org/cairo/cairo.git" "3909090108bb2db55330e3eb148aebe664735363" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_cairo() {
	:
}


do_configure_cairo() {
	rm -rf "${PACKAGES_DIR}/cairo/subprojects"

	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dgtk2-utils="disabled" -Dtests="disabled" \
	      "${PACKAGES_DIR}/cairo/build" \
	      "${PACKAGES_DIR}/cairo" || return $FAILURE

	return $SUCCESS
}


do_compile_cairo() {
	meson compile -C "${PACKAGES_DIR}/cairo/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_cairo() {
	meson install -C "${PACKAGES_DIR}/cairo/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_cairo() {
	:
}


do_check_is_built_cairo() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/cairo.pc" ]] && return $SUCCESS
	return $FAILURE
}
