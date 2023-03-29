# Build gslang v11.9.0


do_return_version_gslang() {
	echo "gslang v11.9.0"
}


do_return_depends_gslang() {
	:
}


do_clean_gslang() {
	rm -rf "${PACKAGES_DIR}/gslang/build"
}


do_fetch_gslang() {
	msg="Cloning gslang"
	clone_and_checkout "${PACKAGES_DIR}/gslang" "11.9.0" "https://github.com/KhronosGroup/glslang.git" "9bb8cfffb0eed010e07132282c41d73064a7a609" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_gslang() {
	:
}


do_configure_gslang() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/gslang" \
	      -B "${PACKAGES_DIR}/gslang/build" \
	      -DENABLE_HLSL="ON" \
	      -DCMAKE_BUILD_TYPE=Release \
	      -DBUILD_SHARED_LIBS="ON" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_gslang() {
	cmake --build "${PACKAGES_DIR}/gslang/build" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_gslang() {
	cmake --build "${PACKAGES_DIR}/gslang/build" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_gslang() {
	:
}


do_check_is_built_gslang() {
	[[ -f "${INSTALLPREFIX}/bin/glslangValidator" ]] && return $SUCCESS
	return $FAILURE
}
