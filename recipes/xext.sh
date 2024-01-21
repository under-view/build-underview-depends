# Build xext v1.3.5

PV = "1.3.5"

do_return_version_xext() {
	echo "xext v${PV}"
}


do_return_depends_xext() {
	echo "xorg-macros xdmcp xau x11 xcb"
}


do_clean_xext() {
	make clean -C "${PACKAGES_DIR}/xext"
}


do_fetch_xext() {
	msg="Cloning xext"
	clone_and_checkout "${PACKAGES_DIR}/xext" "libXext-${PV}" "https://gitlab.freedesktop.org/xorg/lib/libxext.git" "67e82cc395f44faddd83ec3d0d21624fe91c6fc0" "${msg}" || return $FAILURE

	return $SUCCESS
}


do_patch_xext() {
	:
}


do_configure_xext() {
	cd "${PACKAGES_DIR}/xext"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xext() {
	make -C "${PACKAGES_DIR}/xext" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xext() {
	make install -C "${PACKAGES_DIR}/xext" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xext() {
	:
}


do_check_is_built_xext() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xext.pc" ]] && return $SUCCESS
	return $FAILURE
}
