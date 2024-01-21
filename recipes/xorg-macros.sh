# Build Xorg-macros 1.20.0

PV="1.20.0"

do_return_version_xorg-macros() {
	echo "xorg-macros-${PV}"
}


do_return_depends_xorg-macros() {
	:
}


do_clean_xorg-macros() {
	make clean -C "${PACKAGES_DIR}/xorg-macros"
}


do_fetch_xorg-macros() {
	msg="Cloning xorg-macros"
	clone_and_checkout "${PACKAGES_DIR}/xorg-macros" "util-macros-${PV}" "https://gitlab.freedesktop.org/xorg/util/macros" "cb147377e9341af05232f95814022abdecf14024" "${msg}" || return $FAILURE

	return $SUCCESS
}


do_patch_xorg-macros() {
	:
}


do_configure_xorg-macros() {
	cd "${PACKAGES_DIR}/xorg-macros"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xorg-macros() {
	make -C "${PACKAGES_DIR}/xorg-macros" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xorg-macros() {
	make install -C "${PACKAGES_DIR}/xorg-macros" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xorg-macros() {
	mv "${INSTALLPREFIX}/share/pkgconfig/xorg-macros.pc" "${INSTALLPREFIX}/lib/pkgconfig"
	rm -rf "${INSTALLPREFIX}/share/pkgconfig"
	return $SUCCESS
}


do_check_is_built_xorg-macros() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xorg-macros.pc" ]] && return $SUCCESS
	return $FAILURE
}
