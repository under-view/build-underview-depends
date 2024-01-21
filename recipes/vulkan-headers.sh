# Build vulkan-headers v1.3.268.0

PV="1.3.268.0"

do_return_version_vulkan-headers() {
	echo "vulkan-headers v${PV}"
}


do_return_depends_vulkan-headers() {
	echo "zlib"
}


do_clean_vulkan-headers() {
	rm -rf "${PACKAGES_DIR}/vulkan-headers/build"
}


do_fetch_vulkan-headers() {
	msg="Cloning vulkan-headers"
	clone_and_checkout "${PACKAGES_DIR}/vulkan-headers" "vulkan-sdk-${PV}" "https://github.com/KhronosGroup/Vulkan-Headers.git" "7b3466a1f47a9251ac1113efbe022ff016e2f95b" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_vulkan-headers() {
	:
}


do_configure_vulkan-headers() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/vulkan-headers" \
	      -B "${PACKAGES_DIR}/vulkan-headers/build" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_vulkan-headers() {
	cmake --build "${PACKAGES_DIR}/vulkan-headers/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_vulkan-headers() {
	cmake --build "${PACKAGES_DIR}/vulkan-headers/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_vulkan-headers() {
	:
}


do_check_is_built_vulkan-headers() {
	[[ -f "${INSTALLPREFIX}/include/vulkan/vulkan.h" ]] && return $SUCCESS
	return $FAILURE
}
