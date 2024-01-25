# Build xkbcommon v1.6.0

PV="1.6.0"

do_return_version_xkbcommon() {
	echo "libxkbcommon v${PV}"
}


do_return_depends_xkbcommon() {
	echo "libxml2 x11 wayland"
}


do_clean_xkbcommon() {
	rm -rf "${PACKAGES_DIR}/xkbcommon/build"
}


do_fetch_xkbcommon() {
	msg="Cloning xkbcommon"
	clone_and_checkout "${PACKAGES_DIR}/xkbcommon" "xkbcommon-${PV}" "https://github.com/xkbcommon/libxkbcommon.git" "d2a08f761c796733e42fac4099f5c38d443e88e1" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_xkbcommon() {
	:
}


do_configure_xkbcommon() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      -Denable-x11="true" \
	      -Denable-wayland="true" \
	      -Denable-docs="false" \
	      -Dbash-completion-path="${INSTALLPREFIX}/usr/share/bash-completion/completions" \
	      "${PACKAGES_DIR}/xkbcommon/build" \
	      "${PACKAGES_DIR}/xkbcommon" || return $FAILURE

	return $SUCCESS
}


do_compile_xkbcommon() {
	meson compile -C "${PACKAGES_DIR}/xkbcommon/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_xkbcommon() {
	meson install -C "${PACKAGES_DIR}/xkbcommon/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_xkbcommon() {
	:
}


do_check_is_built_xkbcommon() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/xkbcommon.pc" ]] && return $SUCCESS
	return $FAILURE
}
