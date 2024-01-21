# Build cmocka v1.1.7

PV="v1.1.7"

do_return_version_cmocka() {
	echo "cmocka ${PV}"
}


do_return_depends_cmocka() {
	:
}


do_clean_cmocka() {
	:
}


do_fetch_cmocka() {
	msg="Cloning cmocka"
	clone_and_checkout "${PACKAGES_DIR}/cmocka" "stable-1.1" "https://git.cryptomilk.org/projects/cmocka.git" "a01cc69ee9536f90e57c61a198f2d1944d3d4313" "${msg}" || return $FAILURE

	return $SUCCESS
}


do_patch_cmocka() {
	:
}


do_configure_cmocka() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      "${PACKAGES_DIR}/cmocka/build" \
	      "${PACKAGES_DIR}/cmocka" || return $FAILURE

	return $SUCCESS
}


do_compile_cmocka() {
	meson compile -C "${PACKAGES_DIR}/cmocka/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_cmocka() {
	meson install -C "${PACKAGES_DIR}/cmocka/build" || return $FAILURE
	cp -av "${PACKAGES_DIR}/cmocka/build/libcmocka.so" \
	       "${INSTALLPREFIX}/lib" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_cmocka() {
	:
}


do_check_is_built_cmocka() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/cmocka.pc" ]] && return $SUCCESS
	return $FAILURE
}
