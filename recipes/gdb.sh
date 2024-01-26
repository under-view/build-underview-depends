# Build gdb v14.1

PV="14.1"

do_return_version_gdb() {
	echo "gdb v${PV}"
}


do_return_depends_gdb() {
	echo "zlib gmp mpfr"
}


do_clean_gdb() {
	make clean -C "${PACKAGES_DIR}/gdb"
}


do_fetch_gdb() {
	msg="Cloning gdb"
	clone_and_checkout "${PACKAGES_DIR}/gdb" "gdb-${PV}-release" "git://sourceware.org/git/binutils-gdb.git" "6bda1c19bcd16eff8488facb8a67d52a436f70e7" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_gdb() {
	:
}


do_configure_gdb() {
	cd "${PACKAGES_DIR}/gdb"

	./configure --prefix="${INSTALLPREFIX}" \
	            --with-mpfr-include="${INSTALLPREFIX}/include" \
	            --with-gmp-include="${INSTALLPREFIX}/include" \
		    --includedir="${INSTALLPREFIX}/include" \
		    --libdir="${INSTALLPREFIX}/lib" \
		    --bindir="${INSTALLPREFIX}/bin" || { cd "${CUR_DIR}" ; return $FAILURE ; }

	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_gdb() {
	make -C "${PACKAGES_DIR}/gdb" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_gdb() {
	make install -C "${PACKAGES_DIR}/gdb" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_gdb() {
	:
}


do_check_is_built_gdb() {
	[[ -f "${INSTALLPREFIX}/bin/gdb" ]] && return $SUCCESS
	return $FAILURE
}
