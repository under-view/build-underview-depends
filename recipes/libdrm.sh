# Build libdrm v2.4.119

PV="2.4.119"

do_return_version_libdrm() {
	echo "libdrm v${PV}"
}


do_return_depends_libdrm() {
	echo "zlib pciaccess"
}


do_clean_libdrm() {
	rm -rf "${PACKAGES_DIR}/libdrm/build"
}


do_fetch_libdrm() {
	msg="Cloning mesa drm (libdrm)"
	clone_and_checkout "${PACKAGES_DIR}/libdrm" "libdrm-${PV}" "https://gitlab.freedesktop.org/mesa/drm" "fc5f2239f3b7abacb9398b2f939f538dd195e860" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_libdrm() {
	:
}


do_configure_libdrm() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      "${PACKAGES_DIR}/libdrm/build" \
	      "${PACKAGES_DIR}/libdrm" || return $FAILURE

	return $SUCCESS
}


do_compile_libdrm() {
	meson compile -C "${PACKAGES_DIR}/libdrm/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_libdrm() {
	meson install -C "${PACKAGES_DIR}/libdrm/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_libdrm() {
	:
}


do_check_is_built_libdrm() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/libdrm.pc" ]] && return $SUCCESS
	return $FAILURE
}
