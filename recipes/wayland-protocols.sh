# Build wayland-protocols v1.32

PV="1.32"

do_return_version_wayland-protocols() {
	echo "wayland-protocols v${PV}"
}


do_return_depends_wayland-protocols() {
	echo "wayland"
}


do_clean_wayland-protocols() {
	rm -rf "${PACKAGES_DIR}/wayland-protocols/build"
}


do_fetch_wayland-protocols() {
	msg="Cloning wayland-protocols"
	clone_and_checkout "${PACKAGES_DIR}/wayland-protocols" "${PV}" "https://gitlab.freedesktop.org/wayland/wayland-protocols.git" "681c33c8547d6aefe24455ba2bffe1c5ae11fee5" "${msg}" || return $FAILURE

	return $SUCCESS
}


do_patch_wayland-protocols() {
	:
}


do_configure_wayland-protocols() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      "${PACKAGES_DIR}/wayland-protocols/build" \
	      "${PACKAGES_DIR}/wayland-protocols" || return $FAILURE

	return $SUCCESS
}


do_compile_wayland-protocols() {
	meson compile -C "${PACKAGES_DIR}/wayland-protocols/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_wayland-protocols() {
	meson install -C "${PACKAGES_DIR}/wayland-protocols/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_wayland-protocols() {
	mv "${INSTALLPREFIX}/share/pkgconfig/wayland-protocols.pc" "${INSTALLPREFIX}/lib/pkgconfig"
	rm -rf "${INSTALLPREFIX}/share/pkgconfig"
	return $SUCCESS
}


do_check_is_built_wayland-protocols() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/wayland-protocols.pc" ]] && return $SUCCESS
	return $FAILURE
}
