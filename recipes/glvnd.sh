# Build glvnd v1.5.0


do_return_version_glvnd() {
	echo "glvnd v1.5.0"
}


do_return_depends_glvnd() {
	echo "x11proto x11 xext"
}


do_clean_glvnd() {
	rm -rf "${PACKAGES_DIR}/glvnd/build"
}


do_fetch_glvnd() {
	msg="Cloning glvnd"
	clone_and_checkout "${PACKAGES_DIR}/glvnd" "v1.5.0" "https://gitlab.freedesktop.org/glvnd/libglvnd.git" "c7cdf0cc4395b57563294d1f340b6bb1b95366a0" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_glvnd() {
	:
}


do_configure_glvnd() {
	meson setup \
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
