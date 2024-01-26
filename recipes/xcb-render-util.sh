# Build xcb-render-util v0.3.10

PV="0.3.10"

do_return_version_xcb-render-util() {
	echo "xcb-render-util v${PV}"
}


do_return_depends_xcb-render-util() {
	echo "libxdmcp libxau xcb"
}


do_clean_xcb-render-util() {
	make clean -C "${PACKAGES_DIR}/xcb-render-util"
}


do_fetch_xcb-render-util() {
	msg="Cloning xcb-render-util"
	clone_and_checkout "${PACKAGES_DIR}/xcb-render-util" "xcb-util-renderutil-${PV}" "https://gitlab.freedesktop.org/xorg/lib/libxcb-render-util.git" "5293d8b6165f23b9f7a8bcc903da0e4d7a75984c" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	git -C "${PACKAGES_DIR}/xcb-render-util" submodule update --init
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_xcb-render-util() {
	:
}


do_configure_xcb-render-util() {
	cd "${PACKAGES_DIR}/xcb-render-util"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xcb-render-util() {
	make -j $BUILDTHREADS -C "${PACKAGES_DIR}/xcb-render-util" || return $FAILURE
	return $SUCCESS
}


do_install_xcb-render-util() {
	make install -C "${PACKAGES_DIR}/xcb-render-util" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xcb-render-util() {
	:
}


do_check_is_built_xcb-render-util() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xcb-renderutil.pc" ]] && return $SUCCESS
	return $FAILURE
}
