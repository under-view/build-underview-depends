# Build mpfr v4.2.1

PV="4.2.1"

do_return_version_mpfr() {
	echo "mpfr v${PV}"
}


do_return_depends_mpfr() {
	:
}


do_clean_mpfr() {
	make clean -C "${PACKAGES_DIR}/mpfr"
}


do_fetch_mpfr() {
	[[ -f "${WORKING_DIR}/downloads/mpfr-${PV}.tar.xz" ]] || {
		wget https://www.mpfr.org/mpfr-${PV}/mpfr-${PV}.tar.xz -O "${WORKING_DIR}/downloads/mpfr-${PV}.tar.xz" > /dev/null
		[[ $? -ne 0 ]] && return $FAILURE

		# Just encase mpfr folder was created somehow
		rm -rf "${WORKING_DIR}/mpfr"
	}

	[[ -d "${PACKAGES_DIR}/mpfr" ]] || {
		tar xf "${WORKING_DIR}/downloads/mpfr-${PV}.tar.xz" -C "${PACKAGES_DIR}" || return $FAILURE
		[[ $? -ne 0 ]] && return $FAILURE

		wait $!

		mv "${PACKAGES_DIR}/mpfr-${PV}" "${PACKAGES_DIR}/mpfr"
	}

	return $SUCCESS
}


do_patch_mpfr() {
	:
}


do_configure_mpfr() {
	cd "${PACKAGES_DIR}/mpfr"

	./configure --prefix="${INSTALLPREFIX}" \
	            --with-gmp-include="${INSTALLPREFIX}/include" \
		    --includedir="${INSTALLPREFIX}/include" \
		    --libdir="${INSTALLPREFIX}/lib" \
		    --bindir="${INSTALLPREFIX}/bin" || { cd "${CUR_DIR}" ; return $FAILURE ; }

	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_mpfr() {
	make -C "${PACKAGES_DIR}/mpfr" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_mpfr() {
	make install -C "${PACKAGES_DIR}/mpfr" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_mpfr() {
	:
}


do_check_is_built_mpfr() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/mpfr.pc" ]] && return $SUCCESS
	return $FAILURE
}
