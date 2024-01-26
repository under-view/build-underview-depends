# Build libgudev v238

PV="238"

do_return_version_libgudev() {
	echo "libgudev v${PV}"
}


do_return_depends_libgudev() {
	:
}


do_clean_libgudev() {
	rm -rf "${PACKAGES_DIR}/libgudev/build"
}


do_fetch_libgudev() {
	msg="Cloning libgudev"
	clone_and_checkout "${PACKAGES_DIR}/libgudev" "${PV}" "https://gitlab.gnome.org/GNOME/libgudev.git" "df7c9c9940160307aaeb31347f4776a46f8736a9" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_libgudev() {
	:
}


do_configure_libgudev() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dtests="disabled" \
	      -Dvapi="disabled" \
	      "${PACKAGES_DIR}/libgudev/build" \
	      "${PACKAGES_DIR}/libgudev" || return $FAILURE

	return $SUCCESS
}


do_compile_libgudev() {
	meson compile -C "${PACKAGES_DIR}/libgudev/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_libgudev() {
	meson install -C "${PACKAGES_DIR}/libgudev/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_libgudev() {
	:
}


do_check_is_built_libgudev() {
	[[ -f "${INSTALLPREFIX}/lib/libgudev-1.0.so" ]] && return $SUCCESS
	return $FAILURE
}
