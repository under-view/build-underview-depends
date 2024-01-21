# Build zlib v1.3

PV="v1.3"

do_return_version_zlib() {
	echo "zlib ${PV}"
}


do_return_depends_zlib() {
	:
}


do_clean_zlib() {
	rm -rf "${PACKAGES_DIR}/zlib/build"
}


do_fetch_zlib() {
	msg="Cloning zlib"
	clone_and_checkout "${PACKAGES_DIR}/zlib" "${PV}" "https://github.com/madler/zlib.git" "09155eaa2f9270dc4ed1fa13e2b4b2613e6e4851" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_zlib() {
	:
}


do_configure_zlib() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/zlib" \
	      -B "${PACKAGES_DIR}/zlib/build" \
	      -DBUILD_SHARED_LIBS="ON" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_zlib() {
	cmake --build "${PACKAGES_DIR}/zlib/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_zlib() {
	cmake --build "${PACKAGES_DIR}/zlib/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_zlib() {
	mv "${INSTALLPREFIX}/share/pkgconfig"/* "${INSTALLPREFIX}/lib/pkgconfig"
	rm -rf "${INSTALLPREFIX}/share/pkgconfig"
	return $SUCCESS
}


do_check_is_built_zlib() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/zlib.pc" ]] && return $SUCCESS
	return $FAILURE
}
