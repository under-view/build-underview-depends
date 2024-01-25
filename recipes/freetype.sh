# Build freetype v2.13.2

PV="2.13.2"

do_return_version_freetype() {
	echo "freetype v${PV}"
}


do_return_depends_freetype() {
	echo "zlib glib libpng"
}


do_clean_freetype() {
	rm -rf "${PACKAGES_DIR}/freetype/build"
}


do_fetch_freetype() {
	msg="Cloning freetype"
	clone_and_checkout "${PACKAGES_DIR}/freetype" "VER-2-13-2" "https://gitlab.freedesktop.org/freetype/freetype" "920c5502cc3ddda88f6c7d85ee834ac611bb11cc" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_freetype() {
	:
}


do_configure_freetype() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dbrotli="disabled" -Dbzip2="disabled" \
	      -Dharfbuzz="disabled" -Dzlib="enabled" -Dpng="enabled" \
	      "${PACKAGES_DIR}/freetype/build" \
	      "${PACKAGES_DIR}/freetype" || return $FAILURE

	return $SUCCESS
}


do_compile_freetype() {
	meson compile -C "${PACKAGES_DIR}/freetype/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_freetype() {
	meson install -C "${PACKAGES_DIR}/freetype/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_freetype() {
	:
}


do_check_is_built_freetype() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/freetype2.pc" ]] && return $SUCCESS
	return $FAILURE
}
