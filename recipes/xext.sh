# Build xext v1.3.4


do_return_version_xext() {
	echo "xext v1.3.4"
}


do_return_depends_xext() {
	echo "xorg-macros xdmcp xau x11 xcb"
}


do_clean_xext() {
	make clean -C "${PACKAGES_DIR}/xext"
}


do_fetch_xext() {
	msg="Cloning xext"
	clone_and_checkout "${PACKAGES_DIR}/xext" "libXext-1.3.4" "https://gitlab.freedesktop.org/xorg/lib/libxext.git" "ebb167f34a3514783966775fb12573c4ed209625" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

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
