# Build hwdata v0.377

PV="v0.377"

do_return_version_hwdata() {
	echo "hwdata ${PV}"
}


do_return_depends_hwdata() {
	:
}


do_clean_hwdata() {
	make clean -C "${PACKAGES_DIR}/hwdata"
}


do_fetch_hwdata() {
	msg="Cloning hwdata"
	clone_and_checkout "${PACKAGES_DIR}/hwdata" "${PV}" "https://github.com/vcrhonek/hwdata.git" "7c46440af001d0bc8230b6f009b73a25b614e032" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_hwdata() {
	:
}


do_configure_hwdata() {
	cd "${PACKAGES_DIR}/hwdata"

	./configure --prefix="${INSTALLPREFIX}" \
		    --libdir="${INSTALLPREFIX}/lib" \
		    --bindir="${INSTALLPREFIX}/bin" \
		    --datadir="${INSTALLPREFIX}/usr/share" \
		    || { cd "${CUR_DIR}" ; return $FAILURE ; }

	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_hwdata() {
	make -C "${PACKAGES_DIR}/hwdata" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_hwdata() {
	make install -C "${PACKAGES_DIR}/hwdata" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_hwdata() {
	mv "${INSTALLPREFIX}/usr/share/pkgconfig"/*.pc "${INSTALLPREFIX}/lib/pkgconfig"
	rm -rf "${INSTALLPREFIX}/usr/share/pkgconfig"
	sed -i "s:\${pc_sysrootdir}::g" "${INSTALLPREFIX}/lib/pkgconfig/hwdata.pc"
	return $SUCCESS
}


do_check_is_built_hwdata() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/hwdata.pc" ]] && return $SUCCESS
	return $FAILURE
}
