# Build xtrans v1.5.0

PV="1.5.0"

do_return_version_xtrans() {
	echo "xtrans v${PV}"
}


do_return_depends_xtrans() {
	echo "xorg-macros"
}


do_clean_xtrans() {
	make clean -C "${PACKAGES_DIR}/xtrans"
}


do_fetch_xtrans() {
	msg="Cloning xtrans"
	clone_and_checkout "${PACKAGES_DIR}/xtrans" "xtrans-${PV}" "https://gitlab.freedesktop.org/xorg/lib/libxtrans.git" "3b3a3bd75d86aec78f6ef893b198c3efc378bc64" "${msg}" || return $FAILURE

	return $SUCCESS
}


do_patch_xtrans() {
	:
}


do_configure_xtrans() {
	cd "${PACKAGES_DIR}/xtrans"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xtrans() {
	make -C "${PACKAGES_DIR}/xtrans" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xtrans() {
	make install -C "${PACKAGES_DIR}/xtrans" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xtrans() {
	mv "${INSTALLPREFIX}/share/pkgconfig"/* "${INSTALLPREFIX}/lib/pkgconfig"
	rm -rf "${INSTALLPREFIX}/share/pkgconfig"
	return $SUCCESS
}


do_check_is_built_xtrans() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xtrans.pc" ]] && return $SUCCESS
	return $FAILURE
}
