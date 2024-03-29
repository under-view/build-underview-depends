# Build wayland v1.22.0


do_return_version_wayland() {
	echo "wayland v1.22.0"
}


do_return_depends_wayland() {
	echo "libffi"
}


do_clean_wayland() {
	rm -rf "${PACKAGES_DIR}/wayland/build"
}


do_fetch_wayland() {
	msg="Cloning wayland"
	clone_and_checkout "${PACKAGES_DIR}/wayland" "1.22.0" "https://gitlab.freedesktop.org/wayland/wayland.git" "b2649cb3ee6bd70828a17e50beb16591e6066288" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_wayland() {
	:
}


do_configure_wayland() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Ddocumentation="false" \
	      -Ddtd_validation="false" \
	      -Dtests="false" \
	      "${PACKAGES_DIR}/wayland/build" \
	      "${PACKAGES_DIR}/wayland" || return $FAILURE

	return $SUCCESS
}


do_compile_wayland() {
	meson compile -C "${PACKAGES_DIR}/wayland/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_wayland() {
	meson install -C "${PACKAGES_DIR}/wayland/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_wayland() {
	:
}


do_check_is_built_wayland() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/wayland-client.pc" ]] && return $SUCCESS
	return $FAILURE
}
