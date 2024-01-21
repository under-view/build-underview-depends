# Build llvm v17.0.6

PV="17.0.6"

do_return_version_llvm() {
	echo "llvm v${PV}"
}


do_return_depends_llvm() {
	echo "zlib"
}


do_clean_llvm() {
	rm -rf "${PACKAGES_DIR}/llvm/build"
}


do_fetch_llvm() {
	msg="Cloning llvm"
	clone_and_checkout "${PACKAGES_DIR}/llvm" "llvmorg-${PV}" "https://github.com/llvm/llvm-project.git" "6009708b4367171ccdbf4b5905cb6a803753fe18" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_llvm() {
	:
}


# https://llvm.org/docs/CMake.html#llvm-related-variables
# https://llvm.org/docs/GettingStarted.html#local-llvm-configuration
do_configure_llvm() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/llvm/llvm" \
	      -B "${PACKAGES_DIR}/llvm/build" \
	      -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86" \
	      -DLLVM_TARGET_ARCH="host" \
	      -DLLVM_LINK_LLVM_DYLIB="ON" \
	      -DLLVM_ENABLE_RTTI="ON" \
	      -DLLVM_ENABLE_LTO="OFF" \
	      -DLLVM_TOOL_LTO_BUILD="OFF" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_llvm() {
	cmake --build "${PACKAGES_DIR}/llvm/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_llvm() {
	cmake --build "${PACKAGES_DIR}/llvm/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_llvm() {
	rm "${INSTALLPREFIX}/lib"/*LLVM*.a
	return $SUCCESS
}


do_check_is_built_llvm() {
	[[ -f "${INSTALLPREFIX}/bin/llvm-config" ]] && return $SUCCESS
	return $FAILURE
}
