# Build xrender v0.9.11

PV="0.9.11"

do_return_version_xrender() {
	echo "libXrender v${PV}"
}


do_return_depends_xrender() {
	echo "xorg-macros"
}


do_clean_xrender() {
	make clean -C "${PACKAGES_DIR}/xrender"
}


do_fetch_xrender() {
	msg="Cloning xrender"
	clone_and_checkout "${PACKAGES_DIR}/xrender" "libXrender-${PV}" "https://gitlab.freedesktop.org/xorg/lib/libxrender.git" "e5e23272394c90731debd7e18dd167e8c25b5c15" "${msg}" || return $FAILURE

	return $SUCCESS
}


do_patch_xrender() {
	:
}


do_configure_xrender() {
	cd "${PACKAGES_DIR}/xrender"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xrender() {
	make -C "${PACKAGES_DIR}/xrender" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xrender() {
	make install -C "${PACKAGES_DIR}/xrender" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xrender() {
	:
}


do_check_is_built_xrender() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xrender.pc" ]] && return $SUCCESS
	return $FAILURE
}
