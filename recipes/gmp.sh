# Build gmp v6.3.0

PV="6.3.0"

do_return_version_gmp() {
	echo "gmp v${PV}"
}


do_return_depends_gmp() {
	:
}


do_clean_gmp() {
	make clean -C "${PACKAGES_DIR}/gmp"
}


do_fetch_gmp() {
	[[ -f "${WORKING_DIR}/downloads/gmp-${PV}.tar.xz" ]] || {
		wget https://gmplib.org/download/gmp/gmp-${PV}.tar.xz -O "${WORKING_DIR}/downloads/gmp-${PV}.tar.xz" > /dev/null
		[[ $? -ne 0 ]] && return $FAILURE

		# Just encase gmp folder was created somehow
		rm -rf "${WORKING_DIR}/gmp"
	}

	[[ -d "${PACKAGES_DIR}/gmp" ]] || {
		tar xf "${WORKING_DIR}/downloads/gmp-${PV}.tar.xz" -C "${PACKAGES_DIR}" || return $FAILURE
		[[ $? -ne 0 ]] && return $FAILURE

		wait $!

		mv "${PACKAGES_DIR}/gmp-${PV}" "${PACKAGES_DIR}/gmp"
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
