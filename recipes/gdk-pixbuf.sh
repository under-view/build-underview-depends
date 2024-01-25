# Build gdk-pixbuf v2.42.10

PV="2.42.10"

do_return_version_gdk-pixbuf() {
	echo "gdk-pixbuf v${PV}"
}


do_return_depends_gdk-pixbuf() {
	echo "libffi glib gobject-introspection libpng"
}


do_clean_gdk-pixbuf() {
	rm -rf "${PACKAGES_DIR}/gdk-pixbuf/build"
	git -C "${PACKAGES_DIR}/gdk-pixbuf" reset --hard 2>/dev/null
}


do_fetch_gdk-pixbuf() {
	msg="Cloning gdk-pixbuf"
	clone_and_checkout "${PACKAGES_DIR}/gdk-pixbuf" "${PV}" "https://gitlab.gnome.org/GNOME/gdk-pixbuf.git" "9ac257eb38f772fec4253e8051743029e75a2acd" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_gdk-pixbuf() {
	:
}


do_configure_gdk-pixbuf() {
	rm -rf "${PACKAGES_DIR}/gdk-pixbuf/gdk-pixbuf/subprojects"

	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dpng=enabled -Dtiff=disabled -Dman=false \
	      -Djpeg=disabled -Dintrospection=enabled \
	      -Dinstalled_tests=false -Dgio_sniffing=false \
	      "${PACKAGES_DIR}/gdk-pixbuf/build" \
	      "${PACKAGES_DIR}/gdk-pixbuf" || return $FAILURE

	return $SUCCESS
}


do_compile_gdk-pixbuf() {
	meson compile -C "${PACKAGES_DIR}/gdk-pixbuf/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_gdk-pixbuf() {
	meson install -C "${PACKAGES_DIR}/gdk-pixbuf/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_gdk-pixbuf() {
	:
}


do_check_is_built_gdk-pixbuf() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/gdk-pixbuf-2.0.pc" ]] && return $SUCCESS
	return $FAILURE
}
