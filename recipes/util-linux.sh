# Build util-linux v2.39.3

PV="v2.39.3"

do_return_version_util-linux() {
	echo "util-linux ${PV}"
}


do_return_depends_util-linux() {
	echo "zlib libcap ncurses libxcrypt linux-pam"
}


do_clean_util-linux() {
	rm -rf "${PACKAGES_DIR}/util-linux/build"
}


do_fetch_util-linux() {
	msg="Cloning util-linux"
	clone_and_checkout "${PACKAGES_DIR}/util-linux" "${PV}" "https://github.com/util-linux/util-linux.git" "2da5c904e18fdcffd2b252d641e6f76374c7b406" "${msg}"
	[[ $? -ne 0 ]] && return $FAILURE

	return $SUCCESS
}


do_patch_util-linux() {
	:
}


do_configure_util-linux() {
	meson setup \
	      --buildtype="${MESON_BUILD_TYPE}" \
	      --prefix="${INSTALLPREFIX}" \
	      --libdir="${INSTALLPREFIX}/lib" \
	      --includedir="${INSTALLPREFIX}/include" \
	      -Dc_args="-I${INSTALLPREFIX}/include" \
	      -Dsystemd="disabled" \
	      -Dbuild-libblkid="enabled" \
	      -Dbuild-libuuid="enabled" \
	      -Dbuild-libmount="enabled" \
	      -Dbuild-libfdisk="enabled" \
	      -Dbuild-fdisks="enabled" \
	      -Dbuild-mount="enabled" \
	      -Dbuild-losetup="enabled" \
	      -Dbuild-fsck="enabled" \
	      -Dbuild-bash-completion="disabled" \
	      -Dbuild-pylibmount="disabled" \
	      "${PACKAGES_DIR}/util-linux/build" \
	      "${PACKAGES_DIR}/util-linux" || return $FAILURE

	return $SUCCESS
}


do_compile_util-linux() {
	meson compile -C "${PACKAGES_DIR}/util-linux/build" || return $FAILURE
	return $SUCCESS
}


do_install_util-linux() {
	meson install -C "${PACKAGES_DIR}/util-linux/build" || return $FAILURE
	return $SUCCESS
}


do_update_artifacts_util-linux() {
	:
}


do_check_is_built_util-linux() {
	[[ -f "${INSTALLPREFIX}/lib/pkgconfig/fdisk.pc" ]] && return $SUCCESS
	return $FAILURE
}
