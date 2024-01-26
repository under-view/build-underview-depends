# Build libevdev v1.13.1

PV="1.13.1"

do_return_version_libevdev() {
	echo "libevdev v${PV}"
}


do_return_depends_libevdev() {
	:
}


do_clean_libevdev() {
	rm -rf "${PACKAGES_DIR}/libevdev/build"
}


do_fetch_libevdev() {
	msg="Cloning libevdev"
	clone_and_checkout "${PACKAGES_DIR}/libevdev" "libevdev-${PV}" "https://gitlab.freedesktop.org/libevdev/libevdev.git" "4582559b668f45fcd1486ce5f21f20df49db6d02" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_libevdev() {
	:
}


do_configure_libevdev() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dtests="disabled" \
	      -Ddocumentation="disabled" \
	      "${PACKAGES_DIR}/libevdev/build" \
	      "${PACKAGES_DIR}/libevdev" || return $FAILURE

	return $SUCCESS
}


do_compile_libevdev() {
	meson compile -C "${PACKAGES_DIR}/libevdev/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_libevdev() {
	meson install -C "${PACKAGES_DIR}/libevdev/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_libevdev() {
	:
}


do_check_is_built_libevdev() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/libevdev.pc" ]] && return $SUCCESS
	return $FAILURE
}
