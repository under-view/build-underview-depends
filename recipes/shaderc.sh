# Build shaderc v2022.1


do_return_version_shaderc() {
	echo "shaderc v2022.1"
}


do_return_depends_shaderc() {
	echo "spirv-headers spirv-tools gslang"
}


do_clean_shaderc() {
	rm -rf "${PACKAGES_DIR}/shaderc/build"
	git -C "${PACKAGES_DIR}/shaderc" reset --hard > /dev/null 2>&1
}


do_fetch_shaderc() {
	msg="Cloning shaderc"
	clone_and_checkout "${PACKAGES_DIR}/shaderc" "v2022.1" "https://github.com/google/shaderc.git" "1bbf43f210941ba69a2cd05cf3529063f1ff5bb9" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_shaderc() {
	git -C "${PACKAGES_DIR}/shaderc" apply "${PATCHES_DIR}/shaderc/0001-CMakeLists-comment-add_subdirectory-third_party-line.patch" > /dev/null 2>&1
	[[ $? -ne 0 ]] && return $FAILURE

	git -C "${PACKAGES_DIR}/shaderc" apply "${PATCHES_DIR}/shaderc/0002-glslc-libshaderc-util-update-compiler-include-paths.patch" > /dev/null 2>&1
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_configure_shaderc() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/shaderc" \
	      -B "${PACKAGES_DIR}/shaderc/build" \
	      -DBUILD_SHARED_LIBS="ON" \
	      -DSHADERC_SKIP_TESTS="ON" \
	      -DSHADERC_SKIP_EXAMPLES="ON" \
	      -Dglslang_SOURCE_DIR="${PACKAGES_DIR}/glslang" \
	      -Dshaderc_SOURCE_DIR="${PACKAGES_DIR}/shaderc" \
	      -Dspirv-tools_SOURCE_DIR="${PACKAGES_DIR}/spirv-tools" \
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
