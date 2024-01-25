# Build xxf86vm v1.1.5

PV="1.1.5"

do_return_version_xxf86vm() {
	echo "xxf86vm v${PV}"
}


do_return_depends_xxf86vm() {
	echo "xorg-macros xdmcp xau xcb x11 xext"
}


do_clean_xxf86vm() {
	make clean -C "${PACKAGES_DIR}/xxf86vm"
}


do_fetch_xxf86vm() {
	msg="Cloning xxf86vm"
	clone_and_checkout "${PACKAGES_DIR}/xxf86vm" "libXxf86vm-${PV}" "https://gitlab.freedesktop.org/xorg/lib/libXxf86vm.git" "7fe2d41f164d3015216c1079cc7fbce1eea90c98" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_xxf86vm() {
	:
}


do_configure_xxf86vm() {
	cd "${PACKAGES_DIR}/xxf86vm"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xxf86vm() {
	make -C "${PACKAGES_DIR}/xxf86vm" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xxf86vm() {
	make install -C "${PACKAGES_DIR}/xxf86vm" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xxf86vm() {
	:
}


do_check_is_built_xxf86vm() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xxf86vm.pc" ]] && return $SUCCESS
	return $FAILURE
}
