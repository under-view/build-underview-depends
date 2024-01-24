# Build vulkan-utility-libraries v1.3.268

PV="1.3.268"

do_return_version_vulkan-utility-libraries() {
	echo "vulkan-utility-libraries v${PV}"
}


do_return_depends_vulkan-utility-libraries() {
	echo "vulkan-headers"
}


do_clean_vulkan-utility-libraries() {
	rm -rf "${PACKAGES_DIR}/vulkan-utility-libraries/build"
}


do_fetch_vulkan-utility-libraries() {
	msg="Cloning vulkan-utility-libraries"
	clone_and_checkout "${PACKAGES_DIR}/vulkan-utility-libraries" "v${PV}" "https://github.com/KhronosGroup/Vulkan-Utility-Libraries.git" "c9ca4ac620a238a93c65d864f2eaa33954d74509" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_vulkan-utility-libraries() {
	:
}


do_configure_vulkan-utility-libraries() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/vulkan-utility-libraries" \
	      -B "${PACKAGES_DIR}/vulkan-utility-libraries/build" \
	      -DBUILD_TESTS="OFF" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_vulkan-utility-libraries() {
	cmake --build "${PACKAGES_DIR}/vulkan-utility-libraries/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_vulkan-utility-libraries() {
	cmake --build "${PACKAGES_DIR}/vulkan-utility-libraries/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_vulkan-utility-libraries() {
	:
}


do_check_is_built_vulkan-utility-libraries() {
	[[ -f "${INSTALLPREFIX}/share/vulkan/explicit_layer.d/VkLayer_khronos_validation.json" ]] && return $SUCCESS
	return $FAILURE
}
