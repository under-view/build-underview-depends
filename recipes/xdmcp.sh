# Build xdmcp v1.1.4

PV="1.1.4"

do_return_version_xdmcp() {
	echo "xdmcp v${PV}"
}


do_return_depends_xdmcp() {
	echo "xorg-macros"
}


do_clean_xdmcp() {
	make clean -C "${PACKAGES_DIR}/xdmcp"
}


do_fetch_xdmcp() {
	msg="Cloning xdmcp"
	clone_and_checkout "${PACKAGES_DIR}/xdmcp" "libXdmcp-${PV}" "https://gitlab.freedesktop.org/xorg/lib/libXdmcp.git" "7f5677e87df575298f62320d76408823b54cd883" "${msg}" || return $FAILURE

	return $SUCCESS
}


do_patch_xdmcp() {
	:
}


do_configure_xdmcp() {
	cd "${PACKAGES_DIR}/xdmcp"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xdmcp() {
	make -C "${PACKAGES_DIR}/xdmcp" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xdmcp() {
	make install -C "${PACKAGES_DIR}/xdmcp" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xdmcp() {
	:
}


do_check_is_built_xdmcp() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xdmcp.pc" ]] && return $SUCCESS
	return $FAILURE
}
