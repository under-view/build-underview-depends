# Build libdrm 2.4.114


do_return_version_libdrm() {
	echo "libdrm 2.4.114"
}


do_return_depends_libdrm() {
	echo "zlib pciaccess"
}


do_clean_libdrm() {
	rm -rf "${PACKAGES_DIR}/libdrm/build"
}


do_fetch_libdrm() {
	msg="Cloning mesa drm (libdrm)"
	clone_and_checkout "${PACKAGES_DIR}/libdrm" "libdrm-2.4.114" "https://gitlab.freedesktop.org/mesa/drm" "b9ca37b3134861048986b75896c0915cbf2e97f9" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_libdrm() {
	:
}


do_configure_libdrm() {
	meson setup \
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
