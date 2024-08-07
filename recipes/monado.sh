# Build monado HEAD

PV="HEAD"

do_return_version_monado() {
	echo "monado ${PV}"
}


do_return_depends_monado() {
	echo "wayland x11 xext xrandr gslang vulkan-headers vulkan-loader glvnd mesa systemd openxr-sdk eigen"
}


do_clean_monado() {
	rm -rf "${PACKAGES_DIR}/monado/build"
}


do_fetch_monado() {
	msg="Cloning Monado"
	clone_and_checkout "${PACKAGES_DIR}/monado" "main" "https://gitlab.freedesktop.org/monado/monado.git" "112dc3197fc09a7479c1e3861b103de206a3df0c" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_monado() {
	:
}


do_configure_monado() {
	CFLAGS="-I${INSTALLPREFIX}/include" \
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/monado" \
	      -B "${PACKAGES_DIR}/monado/build" \
	      -DXRT_BUILD_DRIVER_NS="ON" \
	      -DFEATURE_STEAMVR_PLUGIN="ON" \
	      -DXRT_BUILD_DRIVER_ARDUINO="OFF" \
	      -DBUILD_SHARED_LIBS="ON" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_monado() {
	cmake --build "${PACKAGES_DIR}/monado/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_monado() {
	cmake --build "${PACKAGES_DIR}/monado/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_monado() {
	:
}


do_check_is_built_monado() {
	[[ -f "${INSTALLPREFIX}/bin/monado-service" ]] && return $SUCCESS
	return $FAILURE
}
