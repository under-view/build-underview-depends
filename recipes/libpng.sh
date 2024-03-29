# Build libpng v1.6.40

PV="1.6.40"

do_return_version_libpng() {
	echo "libpng v${PV}"
}


do_return_depends_libpng() {
	echo "zlib"
}


do_clean_libpng() {
	rm -rf "${PACKAGES_DIR}/libpng/build"
}


do_fetch_libpng() {

	[[ -f "${WORKING_DIR}/downloads/libpng-${PV}.tar.gz" ]] || {
		wget "https://versaweb.dl.sourceforge.net/project/libpng/libpng16/${PV}/libpng-${PV}.tar.gz" \
		     -O "${WORKING_DIR}/downloads/libpng-${PV}.tar.gz"
		[[ $? -ne 0 ]] && return $FAILURE

		# Just encase libpng directory get magically created
		rm -rf "${PACKAGES_DIR}/libpng" 2>/dev/null
	}

	[[ -d "${PACKAGES_DIR}/libpng" ]] || {
		tar xfz "${WORKING_DIR}/downloads/libpng-${PV}.tar.gz" -C "${PACKAGES_DIR}"
		[[ $? -ne 0 ]] && return $FAILURE

		mv "${PACKAGES_DIR}/libpng-${PV}" "${PACKAGES_DIR}/libpng"
	}

	return $SUCCESS
}


do_patch_libpng() {
	:
}


do_configure_libpng() {
	cmake -G "${CMAKEGENTYPE}" \
	      -S "${PACKAGES_DIR}/libpng" \
	      -B "${PACKAGES_DIR}/libpng/build" \
	      -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
	      -DCMAKE_PREFIX_PATH="${INSTALLPREFIX}" \
	      -DCMAKE_INSTALL_PREFIX="${INSTALLPREFIX}" || return $FAILURE

	return $SUCCESS
}


do_compile_libpng() {
	cmake --build "${PACKAGES_DIR}/libpng/build" --config "${CMAKE_BUILD_TYPE}" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_libpng() {
	cmake --build "${PACKAGES_DIR}/libpng/build" --config "${CMAKE_BUILD_TYPE}" --target install || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_libpng() {
	:
}


do_check_is_built_libpng() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/libpng16.pc" ]] && return $SUCCESS
	return $FAILURE
}
