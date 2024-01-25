# Build epoxy 1.5.10

PV="1.5.10"

do_return_version_epoxy() {
	echo "epoxy v${PV}"
}


do_return_depends_epoxy() {
	echo "x11 mesa"
}


do_clean_epoxy() {
	rm -rf "${PACKAGES_DIR}/epoxy/build"
}


do_fetch_epoxy() {
	msg="Cloning epoxy"
	clone_and_checkout "${PACKAGES_DIR}/epoxy" "${PV}" "https://github.com/anholt/libepoxy.git" "c84bc9459357a40e46e2fec0408d04fbdde2c973" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_epoxy() {
	:
}


do_configure_epoxy() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      "${PACKAGES_DIR}/epoxy/build" \
	      "${PACKAGES_DIR}/epoxy" || return $FAILURE

	return $SUCCESS
}


do_compile_epoxy() {
	meson compile -C "${PACKAGES_DIR}/epoxy/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_epoxy() {
	meson install -C "${PACKAGES_DIR}/epoxy/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_epoxy() {
	:
}


do_check_is_built_epoxy() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/epoxy.pc" ]] && return $SUCCESS
	return $FAILURE
}
