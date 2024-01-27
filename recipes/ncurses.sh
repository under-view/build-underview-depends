# Build ncurses v6.4

PV="v6.4"

do_return_version_ncurses() {
	echo "ncurses ${PV}"
}


do_return_depends_ncurses() {
	:
}


do_clean_ncurses() {
	make clean -C "${PACKAGES_DIR}/ncurses"
}


do_fetch_ncurses() {
	msg="Cloning ncurses"
	clone_and_checkout "${PACKAGES_DIR}/ncurses" "${PV}" "https://github.com/mirror/ncurses.git" "79b9071f2be20a24c7be031655a5638f6032f29f" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_ncurses() {
	:
}


do_configure_ncurses() {
	cd "${PACKAGES_DIR}/ncurses"

	./configure --prefix="${INSTALLPREFIX}" \
		    --libdir="${INSTALLPREFIX}/lib" \
		    --bindir="${INSTALLPREFIX}/bin" \
		    --datadir="${INSTALLPREFIX}/usr/share" \
	            --without-debug \
	            --without-ada \
	            --without-gpm \
	            --enable-hard-tabs \
	            --enable-xmc-glitch \
	            --enable-colorfgbg \
	            --with-shared \
	            --disable-big-core \
	            --program-prefix= \
	            --with-ticlib \
	            --enable-sigwinch \
	            --disable-rpath-hack \
	            --with-manpage-format=normal \
	            --without-manpage-renames \
	            --disable-stripping \
	            --enable-pc-files \
	            --with-pkg-config-libdir="${INSTALLPREFIX}/lib/pkgconfig" \
		    || { cd "${CUR_DIR}" ; return $FAILURE ; }

	cd "${CUR_DIR}"

	return $SUCCESS
}


do_compile_ncurses() {
	make -C "${PACKAGES_DIR}/ncurses" -j $BUILDTHREADS || return $FAILURE
	return $SUCCESS
}


do_install_ncurses() {
	make install -C "${PACKAGES_DIR}/ncurses" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_ncurses() {
	rm "${INSTALLPREFIX}/bin/clear"
	return $SUCCESS
}


do_check_is_built_ncurses() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/ncurses.pc" ]] && return $SUCCESS
	return $FAILURE
}
