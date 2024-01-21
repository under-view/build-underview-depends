# Build libxrandr 1.5.3

PV="1.5.3"

do_return_version_xrandr() {
	echo "libxrandr v${PV}"
}


do_return_depends_xrandr() {
	echo "xorg-macros xcb x11 xext xrender"
}


do_clean_xrandr() {
	make clean -C "${PACKAGES_DIR}/xrandr"
}


do_fetch_xrandr() {
	msg="Cloning xrandr"
	clone_and_checkout "${PACKAGES_DIR}/xrandr" "libXrandr-${PV}" "https://gitlab.freedesktop.org/xorg/lib/libxrandr" "3387129532899eaeee3477a2d92fa662d7292a84" "${msg}" || return $FAILURE

	return $SUCCESS
}


do_patch_xrandr() {
	:
}


do_configure_xrandr() {
	cd "${PACKAGES_DIR}/xrandr"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }
	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_xrandr() {
	make -C "${PACKAGES_DIR}/xrandr" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xrandr() {
	make install -C "${PACKAGES_DIR}/xrandr" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xrandr() {
	:
}


do_check_is_built_xrandr() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xrandr.pc" ]] && return $SUCCESS
	return $FAILURE
}
