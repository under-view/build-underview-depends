# Build fribidi v1.0.13

PV="v1.0.13"

do_return_version_fribidi() {
	echo "fribidi ${PV}"
}


do_return_depends_fribidi() {
	:
}


do_clean_fribidi() {
	rm -rf "${PACKAGES_DIR}/fribidi/build"
}


do_fetch_fribidi() {
	msg="Cloning fribidi"
	clone_and_checkout "${PACKAGES_DIR}/fribidi" "${PV}" "https://github.com/fribidi/fribidi.git" "b54871c339dabb7434718da3fed2fa63320997e5" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_fribidi() {
	:
}


do_configure_fribidi() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Ddocs="false" \
	      "${PACKAGES_DIR}/fribidi/build" \
	      "${PACKAGES_DIR}/fribidi" || return $FAILURE

	return $SUCCESS
}


do_compile_fribidi() {
	meson compile -C "${PACKAGES_DIR}/fribidi/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_fribidi() {
	meson install -C "${PACKAGES_DIR}/fribidi/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_fribidi() {
	:
}


do_check_is_built_fribidi() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/fribidi.pc" ]] && return $SUCCESS
	return $FAILURE
}
