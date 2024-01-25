# Build fontconfig v2.15.0

PV="2.15.0"

do_return_version_fontconfig() {
	echo "fontconfig v${PV}"
}


do_return_depends_fontconfig() {
	echo "zlib glib libpng freetype harfbuzz libxml2"
}


do_clean_fontconfig() {
	rm -rf "${PACKAGES_DIR}/fontconfig/build"
}


do_fetch_fontconfig() {
	msg="Cloning fontconfig"
	clone_and_checkout "${PACKAGES_DIR}/fontconfig" "${PV}" "https://gitlab.freedesktop.org/fontconfig/fontconfig.git" "72b9a48f57de6204d99ce1c217b5609ee92ece9b" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_fontconfig() {
	:
}


do_configure_fontconfig() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dtools="disabled" -Dcache-build="disabled" \
	      -Ddoc="disabled" -Ddoc-txt="disabled" -Ddoc-man="disabled" \
	      -Ddoc-pdf="disabled" -Ddoc-html="disabled" -Dtests="disabled" \
	      "${PACKAGES_DIR}/fontconfig/build" \
	      "${PACKAGES_DIR}/fontconfig" || return $FAILURE

	return $SUCCESS
}


do_compile_fontconfig() {
	meson compile -C "${PACKAGES_DIR}/fontconfig/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_fontconfig() {
	meson install -C "${PACKAGES_DIR}/fontconfig/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_fontconfig() {
	:
}


do_check_is_built_fontconfig() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/fontconfig.pc" ]] && return $SUCCESS
	return $FAILURE
}
