# Build OpenXR-SDK v1.0.25


do_return_version_openxr-sdk() {
  echo "OpenXR-SDK v1.0.25"
}


do_return_depends_openxr-sdk() {
  echo "x11 xext xrandr gslang vulkan-headers vulkan-loader mesa"
}


do_clean_openxr-sdk() {
  rm -rf "${PACKAGES_DIR}/OpenXR-SDK/build"
}


do_fetch_openxr-sdk() {
  msg="Cloning OpenXR-SDK"
  clone_and_checkout "${PACKAGES_DIR}/OpenXR-SDK" "release-1.0.25" "https://github.com/KhronosGroup/OpenXR-SDK.git" "c16a18c99740ea5dd251e3af117e0e5aea4ceaa9" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_openxr-sdk() {
  :
}


do_configure_openxr-sdk() {
  cmake -G "${CMAKGENTYPE}" \
        -S "${PACKAGES_DIR}/OpenXR-SDK" \
        -B "${PACKAGES_DIR}/OpenXR-SDK/build" \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=ON \
        -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

  return $SUCCESS
}


do_compile_openxr-sdk() {
  cmake --build "${PACKAGES_DIR}/OpenXR-SDK/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_openxr-sdk() {
  cmake --build "${PACKAGES_DIR}/OpenXR-SDK/build" --target install || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_openxr-sdk() {
  :
}


do_check_is_built_openxr-sdk() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/openxr.pc" ]] && return $SUCCESS
  return $FAILURE
}
