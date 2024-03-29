# Build pango v1.51.1

PV="1.51.1"

do_return_version_pango() {
	echo "pango v${PV}"
}


do_return_depends_pango() {
	echo "libffi glib gobject-introspection freetype harfbuzz fontconfig cairo fribidi"
}


do_clean_pango() {
	rm -rf "${PACKAGES_DIR}/pango/build"
}


do_fetch_pango() {
	msg="Cloning pango"
	clone_and_checkout "${PACKAGES_DIR}/pango" "${PV}" "https://gitlab.gnome.org/GNOME/pango.git" "dfdbb8b55effc0feb72a1981944acaf20ee71354" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_pango() {
	:
}


do_configure_pango() {
	rm -rf "${PACKAGES_DIR}/pango/subprojects"

	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dcairo="enabled" \
	      -Dsysprof="disabled" \
	      -Dlibthai="disabled" \
	      "${PACKAGES_DIR}/pango/build" \
	      "${PACKAGES_DIR}/pango" || return $FAILURE

	return $SUCCESS
}


do_compile_pango() {
	meson compile -C "${PACKAGES_DIR}/pango/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_pango() {
	meson install -C "${PACKAGES_DIR}/pango/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_pango() {
	:
}


do_check_is_built_pango() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/pango.pc" ]] && return $SUCCESS
	return $FAILURE
}
