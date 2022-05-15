# Build spirv-tools v2022.2


do_return_version_spirv-tools() {
  echo "spirv-tools v2022.2"
}


do_return_depends_spirv-tools() {
  echo "spriv-headers"
}


do_clean_spirv-tools() {
  rm -rf "${PACKAGES_DIR}/spirv-tools/build"
}


do_fetch_spirv-tools() {
  msg="Cloning spirv-tools"
  clone_and_checkout "${PACKAGES_DIR}/spirv-tools" "v2022.2" "https://github.com/KhronosGroup/SPIRV-Tools.git" "7826e1941eab1aa66fbe84c48b95921bff402a96" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_spirv-tools() {
  :
}


do_configure_spirv-tools() {
  cmake -G "${CMAKGENTYPE}" \
        -S "${PACKAGES_DIR}/spirv-tools" \
        -B "${PACKAGES_DIR}/spirv-tools/build" \
        -DSPIRV-Headers_SOURCE_DIR="${PACKAGES_DIR}/spirv-headers" \
        -DSPIRV_HEADER_INCLUDE_DIR="${INSTALLPREFIX}/include/spirv" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

  return $SUCCESS
}


do_compile_spirv-tools() {
  cmake --build "${PACKAGES_DIR}/spirv-tools/build" --config Release -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_spirv-tools() {
  cmake --build "${PACKAGES_DIR}/spirv-tools/build" --config Release --target install || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_spirv-tools() {
  :
}


do_check_is_built_spirv-tools() {
  [[ -f "${INSTALLPREFIX}/include/spirv/1.2/spirv.h" ]] && return $SUCCESS
  return $FAILURE
}
