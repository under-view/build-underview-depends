# Build libxcrypt v4.4.36

PV="v4.4.36"

do_return_version_libxcrypt() {
	echo "libxcrypt ${PV}"
}


do_return_depends_libxcrypt() {
	:
}


do_clean_libxcrypt() {
	make clean -C "${PACKAGES_DIR}/libxcrypt"
}


do_fetch_libxcrypt() {
	msg="Cloning libxcrypt"
	clone_and_checkout "${PACKAGES_DIR}/libxcrypt" "${PV}" "https://github.com/besser82/libxcrypt.git" "f531a36aa916a22ef2ce7d270ba381e264250cbf" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_libxcrypt() {
	:
}


do_configure_libxcrypt() {
	cd "${PACKAGES_DIR}/libxcrypt"
	
	./autogen.sh

	./configure --prefix="${INSTALLPREFIX}" \
		    --libdir="${INSTALLPREFIX}/lib" \
		    --bindir="${INSTALLPREFIX}/bin" \
		    --datadir="${INSTALLPREFIX}/usr/share" \
	            --enable-hashes="strong,glibc" \
	            --enable-obsolete-api="no" \
	            --disable-static \
	            --disable-failure-tokens \
		    || { cd "${CUR_DIR}" ; return $FAILURE ; }

	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_libxcrypt() {
	make -C "${PACKAGES_DIR}/libxcrypt" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_libxcrypt() {
	make install -C "${PACKAGES_DIR}/libxcrypt" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_libxcrypt() {
	:
}


do_check_is_built_libxcrypt() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/libxcrypt.pc" ]] && return $SUCCESS
	return $FAILURE
}
