# Build mesa v23.3.2

PV="23.3.2"

do_return_version_mesa() {
	echo "mesa v${PV}"
}


do_return_depends_mesa() {
	echo "zlib elfutils libffi llvm wayland wayland-protocols x11 xcb xfixes xshmfence xxf86vm glvnd"
}


do_clean_mesa() {
	rm -rf "${PACKAGES_DIR}/mesa/build"
}


do_fetch_mesa() {
	msg="Cloning mesa"
	clone_and_checkout "${PACKAGES_DIR}/mesa" "mesa-${PV}" "https://gitlab.freedesktop.org/mesa/mesa.git" "527d45230f712e6d23c10c574b8f7a7a2f123604" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_mesa() {
	:
}


do_configure_mesa() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="$INSTALLPREFIX" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dglvnd="true" \
	      -Dgbm="true" \
	      "${PACKAGES_DIR}/mesa/build" \
	      "${PACKAGES_DIR}/mesa" || return $FAILURE

	return $SUCCESS
}


do_compile_mesa() {
	meson compile -C "${PACKAGES_DIR}/mesa/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_mesa() {
	meson install -C "${PACKAGES_DIR}/mesa/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_mesa() {
	:
}


do_check_is_built_mesa() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/gbm.pc" ]] && return $SUCCESS
	return $FAILURE
}
