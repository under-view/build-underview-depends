# Build spirv-headers sdk-1.3.231.1


do_return_version_spirv-headers() {
	echo "spirv-headers sdk-1.3.231.1"
}


do_return_depends_spirv-headers() {
	:
}


do_clean_spirv-headers() {
	rm -rf "${PACKAGES_DIR}/spirv-headers/build"
}


do_fetch_spirv-headers() {
	msg="Cloning spirv-headers"
	clone_and_checkout "${PACKAGES_DIR}/spirv-headers" "sdk-1.3.231.1" "https://github.com/KhronosGroup/SPIRV-Headers.git" "85a1ed200d50660786c1a88d9166e871123cce39" "${msg}" || return $FAILURE
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
	      -DCMAKE_BUILD_TYPE=Release \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_spirv-headers() {
	cmake --build "${PACKAGES_DIR}/spirv-headers/build" --config Release -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_spirv-headers() {
	cmake --build "${PACKAGES_DIR}/spirv-headers/build" --config Release --target install || return $FAILURE
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
