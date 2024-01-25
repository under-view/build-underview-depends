# Build libxi 1.8.1

PV="1.8.1"

do_return_version_xi() {
	echo "xi v${PV}"
}


do_return_depends_xi() {
	echo "xorg-macros xorgproto xau xcb x11"
}


do_clean_xi() {
	make clean -C "${PACKAGES_DIR}/xi"
}


do_fetch_xi() {
	msg="Cloning libXi"
	clone_and_checkout "${PACKAGES_DIR}/xi" "libXi-${PV}" "https://gitlab.freedesktop.org/xorg/lib/libxi.git" "3a7503ec7703f10de17c622ea22b7bff736cea74" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_xi() {
	:
}


do_configure_xi() {
	mkdir -p "${PACKAGES_DIR}/xi/m4"

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
