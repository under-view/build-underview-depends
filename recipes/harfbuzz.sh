# Build harfbuzz v8.3.0

PV="8.3.0"

do_return_version_harfbuzz() {
	echo "harfbuzz v${PV}"
}


do_return_depends_harfbuzz() {
	echo "zlib libffi glib gobject-introspection libpng freetype"
}


do_clean_harfbuzz() {
	rm -rf "${PACKAGES_DIR}/harfbuzz/build"
	git -C "${PACKAGES_DIR}/harfbuzz/" reset --hard 2>/dev/null
}


do_fetch_harfbuzz() {
	msg="Cloning harfbuzz"
	clone_and_checkout "${PACKAGES_DIR}/harfbuzz" "${PV}" "https://github.com/harfbuzz/harfbuzz.git" "894a1f72ee93a1fd8dc1d9218cb3fd8f048be29a" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_harfbuzz() {
	:
}


do_configure_harfbuzz() {
	rm -rf "${PACKAGES_DIR}/harfbuzz/subprojects"

	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Dglib="enabled" -Dgobject="enabled" \
	      -Dcairo="disabled" -Dtests="disabled" \
	      -Dfreetype="enabled" -Ddocs="disabled" \
	      "${PACKAGES_DIR}/harfbuzz/build" \
	      "${PACKAGES_DIR}/harfbuzz" || return $FAILURE

	return $SUCCESS
}


do_compile_harfbuzz() {
	meson compile -C "${PACKAGES_DIR}/harfbuzz/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_harfbuzz() {
	meson install -C "${PACKAGES_DIR}/harfbuzz/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_harfbuzz() {
	:
}


do_check_is_built_harfbuzz() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/harfbuzz.pc" ]] && return $SUCCESS
	return $FAILURE
}
