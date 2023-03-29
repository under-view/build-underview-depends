# Build fontconfig 2.14.0


do_return_version_fontconfig() {
	echo "fontconfig v2.14.0"
}


do_return_depends_fontconfig() {
	echo "zlib glib libpng freetype harfbuzz libxml2"
}


do_clean_fontconfig() {
	rm -rf "${PACKAGES_DIR}/fontconfig/build"
}


do_fetch_fontconfig() {
	msg="Cloning fontconfig"
	clone_and_checkout "${PACKAGES_DIR}/fontconfig" "2.14.0" "https://gitlab.freedesktop.org/fontconfig/fontconfig.git" "911b19f19f1334d51c452756f9ce222c1101097b" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_fontconfig() {
	:
}


do_configure_fontconfig() {
	meson setup \
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
