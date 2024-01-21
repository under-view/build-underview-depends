# Build libffi v3.4.4

PV="v3.4.4"

do_return_version_libffi() {
	echo "libffi ${PV}"
}


do_return_depends_libffi() {
	:
}


do_clean_libffi() {
	make clean -C "${PACKAGES_DIR}/libffi"
}


do_fetch_libffi() {
	msg="Cloning libffi"
	clone_and_checkout "${PACKAGES_DIR}/libffi" "${PV}" "https://github.com/libffi/libffi.git" "f24180be1367f942824365b131ae894b9c769c7d" "${msg}" || return $FAILURE
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_libffi() {
	:
}


do_configure_libffi() {
	cd "${PACKAGES_DIR}/libffi"
	./autogen.sh --prefix="${INSTALLPREFIX}" || { cd "${CUR_DIR}" ; return $FAILURE ; }

	./configure --prefix="${INSTALLPREFIX}" \
		    --with-sysroot="${INSTALLPREFIX}" \
		    --includedir="${INSTALLPREFIX}/include" \
		    --libdir="${INSTALLPREFIX}/lib" \
		    --disable-docs --disable-multi-os-directory \
		    || { cd "${CUR_DIR}" ; return $FAILURE ; }

	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_libffi() {
	make -C "${PACKAGES_DIR}/libffi" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_libffi() {
	make install -C "${PACKAGES_DIR}/libffi" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_libffi() {
	:
}


do_check_is_built_libffi() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/libffi.pc" ]] && return $SUCCESS
	return $FAILURE
}
