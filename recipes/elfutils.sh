# Build elfutils v0.189

PV="0.189"

do_return_version_elfutils() {
	echo "elfutils v${PV}"
}


do_return_depends_elfutils() {
	echo "zlib"
}


do_clean_elfutils() {
	make clean -C "${PACKAGES_DIR}/elfutils"
}


do_fetch_elfutils() {
	[[ -f "${WORKING_DIR}/downloads/elfutils-${PV}.tar.bz2" ]] || {
		wget https://sourceware.org/elfutils/ftp/${PV}/elfutils-${PV}.tar.bz2 -O "${WORKING_DIR}/downloads/elfutils-${PV}.tar.bz2"
		[[ $? -ne 0 ]] && return $FAILURE

		# Just encase elfutils folder was created somehow
		rm -rf "${WORKING_DIR}/elfutils"
	}

	[[ -d "${PACKAGES_DIR}/elfutils" ]] || {
		tar xf "${WORKING_DIR}/downloads/elfutils-${PV}.tar.bz2" -C "${PACKAGES_DIR}" || return $FAILURE
		[[ $? -ne 0 ]] && return $FAILURE

		wait $!

		mv "${PACKAGES_DIR}/elfutils-${PV}" "${PACKAGES_DIR}/elfutils"
	}

	return $SUCCESS
}


do_patch_elfutils() {
	:
}


do_configure_elfutils() {
	cd "${PACKAGES_DIR}/elfutils"

	./configure --prefix="${INSTALLPREFIX}" \
		    --includedir="${INSTALLPREFIX}/include" \
		    --libdir="${INSTALLPREFIX}/lib" \
		    --disable-libdebuginfod \
		    --disable-debuginfod \
		    --enable-install-elfh \
		    --with-zlib || { cd "${CUR_DIR}" ; return $FAILURE ; }

	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_elfutils() {
	make -C "${PACKAGES_DIR}/elfutils" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_elfutils() {
	make install -C "${PACKAGES_DIR}/elfutils" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_elfutils() {
	:
}


do_check_is_built_elfutils() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/libelf.pc" ]] && return $SUCCESS
	return $FAILURE
}
