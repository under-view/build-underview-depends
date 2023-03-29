# Build pciaccess v0.17-alpha


do_return_version_pciaccess() {
	echo "pciaccess v0.17-alpha"
}


do_return_depends_pciaccess() {
	echo "zlib"
}


do_clean_pciaccess() {
	rm -rf "${PACKAGES_DIR}/pciaccess/build"
}


do_fetch_pciaccess() {
	msg="Cloning pciaccess"
	clone_and_checkout "${PACKAGES_DIR}/pciaccess" "master" "https://gitlab.freedesktop.org/xorg/lib/libpciaccess.git" "22a93f8b9b4a79eefbdd0b2c412526f6141ac7a8" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_pciaccess() {
	:
}


do_configure_pciaccess() {
	meson setup \
	      --prefix="$INSTALLPREFIX" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dzlib="enabled" \
	      "${PACKAGES_DIR}/pciaccess/build" \
	      "${PACKAGES_DIR}/pciaccess" || return $FAILURE

	return $SUCCESS
}


do_compile_pciaccess() {
	meson compile -C "${PACKAGES_DIR}/pciaccess/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_pciaccess() {
	meson install -C "${PACKAGES_DIR}/pciaccess/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_pciaccess() {
	:
}


do_check_is_built_pciaccess() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/pciaccess.pc" ]] && return $SUCCESS
	return $FAILURE
}
