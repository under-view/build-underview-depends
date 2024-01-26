# Build seatd v0.8.0

PV="0.8.0"

do_return_version_seatd() {
	echo "seatd v${PV}"
}


do_return_depends_seatd() {
	:
}


do_clean_seatd() {
	rm -rf "${PACKAGES_DIR}/seatd/build"
}


do_fetch_seatd() {
	msg="Cloning seatd"
	clone_and_checkout "${PACKAGES_DIR}/seatd" "${PV}" "https://github.com/kennylevinsen/seatd.git" "3e9ef69f14f630a719dd464f3c90a7932f1c8296" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_seatd() {
	:
}


do_configure_seatd() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dwerror="false" \
	      -Dman-pages="disabled" \
	      -Dexamples="disabled" \
	      "${PACKAGES_DIR}/seatd/build" \
	      "${PACKAGES_DIR}/seatd" || return $FAILURE

	return $SUCCESS
}


do_compile_seatd() {
	meson compile -C "${PACKAGES_DIR}/seatd/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_seatd() {
	meson install -C "${PACKAGES_DIR}/seatd/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_seatd() {
	:
}


do_check_is_built_seatd() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/libseat.pc" ]] && return $SUCCESS
	return $FAILURE
}
