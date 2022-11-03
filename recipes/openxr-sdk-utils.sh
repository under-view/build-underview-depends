# Build openxr-sdk-utils v1.0.25


do_return_version_openxr-sdk-utils() {
  echo "openxr-sdk-utils v1.0.25"
}


do_return_depends_openxr-sdk-utils() {
  echo "x11 xext xrandr gslang vulkan-headers vulkan-loader mesa"
}


do_clean_openxr-sdk-utils() {
  rm -rf "${PACKAGES_DIR}/openxr-sdk-utils/build"
}


do_fetch_openxr-sdk-utils() {
  msg="Cloning openxr-sdk-utils"
  clone_and_checkout "${PACKAGES_DIR}/openxr-sdk-utils" "release-1.0.25" "https://github.com/KhronosGroup/OpenXR-SDK-Source.git" "15c3d8eb99994e5365d6b6f96eefaf4c51a65a9d" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_openxr-sdk-utils() {
  :
}


do_configure_openxr-sdk-utils() {
  cmake -G "${CMAKEGENTYPE}" \
        -S "${PACKAGES_DIR}/openxr-sdk-utils" \
        -B "${PACKAGES_DIR}/openxr-sdk-utils/build" \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=ON \
        -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

  return $SUCCESS
}


do_compile_openxr-sdk-utils() {
  cmake --build "${PACKAGES_DIR}/openxr-sdk-utils/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_openxr-sdk-utils() {
  cmake --build "${PACKAGES_DIR}/openxr-sdk-utils/build" --target install || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_openxr-sdk-utils() {
  :
}


do_check_is_built_openxr-sdk-utils() {
  [[ -f "${INSTALLPREFIX}/lib/pkgconfig/openxr.pc" ]] && return $SUCCESS
  return $FAILURE
}
