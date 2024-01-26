# Build linux-pam v1.5.3

PV="1.5.3"

do_return_version_linux-pam() {
	echo "linux-pam v${PV}"
}


do_return_depends_linux-pam() {
	echo "libxcrypt libxml2"
}


do_clean_linux-pam() {
	make clean -C "${PACKAGES_DIR}/linux-pam"
}


do_fetch_linux-pam() {
	msg="Cloning linux-pam"
	clone_and_checkout "${PACKAGES_DIR}/linux-pam" "v${PV}" "https://github.com/linux-pam/linux-pam.git" "bf07335a19d6192adaf4b1a817d2101ee0bad134" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_linux-pam() {
	:
}


do_configure_linux-pam() {
	mkdir -p "${INSTALLPREFIX}/share/doc/Linux-PAM-${PV}"

	cd "${PACKAGES_DIR}/linux-pam"
	
	./autogen.sh

	./configure --prefix="${INSTALLPREFIX}" \
		    --libdir="${INSTALLPREFIX}/lib" \
		    --bindir="${INSTALLPREFIX}/bin" \
	            --includedir="${INSTALLPREFIX}/include/security" \
		    --datadir="${INSTALLPREFIX}/usr/share" \
		    --sysconfdir="${INSTALLPREFIX}/etc" \
	            --enable-securedir="${INSTALLPREFIX}/lib/security" \
	            --docdir="${INSTALLPREFIX}/share/doc/Linux-PAM-${PV}" \
	            --disable-nis \
	            --disable-regenerate-docu \
	            --disable-doc \
	            --disable-prelude \
	            --disable-audit \
	            --enable-db="no" \
		    || { cd "${CUR_DIR}" ; return $FAILURE ; }

	cd "${CUR_DIR}"

	return $SUCCESS
}


# Allow failures
# Due to generated Makefile errors
# rm -f as.gmo && : -c --statistics --verbose -o as.gmo as.po
# rm -f bg.gmo && : -c --statistics --verbose -o bg.gmo bg.po
# rm -f be.gmo && : -c --statistics --verbose -o be.gmo be.po
# rm -f bn_IN.gmo && : -c --statistics --verbose -o bn_IN.gmo bn_IN.po
# rm -f bn.gmo && : -c --statistics --verbose -o bn.gmo bn.po
# mv: cannot stat 't-af.gmo': No such file or directory
# mv: cannot stat 't-am.gmo': No such file or directory
# mv: cannot stat 't-ar.gmo': No such file or directory
do_compile_linux-pam() {
	make -C "${PACKAGES_DIR}/linux-pam" -j $BUILDTHREADS
	return $SUCCESS
}


do_install_linux-pam() {
	make install -C "${PACKAGES_DIR}/linux-pam"
	return $SUCCESS
}


do_update_artifacts_linux-pam() {
	:
}


do_check_is_built_linux-pam() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/linux-pam.pc" ]] && return $SUCCESS
	return $FAILURE
}
