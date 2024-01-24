# Build vulkan-validation-layers v1.3.268

PV="1.3.268"

do_return_version_vulkan-validation-layers() {
	echo "vulkan-validation-layers v${PV}"
}


do_return_depends_vulkan-validation-layers() {
	echo "vulkan-headers vulkan-loader spirv-headers spirv-tools glslang vulkan-utility-libraries"
}


do_clean_vulkan-validation-layers() {
	rm -rf "${PACKAGES_DIR}/vulkan-validation-layers/build"
}


do_fetch_vulkan-validation-layers() {
	msg="Cloning Vulkan-ValidationLayers"
	clone_and_checkout "${PACKAGES_DIR}/vulkan-validation-layers" "v${PV}" "https://github.com/KhronosGroup/Vulkan-ValidationLayers.git" "3c64adb4e052062fc60b6580c365429fddfbcfbf" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_vulkan-validation-layers() {
	:
}


do_configure_vulkan-validation-layers() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/vulkan-validation-layers" \
	      -B "${PACKAGES_DIR}/vulkan-validation-layers/build" \
	      -DBUILD_TESTS="OFF" \
	      -DUSE_ROBIN_HOOD_HASHING="OFF" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_vulkan-validation-layers() {
	cmake --build "${PACKAGES_DIR}/vulkan-validation-layers/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_vulkan-validation-layers() {
	cmake --build "${PACKAGES_DIR}/vulkan-validation-layers/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_vulkan-validation-layers() {
	:
}


do_check_is_built_vulkan-validation-layers() {
	[[ -f "${INSTALLPREFIX}/share/vulkan/explicit_layer.d/VkLayer_khronos_validation.json" ]] && return $SUCCESS
	return $FAILURE
}
