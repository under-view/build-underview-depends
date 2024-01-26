# Build wlroots v0.18.0-dev

PV="0.18.0-dev"

do_return_version_wlroots() {
	echo "wlroots v${PV}"
}


do_return_depends_wlroots() {
	echo "wayland wayland-protocols vulkan-loader libdrm mesa xkbcommon pixman libinput seatd xcb-render-util hwdata display-info"
}


do_clean_wlroots() {
	rm -rf "${PACKAGES_DIR}/wlroots/build"
}


do_fetch_wlroots() {
	msg="Cloning wlroots"
	clone_and_checkout "${PACKAGES_DIR}/wlroots" "master" "https://gitlab.freedesktop.org/wlroots/wlroots.git" "5d639394f3e83b01596dcd166a44a9a1a2583350" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_wlroots() {
	:
}


do_configure_wlroots() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dbackends="drm,libinput,x11" \
	      "${PACKAGES_DIR}/wlroots/build" \
	      "${PACKAGES_DIR}/wlroots" || return $FAILURE

	return $SUCCESS
}


do_compile_wlroots() {
	meson compile -C "${PACKAGES_DIR}/wlroots/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_wlroots() {
	meson install -C "${PACKAGES_DIR}/wlroots/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_wlroots() {
	:
}


do_check_is_built_wlroots() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/wlroots.pc" ]] && return $SUCCESS
	return $FAILURE
}
