# Build mesa 23.0.2


do_return_version_mesa() {
	echo "mesa v23.0.2"
}


do_return_depends_mesa() {
	echo "zlib elfutils libffi llvm wayland wayland-protocols x11 xcb xfixes xshmfence xxf86vm glvnd"
}


do_clean_mesa() {
	rm -rf "${PACKAGES_DIR}/mesa/build"
}


do_fetch_mesa() {
	msg="Cloning mesa"
	clone_and_checkout "${PACKAGES_DIR}/mesa" "23.0" "https://gitlab.freedesktop.org/mesa/mesa.git" "4d5e73870ecfc14e83bc577af1525c0531e503cc" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_mesa() {
	:
}


do_configure_mesa() {
	meson setup \
	      --prefix="$INSTALLPREFIX" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dglvnd=true \
	      -Dgbm=true \
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
