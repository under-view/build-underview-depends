# Build cglm v0.9.2

PV="v0.9.2"

do_return_version_cglm() {
	echo "cglm ${PV}"
}


do_return_depends_cglm() {
	:
}


do_clean_cglm() {
	rm -rf "${PACKAGES_DIR}/cglm/build"
}


do_fetch_cglm() {
	msg="Cloning cglm"
	clone_and_checkout "${PACKAGES_DIR}/cglm" "${PV}" "https://github.com/recp/cglm.git" "c8781615183ce3cb4f5d72caf70f2c01d7d4d2af" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_cglm() {
	:
}


do_configure_cglm() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      "${PACKAGES_DIR}/cglm/build" \
	      "${PACKAGES_DIR}/cglm" || return $FAILURE

	return $SUCCESS
}


do_compile_cglm() {
	meson compile -C "${PACKAGES_DIR}/cglm/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_cglm() {
	meson install -C "${PACKAGES_DIR}/cglm/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_cglm() {
	:
}


do_check_is_built_cglm() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/cglm.pc" ]] && return $SUCCESS
	return $FAILURE
}
