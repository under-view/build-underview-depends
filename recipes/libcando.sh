# Build libcando v0.18.0-dev

PV="HEAD"

do_return_version_libcando() {
	echo "libcando ${PV}"
}


do_return_depends_libcando() {
	echo ""
}


do_clean_libcando() {
	rm -rf "${PACKAGES_DIR}/libcando/build"
}


do_fetch_libcando() {
	msg="Cloning libcando"
	clone_and_checkout "${PACKAGES_DIR}/libcando" "master" "https://github.com/under-view/libcando.git" "fd61ba2b4db5cea64d4490c274514a92c0fbb574" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_libcando() {
	:
}


do_configure_libcando() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      "${PACKAGES_DIR}/libcando/build" \
	      "${PACKAGES_DIR}/libcando" || return $FAILURE

	return $SUCCESS
}


do_compile_libcando() {
	:
}


do_install_libcando() {
	meson install -C "${PACKAGES_DIR}/libcando/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_libcando() {
	:
}


do_check_is_built_libcando() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/cando.pc" ]] && return $SUCCESS
	return $FAILURE
}
