# Build xau v1.0.11

PV="1.0.11"

do_return_version_xau() {
	echo "xau v${PV}"
}


do_return_depends_xau() {
	echo "xorg-macros"
}


do_clean_xau() {
	make clean -C "${PACKAGES_DIR}/xau"
}


do_fetch_xau() {
	msg="Cloning xau"
	clone_and_checkout "${PACKAGES_DIR}/xau" "libXau-${PV}" "https://gitlab.freedesktop.org/xorg/lib/libxau.git" "14fdf25db9f21c8f3ad37f0d32a5b8e726efdc0d" "${msg}" || return $FAILURE

	return $SUCCESS
}


do_patch_xau() {
	:
}


do_configure_xau() {
	cd "${PACKAGES_DIR}/xau"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xau() {
	make -C "${PACKAGES_DIR}/xau" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xau() {
	make install -C "${PACKAGES_DIR}/xau" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xau() {
	:
}


do_check_is_built_xau() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xau.pc" ]] && return $SUCCESS
	return $FAILURE
}
