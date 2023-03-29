# Build pixman v0.42.2


do_return_version_pixman() {
	echo "pixman v0.42.2"
}


do_return_depends_pixman() {
	:
}


do_clean_pixman() {
	make clean -C "${PACKAGES_DIR}/pixman"
}


do_fetch_pixman() {
	msg="Cloning pixman"
	clone_and_checkout "${PACKAGES_DIR}/pixman" "pixman-0.42.2" "https://gitlab.freedesktop.org/pixman/pixman" "37216a32839f59e8dcaa4c3951b3fcfc3f07852c" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_pixman() {
	:
}


do_configure_pixman() {
	cd "${PACKAGES_DIR}/pixman"
	./autogen.sh --prefix="$INSTALLPREFIX" --disable-gtk || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_pixman() {
	make -C "${PACKAGES_DIR}/pixman" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_pixman() {
	make install -C "${PACKAGES_DIR}/pixman" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_pixman() {
	:
}


do_check_is_built_pixman() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/pixman-1.pc" ]] && return $SUCCESS
	return $FAILURE
}
