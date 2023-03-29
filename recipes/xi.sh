# Build libxi 1.8


do_return_version_xi() {
	echo "xi v1.8"
}


do_return_depends_xi() {
	echo "xorg-macros xorgproto xau xcb x11"
}


do_clean_xi() {
	make clean -C "${PACKAGES_DIR}/xi"
}


do_fetch_xi() {
	msg="Cloning libXi"
	clone_and_checkout "${PACKAGES_DIR}/xi" "libXi-1.8" "https://gitlab.freedesktop.org/xorg/lib/libxi.git" "f24d7f43ab4d97203e60677a3d42e11dbc80c8b4" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_xi() {
	:
}


do_configure_xi() {
	cd "${PACKAGES_DIR}/xi"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xi() {
	make -C "${PACKAGES_DIR}/xi" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xi() {
	make install -C "${PACKAGES_DIR}/xi" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xi() {
	:
}


do_check_is_built_xi() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xi.pc" ]] && return $SUCCESS
	return $FAILURE
}
