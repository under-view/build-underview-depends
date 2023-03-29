# Build display-info v0.1.1


do_return_version_display-info() {
	echo "display-info v0.1.1"
}


do_return_depends_display-info() {
	:
}


do_clean_display-info() {
	rm -rf "${PACKAGES_DIR}/display-info/build"
}


do_fetch_display-info() {
	msg="Cloning display-info"
	clone_and_checkout "${PACKAGES_DIR}/display-info" "0.1.1" "https://gitlab.freedesktop.org/emersion/libdisplay-info.git" "92b031749c0fe84ef5cdf895067b84a829920e25" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_display-info() {
	:
}


do_configure_display-info() {
	meson setup \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      "${PACKAGES_DIR}/display-info/build" \
	      "${PACKAGES_DIR}/display-info" || return $FAILURE

	return $SUCCESS
}


do_compile_display-info() {
	meson compile -C "${PACKAGES_DIR}/display-info/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_display-info() {
	meson install -C "${PACKAGES_DIR}/display-info/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_display-info() {
	:
}


do_check_is_built_display-info() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/libdisplay-info.pc" ]] && return $SUCCESS
	return $FAILURE
}
