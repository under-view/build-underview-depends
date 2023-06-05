# Build dbus v1.13.22


do_return_version_dbus() {
	echo "dbus v1.13.22"
}


do_return_depends_dbus() {
	:
}


do_clean_dbus() {
	rm -rf "${PACKAGES_DIR}/dbus/build"
}


do_fetch_dbus() {
	msg="Cloning dbus"
	clone_and_checkout "${PACKAGES_DIR}/dbus" "dbus-1.13.22" "https://gitlab.freedesktop.org/dbus/dbus.git" "0381298e4565b2dff34c682c8e3d38731d07bc16" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_dbus() {
	:
}


do_configure_dbus() {
	CFLAGS="-I${INSTALLPREFIX}/include" \
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/dbus" \
	      -B "${PACKAGES_DIR}/dbus/build" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DDBUS_INSTALL_DIR="${INSTALLPREFIX}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_dbus() {
	cmake --build "${PACKAGES_DIR}/dbus/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_dbus() {
	cmake --build "${PACKAGES_DIR}/dbus/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_dbus() {
	:
}


do_check_is_built_dbus() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/dbus-1.pc" ]] && return $SUCCESS
	return $FAILURE
}
