# Build valgrind v3.19.0


do_return_version_valgrind() {
	echo "valgrind v3.19.0"
}


do_return_depends_valgrind() {
	:
}


do_clean_valgrind() {
	make clean -C "${PACKAGES_DIR}/valgrind"
}


do_fetch_valgrind() {
	msg="Cloning valgrind"
	clone_and_checkout "${PACKAGES_DIR}/valgrind" "VALGRIND_3_19_0" "git://sourceware.org/git/valgrind.git" "8d3c8034b87db7b1d47285b053a05e6ad277c0d1" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_valgrind() {
	:
}


do_configure_valgrind() {
	cd "${PACKAGES_DIR}/valgrind"
	./autogen.sh || { cd "${CUR_DIR}" ; return $FAILURE ; }

	CFLAGS="-I/usr/include/x86_64-linux-gnu/" \
	./configure --prefix="${INSTALLPREFIX}" \
		    --includedir="${INSTALLPREFIX}/include" \
		    --libdir="${INSTALLPREFIX}/lib" \
		    --bindir="${INSTALLPREFIX}/bin" || { cd "${CUR_DIR}" ; return $FAILURE ; }

	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_valgrind() {
	make -C "${PACKAGES_DIR}/valgrind" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_valgrind() {
	make install -j $BUILDTHREADS -C "${PACKAGES_DIR}/valgrind" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_valgrind() {
	:
}


do_check_is_built_valgrind() {
	[[ -f "${INSTALLPREFIX}/bin/valgrind" ]] && return $SUCCESS
	return $FAILURE
}
