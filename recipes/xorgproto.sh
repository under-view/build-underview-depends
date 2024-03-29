# Build inputproto 2023.2

PV="2023.2"

do_return_version_xorgproto() {
	echo "xorgproto ${PV}"
}


do_return_depends_xorgproto() {
	echo "xorg-macros"
}


# Cleaning xorgproto seems to remove inputproto
# which is needed by libxi, Xserver
do_clean_xorgproto() {
	:
}


do_fetch_xorgproto() {
	msg="Cloning xorgproto"
	clone_and_checkout "${PACKAGES_DIR}/xorgproto" "xorgproto-${PV}" "https://gitlab.freedesktop.org/xorg/proto/xorgproto" "766967322209f2dcb72e6a8edea0c651f586201d" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_xorgproto() {
	:
}


do_configure_xorgproto() {
	cd "${PACKAGES_DIR}/xorgproto"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xorgproto() {
	make -C "${PACKAGES_DIR}/xorgproto" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xorgproto() {
	make install -C "${PACKAGES_DIR}/xorgproto" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xorgproto() {
	mv "${INSTALLPREFIX}/share/pkgconfig"/* "${INSTALLPREFIX}/lib/pkgconfig"
	rm -rf "${INSTALLPREFIX}/share/pkgconfig"
	return $SUCCESS
}


do_check_is_built_xorgproto() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xcmiscproto.pc" ]] && return $SUCCESS
	return $FAILURE
}
