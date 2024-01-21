# Build spirv-headers v1.3.268.0

PV="1.3.268.0"

do_return_version_spirv-headers() {
	echo "spirv-headers v${PV}"
}


do_return_depends_spirv-headers() {
	:
}


do_clean_spirv-headers() {
	rm -rf "${PACKAGES_DIR}/spirv-headers/build"
}


do_fetch_spirv-headers() {
	msg="Cloning spirv-headers"
	clone_and_checkout "${PACKAGES_DIR}/spirv-headers" "vulkan-sdk-${PV}" "https://github.com/KhronosGroup/SPIRV-Headers.git" "e867c06631767a2d96424cbec530f9ee5e78180" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_spirv-headers() {
	:
}


do_configure_spirv-headers() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/spirv-headers" \
	      -B "${PACKAGES_DIR}/spirv-headers/build" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_spirv-headers() {
	cmake --build "${PACKAGES_DIR}/spirv-headers/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_spirv-headers() {
	cmake --build "${PACKAGES_DIR}/spirv-headers/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_spirv-headers() {
	mv "${INSTALLPREFIX}/share/pkgconfig"/* "${INSTALLPREFIX}/lib/pkgconfig"
	rm -rf "${INSTALLPREFIX}/share/pkgconfig"
}


do_check_is_built_spirv-headers() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/SPIRV-Headers.pc" ]] && return $SUCCESS
	return $FAILURE
}
