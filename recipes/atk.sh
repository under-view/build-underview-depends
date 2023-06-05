# Build atk v2.38.0


do_return_version_atk() {
	echo "atk v2.38.0"
}


do_return_depends_atk() {
	echo "libffi glib gobject-introspection"
}


do_clean_atk() {
	rm -rf "${PACKAGES_DIR}/atk/build"
}


do_fetch_atk() {
	msg="Cloning atk"
	clone_and_checkout "${PACKAGES_DIR}/atk" "2.38.0" "https://gitlab.gnome.org/GNOME/atk.git" "f1051ba57a2110c46a136a48f4d60a405bc2c3f5" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_atk() {
	:
}


do_configure_atk() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      "${PACKAGES_DIR}/atk/build" \
	      "${PACKAGES_DIR}/atk" || return $FAILURE

	return $SUCCESS
}


do_compile_atk() {
	meson compile -C "${PACKAGES_DIR}/atk/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_atk() {
	meson install -C "${PACKAGES_DIR}/atk/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_atk() {
	:
}


do_check_is_built_atk() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/atk.pc" ]] && return $SUCCESS
	return $FAILURE
}
