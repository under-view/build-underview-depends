# Build llvm v14.0.1


do_return_version_llvm() {
  echo "llvm v14.0.1"
}


do_return_depends_llvm() {
  echo "zlib"
}


do_clean_llvm() {
  rm -rf "${PACKAGES_DIR}/llvm/build"
}


do_fetch_llvm() {
  msg="Cloning llvm"
  clone_and_checkout "${PACKAGES_DIR}/llvm" "llvmorg-14.0.1" "https://github.com/llvm/llvm-project.git" "c62053979489ccb002efe411c3af059addcb5d7d" "${msg}" || return $FAILURE
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
        -DCMAKE_BUILD_TYPE=Release \
        -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86;AArch64;ARM" \
        -DLLVM_TARGET_ARCH=host \
        -DBUILD_SHARED_LIBS=ON \
        -DLLVM_ENABLE_RTTI=ON \
        -DLLVM_ENABLE_LTO=OFF \
        -DLLVM_TOOL_LTO_BUILD=OFF \
        -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

  return $SUCCESS
}


do_compile_llvm() {
  cmake --build "${PACKAGES_DIR}/llvm/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_llvm() {
  cmake --build "${PACKAGES_DIR}/llvm/build" --target install || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_llvm() {
  :
}


do_check_is_built_llvm() {
  [[ -f "${INSTALLPREFIX}/bin/llvm-config" ]] && return $SUCCESS
  return $FAILURE
}
