# Build glslang v1.3.268.0

PV="1.3.268.0"

do_return_version_glslang() {
	echo "glslang v${PV}"
}


do_return_depends_glslang() {
	:
}


do_clean_glslang() {
	rm -rf "${PACKAGES_DIR}/glslang/build"
}


do_fetch_glslang() {
	msg="Cloning glslang"
	clone_and_checkout "${PACKAGES_DIR}/glslang" "vulkan-sdk-${PV}" "https://github.com/KhronosGroup/glslang.git" "9bb8cfffb0eed010e07132282c41d73064a7a609" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_glslang() {
	:
}


do_configure_glslang() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/glslang" \
	      -B "${PACKAGES_DIR}/glslang/build" \
	      -DENABLE_HLSL="ON" \
	      -DBUILD_SHARED_LIBS="ON" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_glslang() {
	cmake --build "${PACKAGES_DIR}/glslang/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_glslang() {
	cmake --build "${PACKAGES_DIR}/glslang/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_glslang() {
	:
}


do_check_is_built_glslang() {
	[[ -f "${INSTALLPREFIX}/bin/glslangValidator" ]] && return $SUCCESS
	return $FAILURE
}
