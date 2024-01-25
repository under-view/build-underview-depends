# Build xshmfence v1.3.2

PV="1.3.2"

do_return_version_xshmfence() {
	echo "xshmfence v${PV}"
}


do_return_depends_xshmfence() {
	echo "xorg-macros"
}


do_clean_xshmfence() {
	make clean -C "${PACKAGES_DIR}/xshmfence"
}


do_fetch_xshmfence() {
	msg="Cloning xshmfence"
	clone_and_checkout "${PACKAGES_DIR}/xshmfence" "libxshmfence-${PV}" "https://gitlab.freedesktop.org/xorg/lib/libxshmfence.git" "edbb7d9e5f3912fe521f0cfe5ae416bb9ca83633" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_xshmfence() {
	:
}


do_configure_xshmfence() {
	cd "${PACKAGES_DIR}/xshmfence"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xshmfence() {
	make -C "${PACKAGES_DIR}/xshmfence" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xshmfence() {
	make install -C "${PACKAGES_DIR}/xshmfence" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xshmfence() {
	:
}


do_check_is_built_xshmfence() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xshmfence.pc" ]] && return $SUCCESS
	return $FAILURE
}
