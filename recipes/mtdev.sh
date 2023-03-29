# Build mtdev v1.1.6


do_return_version_mtdev() {
	echo "mtdev v1.1.6"
}


do_return_depends_mtdev() {
	:
}


do_clean_mtdev() {
	make clean -C "${PACKAGES_DIR}/mtdev"
}


do_fetch_mtdev() {

	[[ -f "${WORKING_DIR}/downloads/mtdev-1.1.6.tar.gz" ]] || {
		wget "https://bitmath.org/code/mtdev/mtdev-1.1.6.tar.gz" -O "${WORKING_DIR}/downloads/mtdev-1.1.6.tar.gz"
		[[ $? -ne 0 ]] && return $FAILURE

		# Just encase mtdev directory get magically created
		rm -rf "${PACKAGES_DIR}/mtdev" 2>/dev/null
	}

	[[ -d "${PACKAGES_DIR}/mtdev" ]] || {
		tar xfz "${WORKING_DIR}/downloads/mtdev-1.1.6.tar.gz" -C "${PACKAGES_DIR}"
		[[ $? -ne 0 ]] && return $FAILURE

		mv "${PACKAGES_DIR}/mtdev-1.1.6" "${PACKAGES_DIR}/mtdev"
	}

	return $SUCCESS
}


do_patch_mtdev() {
	:
}

do_configure_mtdev() {
	cd "${PACKAGES_DIR}/mtdev"

	./configure --prefix="${INSTALLPREFIX}" \
		    --includedir="${INSTALLPREFIX}/include" \
		    --libdir="${INSTALLPREFIX}/lib" || { cd "${CUR_DIR}" ; return $FAILURE ; }

	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_mtdev() {
	make -C "${PACKAGES_DIR}/mtdev" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_mtdev() {
	make install -C "${PACKAGES_DIR}/mtdev" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_mtdev() {
	:
}


do_check_is_built_mtdev() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/mtdev.pc" ]] && return $SUCCESS
	return $FAILURE
}
