# Build shaderc v2023.7

PV="v2023.7"

do_return_version_shaderc() {
	echo "shaderc ${PV}"
}


do_return_depends_shaderc() {
	echo "spirv-headers spirv-tools glslang"
}


do_clean_shaderc() {
	rm -rf "${PACKAGES_DIR}/shaderc/build"
	git -C "${PACKAGES_DIR}/shaderc" reset --hard > /dev/null 2>&1
}


do_fetch_shaderc() {
	msg="Cloning shaderc"
	clone_and_checkout "${PACKAGES_DIR}/shaderc" "${PV}" "https://github.com/google/shaderc.git" "3882b16417077aa8eaa7b5775920e7ba4b8a224d" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_shaderc() {
	git -C "${PACKAGES_DIR}/shaderc" apply "${PATCHES_DIR}/shaderc/0001-CMakeLists.txt-drop-OSDependent-OGLCompiler-from-lis.patch" > /dev/null 2>&1
	[[ $? -ne 0 ]] && return $FAILURE

	git -C "${PACKAGES_DIR}/shaderc" apply "${PATCHES_DIR}/shaderc/0001-cmake-disable-building-external-dependencies.patch" > /dev/null 2>&1
	[[ $? -ne 0 ]] && return $FAILURE

	git -C "${PACKAGES_DIR}/shaderc" apply "${PATCHES_DIR}/shaderc/0002-glslc-libshaderc-util-update-compiler-include-paths.patch" > /dev/null 2>&1
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_configure_shaderc() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/shaderc" \
	      -B "${PACKAGES_DIR}/shaderc/build" \
	      -DBUILD_EXTERNAL="OFF" \
	      -DBUILD_SHARED_LIBS="ON" \
	      -DSHADERC_SKIP_TESTS="ON" \
	      -DSHADERC_SKIP_EXAMPLES="ON" \
	      -DSHADERC_SKIP_COPYRIGHT_CHECK="ON" \
	      -Dglslang_SOURCE_DIR="${PACKAGES_DIR}/glslang" \
	      -Dshaderc_SOURCE_DIR="${PACKAGES_DIR}/shaderc" \
	      -Dspirv-tools_SOURCE_DIR="${PACKAGES_DIR}/spirv-tools" \
	      -DCMAKE_CXX_STANDARD="17" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_LIBDIR="${INSTALLPREFIX}/lib" \
	      -DCMAKE_INSTALL_INCLUDEDIR="${INSTALLPREFIX}/include" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_shaderc() {
	cmake --build "${PACKAGES_DIR}/shaderc/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_shaderc() {
	cmake --build "${PACKAGES_DIR}/shaderc/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_shaderc() {
	:
}


do_check_is_built_shaderc() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/shaderc.pc" ]] && return $SUCCESS
	return $FAILURE
}
