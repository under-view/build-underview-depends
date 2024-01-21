# Build xcbproto 1.16.0

PV="1.16.0"

do_return_version_xcbproto() {
	echo "xcbproto-${PV}"
}


do_return_depends_xcbproto() {
	echo "xorg-macros"
}


# Don't clean!!
do_clean_xcbproto() {
	:
}


do_fetch_xcbproto() {
	msg="Cloning xcbproto"
	clone_and_checkout "${PACKAGES_DIR}/xcbproto" "xcb-proto-${PV}" "https://gitlab.freedesktop.org/xorg/proto/xcbproto.git" "98eeebfc2d7db5377b85437418fb942ea30ffc0d" "${msg}" || return $FAILURE

	return $SUCCESS
}


do_patch_xcbproto() {
	:
}


do_configure_xcbproto() {
	cd "${PACKAGES_DIR}/xcbproto"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xcbproto() {
	make -C "${PACKAGES_DIR}/xcbproto" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xcbproto() {
	make install -j $BUILDTHREADS -C "${PACKAGES_DIR}/xcbproto" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xcbproto() {
	mv -v "${INSTALLPREFIX}/share/pkgconfig/xcb-proto.pc" \
	      "${INSTALLPREFIX}/lib/pkgconfig/xcb-proto.pc" || return $FAILURE

	rm -dv "${INSTALLPREFIX}/share/pkgconfig"

	sed -i'' -e 's|${pc_sysrootdir}||g' \
	            "${INSTALLPREFIX}/lib/pkgconfig/xcb-proto.pc" || return $FAILURE
}


do_check_is_built_xcbproto() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xcb-proto.pc" ]] && return $SUCCESS
	return $FAILURE
}
