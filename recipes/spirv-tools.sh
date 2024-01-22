# Build spirv-tools v1.3.268.0

PV="1.3.268.0"

do_return_version_spirv-tools() {
	echo "spirv-tools v${PV}"
}


do_return_depends_spirv-tools() {
	echo "spriv-headers"
}


do_clean_spirv-tools() {
	rm -rf "${PACKAGES_DIR}/spirv-tools/build"
}


do_fetch_spirv-tools() {
	msg="Cloning spirv-tools"
	clone_and_checkout "${PACKAGES_DIR}/spirv-tools" "vulkan-sdk-${PV}" "https://github.com/KhronosGroup/SPIRV-Tools.git" "360d469b9eac54d6c6e20f609f9ec35e3a5380ad" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_spirv-tools() {
	:
}


do_configure_spirv-tools() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/spirv-tools" \
	      -B "${PACKAGES_DIR}/spirv-tools/build" \
	      -DBUILD_SHARED_LIBS="1" \
	      -DSPIRV_TOOLS_BUILD_STATIC="OFF" \
	      -DSPIRV-Headers_SOURCE_DIR="${PACKAGES_DIR}/spirv-headers" \
	      -DSPIRV_HEADER_INCLUDE_DIR="${INSTALLPREFIX}/include/spirv" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_spirv-tools() {
	cmake --build "${PACKAGES_DIR}/spirv-tools/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_spirv-tools() {
	cmake --build "${PACKAGES_DIR}/spirv-tools/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_spirv-tools() {
	:
}


do_check_is_built_spirv-tools() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/SPIRV-Tools-shared.pc" ]] && return $SUCCESS
	return $FAILURE
}
