# Build monado v1.0.25


do_return_version_monado() {
  echo "monado v1.0.25"
}


do_return_depends_monado() {
  echo "wayland x11 xext xrandr gslang vulkan-headers vulkan-loader glvnd mesa systemd openxr-sdk eigen"
}


do_clean_monado() {
  rm -rf "${PACKAGES_DIR}/monado/build"
}


do_fetch_monado() {
  msg="Cloning Monado"
  clone_and_checkout "${PACKAGES_DIR}/monado" "main" "https://gitlab.freedesktop.org/monado/monado.git" "74d82ff37fe19f74876472ea00d9223df4dff764" "${msg}" || return $FAILURE
  [[ $? -ne 0 ]] && return $FAILURE

  return $SUCCESS
}


do_patch_monado() {
  :
}


do_configure_monado() {
  cmake -G "${CMAKEGENTYPE}" \
        -S "${PACKAGES_DIR}/monado" \
        -B "${PACKAGES_DIR}/monado/build" \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=ON \
        -DXRT_BUILD_DRIVER_NS=ON \
        -DFEATURE_STEAMVR_PLUGIN=ON \
        -DXRT_BUILD_DRIVER_ARDUINO=OFF \
        -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
        -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

  return $SUCCESS
}


do_compile_monado() {
  cmake --build "${PACKAGES_DIR}/monado/build" -j $BUILDTHREADS || return $FAILURE
  return $SUCCESS
}


do_install_monado() {
  cmake --build "${PACKAGES_DIR}/monado/build" --target install || return $FAILURE
  return $SUCCESS
}


do_update_artifacts_monado() {
  :
}


do_check_is_built_monado() {
  [[ -f "${INSTALLPREFIX}/bin/monado-service" ]] && return $SUCCESS
  return $FAILURE
}
