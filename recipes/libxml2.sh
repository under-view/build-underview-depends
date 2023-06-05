# Build libxml2 v2.9.13


do_return_version_libxml2() {
	echo "libxml2 v2.9.13"
}


do_return_depends_libxml2() {
	echo "zlib"
}


do_clean_libxml2() {
	rm -rf "${PACKAGES_DIR}/libxml2/build"
}


do_fetch_libxml2() {
	msg="Cloning libxml2"
	clone_and_checkout "${PACKAGES_DIR}/libxml2" "v2.9.13" "https://gitlab.gnome.org/GNOME/libxml2.git" "a075d256fd9ff15590b86d981b75a50ead124fca" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_libxml2() {
	:
}


do_configure_libxml2() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/libxml2" \
	      -B "${PACKAGES_DIR}/libxml2/build" \
	      -DLIBXML2_WITH_ICONV="OFF" \
	      -DLIBXML2_WITH_LZMA="OFF" \
	      -DLIBXML2_WITH_PYTHON="OFF" \
	      -DLIBXML2_WITH_TESTS="OFF" \
	      -DBUILD_SHARED_LIBS="ON" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_libxml2() {
	cmake --build "${PACKAGES_DIR}/libxml2/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_libxml2() {
	cmake --build "${PACKAGES_DIR}/libxml2/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_libxml2() {
	:
}


do_check_is_built_libxml2() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/libxml-2.0.pc" ]] && return $SUCCESS
	return $FAILURE
}
