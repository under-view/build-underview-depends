# Build eigen v3.4.0

PV="3.4.0"

do_return_version_eigen() {
	echo "eigen v${PV}"
}


do_return_depends_eigen() {
	:
}


do_clean_eigen() {
	rm -rf "${PACKAGES_DIR}/eigen/build"
}


do_fetch_eigen() {
	msg="Cloning eigen"
	clone_and_checkout "${PACKAGES_DIR}/eigen" "${PV}" "https://gitlab.com/libeigen/eigen.git" "3147391d946bb4b6c68edd901f2add6ac1f31f8c" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_eigen() {
	:
}


do_configure_eigen() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/eigen" \
	      -B "${PACKAGES_DIR}/eigen/build" \
	      -DBUILD_SHARED_LIBS="ON" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_eigen() {
	cmake --build "${PACKAGES_DIR}/eigen/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_eigen() {
	cmake --build "${PACKAGES_DIR}/eigen/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_eigen() {
	mv "${INSTALLPREFIX}/share/pkgconfig"/* "${INSTALLPREFIX}/lib/pkgconfig"
	rm -rf "${INSTALLPREFIX}/share/pkgconfig"
}


do_check_is_built_eigen() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/eigen3.pc" ]] && return $SUCCESS
	return $FAILURE
}
