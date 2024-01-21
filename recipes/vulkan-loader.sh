# Build vulkan-loader v1.3.268.0

PV="1.3.268.0"

do_return_version_vulkan-loader() {
	echo "vulkan-loader v${PV}"
}


do_return_depends_vulkan-loader() {
	echo "wayland wayland-protocols xcb x11 xext xrandr vulkan-headers"
}


do_clean_vulkan-loader() {
	rm -rf "${PACKAGES_DIR}/vulkan-loader/build"
}


do_fetch_vulkan-loader() {
	msg="Cloning vulkan-loader"
	clone_and_checkout "${PACKAGES_DIR}/vulkan-loader" "vulkan-sdk-${PV}" "https://github.com/KhronosGroup/Vulkan-Loader.git" "f4c838e2e7358fc450f8112119bbdbb5b03e03fa" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_vulkan-loader() {
	:
}


do_configure_vulkan-loader() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/vulkan-loader" \
	      -B "${PACKAGES_DIR}/vulkan-loader/build" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_vulkan-loader() {
	cmake --build "${PACKAGES_DIR}/vulkan-loader/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_vulkan-loader() {
	cmake --build "${PACKAGES_DIR}/vulkan-loader/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_vulkan-loader() {
	:
}


do_check_is_built_vulkan-loader() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/vulkan.pc" ]] && return $SUCCESS
	return $FAILURE
}
