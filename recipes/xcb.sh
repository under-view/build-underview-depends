# Build xcb 1.16

PV="1.16"

do_return_version_xcb() {
	echo "xcb v${PV}"
}


do_return_depends_xcb() {
	echo "xorg-macros xcbproto xdmcp xau"
}


do_clean_xcb() {
	make clean -C "${PACKAGES_DIR}/xcb"
}


do_fetch_xcb() {
	msg="Cloning libxcb"
	clone_and_checkout "${PACKAGES_DIR}/xcb" "libxcb-${PV}" "https://gitlab.freedesktop.org/xorg/lib/libxcb.git" "cc4b93c9cd93bad15b7106747b0213e4b9c53a1c" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_xcb() {
	:
}


do_configure_xcb() {
	cd "${PACKAGES_DIR}/xcb"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xcb() {
	make -C "${PACKAGES_DIR}/xcb" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xcb() {
	make install -C "${PACKAGES_DIR}/xcb" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xcb() {
	:
}


do_check_is_built_xcb() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xcb.pc" ]] && return $SUCCESS
	return $FAILURE
}
