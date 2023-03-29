# Build libxtst v1.2.3


do_return_version_xtst() {
	echo "libxtst v1.2.3"
}


do_return_depends_xtst() {
	echo "xorg-macros"
}


do_clean_xtst() {
	make clean -C "${PACKAGES_DIR}/xtst"
}


do_fetch_xtst() {
	msg="Cloning libxtst"
	clone_and_checkout "${PACKAGES_DIR}/xtst" "libXtst-1.2.3" "https://gitlab.freedesktop.org/xorg/lib/libxtst.git" "9f5621a410f18149d4c76b02daa7f1a98b4a2c16" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_xtst() {
	:
}


do_configure_xtst() {
	cd "${PACKAGES_DIR}/xtst"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xtst() {
	make -C "${PACKAGES_DIR}/xtst" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xtst() {
	make install -C "${PACKAGES_DIR}/xtst" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xtst() {
	:
}


do_check_is_built_xtst() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xtst.pc" ]] && return $SUCCESS
	return $FAILURE
}
