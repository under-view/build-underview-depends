# Build libinput v1.24.0

PV="1.24.0"

do_return_version_libinput() {
	echo "libinput v${PV}"
}


do_return_depends_libinput() {
	echo "gtk systemd mtdev libevdev libwacom"
}


do_clean_libinput() {
	rm -rf "${PACKAGES_DIR}/libinput/build"
}


do_fetch_libinput() {
	msg="Cloning libinput"
	clone_and_checkout "${PACKAGES_DIR}/libinput" "${PV}" "https://gitlab.freedesktop.org/libinput/libinput.git" "1680f2fbaa63a91739012c6b57988ab1918ea0b7" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_libinput() {
	:
}


do_configure_libinput() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dtests="false" \
	      "${PACKAGES_DIR}/libinput/build" \
	      "${PACKAGES_DIR}/libinput" || return $FAILURE

	return $SUCCESS
}


do_compile_libinput() {
	meson compile -C "${PACKAGES_DIR}/libinput/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_libinput() {
	meson install -C "${PACKAGES_DIR}/libinput/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_libinput() {
	:
}


do_check_is_built_libinput() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/libinput.pc" ]] && return $SUCCESS
	return $FAILURE
}
