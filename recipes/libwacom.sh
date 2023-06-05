# Build libwacom v2.2.0


do_return_version_libwacom() {
	echo "libwacom v2.2.0"
}


do_return_depends_libwacom() {
	echo "glib libgudev"
}


do_clean_libwacom() {
	rm -rf "${PACKAGES_DIR}/libwacom/build"
}


do_fetch_libwacom() {
	msg="Cloning libwacom"
	clone_and_checkout "${PACKAGES_DIR}/libwacom" "libwacom-2.2.0" "https://github.com/linuxwacom/libwacom.git" "be485deca03157b0dbd702c7acaf35b71378be9e" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_libwacom() {
	:
}


do_configure_libwacom() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dudev-dir="${INSTALLPREFIX}" \
	      -Dtests="disabled" \
	      "${PACKAGES_DIR}/libwacom/build" \
	      "${PACKAGES_DIR}/libwacom" || return $FAILURE

	return $SUCCESS
}


do_compile_libwacom() {
	meson compile -C "${PACKAGES_DIR}/libwacom/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_libwacom() {
	meson install -C "${PACKAGES_DIR}/libwacom/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_libwacom() {
	:
}


do_check_is_built_libwacom() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/libwacom.pc" ]] && return $SUCCESS
	return $FAILURE
}
