# Build gtk v3.24.38

PV="3.24.38"

do_return_version_gtk() {
	echo "gtk v${PV}"
}


do_return_depends_gtk() {
	echo "glib gobject-introspection wayland x11 xext xrender xrandr xfixes xkbcommon xi" \
	     "freetype cairo fribidi pango gdk-pixbuf epoxy atk at-spi2-core"
}


do_clean_gtk() {
	rm -rf "${PACKAGES_DIR}/gtk/build"
	git -C "${PACKAGES_DIR}/gtk" reset --hard > /dev/null 2>&1
}


do_fetch_gtk() {
	msg="Cloning gtk"
	clone_and_checkout "${PACKAGES_DIR}/gtk" "${PV}" "https://gitlab.gnome.org/GNOME/gtk.git" "3e6fd55ee00d4209ce2f2af292829e4d6f674adc" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_gtk() {
	git -C "${PACKAGES_DIR}/gtk" apply "${PATCHES_DIR}/gtk/0001-meson-remove-Werror-array-bounds.patch"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_configure_gtk() {
	rm -rf "${PACKAGES_DIR}/gtk/subprojects"

	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      --bindir="${INSTALLPREFIX}/bin" \
	      --includedir="${INSTALLPREFIX}/include" \
	      -Ddemos="false" -Dtests="false" -Dexamples="false" \
	      -Dgtk_doc="false" -Dprint_backends="auto" -Dcolord="no" \
	      "${PACKAGES_DIR}/gtk/build" \
	      "${PACKAGES_DIR}/gtk" || return $FAILURE

	return $SUCCESS
}


do_compile_gtk() {
	meson compile -C "${PACKAGES_DIR}/gtk/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_gtk() {
	meson install -C "${PACKAGES_DIR}/gtk/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_gtk() {
	:
}


do_check_is_built_gtk() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/gtk+-3.0.pc" ]] && return $SUCCESS
	return $FAILURE
}
