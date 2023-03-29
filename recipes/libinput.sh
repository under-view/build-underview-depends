# Build libinput v1.20.1


do_return_version_libinput() {
	echo "libinput v1.20.1"
}


do_return_depends_libinput() {
	echo "gtk systemd mtdev libevdev libwacom"
}


do_clean_libinput() {
	rm -rf "${PACKAGES_DIR}/libinput/build"
}


do_fetch_libinput() {
	msg="Cloning libinput"
	clone_and_checkout "${PACKAGES_DIR}/libinput" "1.20.1" "https://gitlab.freedesktop.org/libinput/libinput.git" "562f7bcee0bf513824d30be31e2a64c40d5f2ee1" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_libinput() {
	:
}


do_configure_libinput() {
	meson setup \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dtests=false \
	      "${PACKAGES_DIR}/libinput/build" \
	      "${PACKAGES_DIR}/libinput" || return $FAILURE

	return $SUCCESS
}


do_compile_libinput() {
	meson compile -C "${PACKAGES_DIR}/libinput/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_libinput() {
	meson install -C "${PACKAGES_DIR}/libinput/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_libinput() {
	:
}


do_check_is_built_libinput() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/libinput.pc" ]] && return $SUCCESS
	return $FAILURE
}
