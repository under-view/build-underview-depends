# Build glvnd v1.7.0

PV="v1.7.0"

do_return_version_glvnd() {
	echo "glvnd ${PV}"
}


do_return_depends_glvnd() {
	echo "x11proto x11 xext"
}


do_clean_glvnd() {
	rm -rf "${PACKAGES_DIR}/glvnd/build"
}


do_fetch_glvnd() {
	msg="Cloning glvnd"
	clone_and_checkout "${PACKAGES_DIR}/glvnd" "${PV}" "https://gitlab.freedesktop.org/glvnd/libglvnd.git" "faa23f21fc677af5792825dc30cb1ccef4bf33a6" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_glvnd() {
	:
}


do_configure_glvnd() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dentrypoint-patching="enabled" \
	      "${PACKAGES_DIR}/glvnd/build" \
	      "${PACKAGES_DIR}/glvnd" || return $FAILURE

	return $SUCCESS
}


do_compile_glvnd() {
	meson compile -C "${PACKAGES_DIR}/glvnd/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_glvnd() {
	meson install -C "${PACKAGES_DIR}/glvnd/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_glvnd() {
	:
}


do_check_is_built_glvnd() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/opengl.pc" ]] && return $SUCCESS
	return $FAILURE
}
