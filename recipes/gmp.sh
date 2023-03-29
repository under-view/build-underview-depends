# Build gmp v6.2.1


do_return_version_gmp() {
	echo "gmp v6.2.1"
}


do_return_depends_gmp() {
	:
}


do_clean_gmp() {
	make clean -C "${PACKAGES_DIR}/gmp"
}


do_fetch_gmp() {
	[[ -f "${WORKING_DIR}/downloads/gmp-2.64.tar.xz" ]] || {
		wget https://gmplib.org/download/gmp/gmp-6.2.1.tar.xz -O "${WORKING_DIR}/downloads/gmp-6.2.1.tar.xz" > /dev/null
		[[ $? -ne 0 ]] && return $FAILURE

		# Just encase gmp folder was created somehow
		rm -rf "${WORKING_DIR}/gmp"
	}

	[[ -d "${PACKAGES_DIR}/gmp" ]] || {
		tar xf "${WORKING_DIR}/downloads/gmp-6.2.1.tar.xz" -C "${PACKAGES_DIR}" || return $FAILURE
		[[ $? -ne 0 ]] && return $FAILURE

		wait $!

		mv "${PACKAGES_DIR}/gmp-6.2.1" "${PACKAGES_DIR}/gmp"
	}

	return $SUCCESS
}


do_patch_gmp() {
	:
}


do_configure_gmp() {
	cd "${PACKAGES_DIR}/gmp"

	./configure --prefix="${INSTALLPREFIX}" \
		    --includedir="${INSTALLPREFIX}/include" \
		    --libdir="${INSTALLPREFIX}/lib" \
		    --bindir="${INSTALLPREFIX}/bin" || { cd "${CUR_DIR}" ; return $FAILURE ; }

	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_gmp() {
	make -C "${PACKAGES_DIR}/gmp" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_gmp() {
	make install -C "${PACKAGES_DIR}/gmp" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_gmp() {
	:
}


do_check_is_built_gmp() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/gmp.pc" ]] && return $SUCCESS
	return $FAILURE
}
