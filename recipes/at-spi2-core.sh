# Build at-spi2-core v2.50.0

PV="2.50.0"

do_return_version_at-spi2-core() {
	echo "at-spi2-core v${PV}"
}


do_return_depends_at-spi2-core() {
	echo "zlib libffi glib x11"
}


do_clean_at-spi2-core() {
	rm -rf "${PACKAGES_DIR}/at-spi2-core/build"
}


do_fetch_at-spi2-core() {
	msg="Cloning at-spi2-core"
	clone_and_checkout "${PACKAGES_DIR}/at-spi2-core" "AT_SPI2_CORE_2_50_0" "https://gitlab.gnome.org/GNOME/at-spi2-core.git" "f711b03a59673a340ebdd2a266c57ad4393a0e71" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_at-spi2-core() {
	:
}


do_configure_at-spi2-core() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Ddocs="false" -Dx11="enabled" \
	      "${PACKAGES_DIR}/at-spi2-core/build" \
	      "${PACKAGES_DIR}/at-spi2-core" || return $FAILURE

	return $SUCCESS
}


do_compile_at-spi2-core() {
	meson compile -C "${PACKAGES_DIR}/at-spi2-core/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_at-spi2-core() {
	meson install -C "${PACKAGES_DIR}/at-spi2-core/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_at-spi2-core() {
	:
}


do_check_is_built_at-spi2-core() {
	[[ -f "${INSTALLPREFIX}/include/at-spi-2.0/atspi/atspi.h" ]] && return $SUCCESS
	return $FAILURE
}
