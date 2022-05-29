#!/bin/bash

# Determine if bash script has been sourced or not
# source'ing is strictly used for development work
[[ $_ != $0 ]] && SOURCED=1 || SOURCED=0


######################################################################################################
# CUR_DIR          : You guessed it
# PATCHES_DIR      : The directory where any patches that need to be applied to source code resides
# WORKING_DIR      : The directory where lib and exec building happens
# BUILD_OUTPUT_DIR : The directory where all dynamic libs, headers, pc files, def files, etc...
# PACKAGES_DIR     : The directory where all repo are clone and packages extracted
# DOWNLOADS_DIR    : The directory where all packages are downloaded into
# SUCCESS          : The number returned by functions on success
# FAILURE          : The number returned by functions on failure
# RECIPES          : List of all packages who's artifacts will be installed into $BUILD_OUTPUT_DIR
######################################################################################################
CUR_DIR="$(pwd)"
PATCHES_DIR="${CUR_DIR}/patches"
WORKING_DIR="${CUR_DIR}/working"
BUILD_OUTPUT_DIR="${WORKING_DIR}/build_output"
PACKAGES_DIR="${WORKING_DIR}/packages"
DOWNLOADS_DIR="${WORKING_DIR}/downloads"

SUCCESS=0
FAILURE=1

# RECIPES array to determine what pkgs to install
RECIPES=()


#############################################################
# Just to have a colorful console out
#############################################################
print_me() {
  case $1 in
  success) printf "\e[32;1m" ;;
  err)     printf "\e[31;1m" ;;
  info)    printf "\e[34;1m" ;;
  warn)    printf "\e[33;1m" ;;
  *)       return $FAILURE
  esac

  # print output and reset terminal color
  printf "${@:2}" ; printf "\x1b[0m"

  return $SUCCESS
}


#############################################################################
# Basically clean any build artifacts process cross platform and
# reset github repo commits to the specific one used when compiled
#############################################################################
do_clean() {
  for recipe in "${RECIPES[@]}"; do do_clean_${recipe} > /dev/null 2>&1; done
}


##############################################################################
# Clone remote repo at a given branch then checkout to a single commit
# ARGS:
#   1. work_dir: Directory where repo will reside
#   2. branch: The branch to clone
#   3. url: The url for the repo
#   4. commit: The specific commit to switch to
#   5. msg: Message to display before cloning
# Returns:
#   0 on success
#   1 on failure
##############################################################################
clone_and_checkout() {
  work_dir="$1" ; branch="$2"
  url="$3" ; commit="$4" ; msg="$5"

  [[ -d "${work_dir}" ]] || {
    print_me warn "${msg}\n"
    git clone -b "${branch}" "${url}" "${work_dir}"
    [[ $? -ne 0 ]] && return $FAILURE

    git -C "${work_dir}" checkout "${commit}" > /dev/null 2>&1
    [[ $? -ne 0 ]] && return $FAILURE
  }

  return $SUCCESS
}


###########################################################################################################################
# Configure what we need for building all libs cross platform
#   1. First create all directories needed
#   1. Add CMAKGENTYPE variable so there's one variable that determines what build system to use
#   4. Add BUILDTHREADS variable to specify cpu core count when building with ninja/make/etc..
#   5. Update INSTALLPREFIX to equal $BUILD_OUTPUT_DIR as its used with the --prefix flag to place built libs
#   6. Update ACLOCAL/ACLOCAL_PATH to point to $BUILD_OUTPUT_DIR/share/aclocal currently useful when building Xorg libs
#   7. Update PKG_CONFIG_PATH to point to package files located at ${BUILD_OUTPUT_DIR}/lib/pkgconfig and export it
#      so that the variable change is seen throughout the build process.
#   2. Update LDFLAGS so that we are setting rpath of binaries to ${BUILD_OUTPUT_DIR}/lib. Adds redundant
#      linker flag -L to ensure that we are using our prebuilt libs over the system
###########################################################################################################################
do_configure_build_vars() {
  mkdir -p "${DOWNLOADS_DIR}"
  mkdir -p "${BUILD_OUTPUT_DIR}"/{bin,include,lib/pkgconfig,share/aclocal}
  mkdir -p "${PACKAGES_DIR}"

  # So the OOM (out of memory) killer doesn't give us random build errors
  CCNT=$(nproc)
  [[ -n "$TASKTHREADS" ]]  || export TASKTHREADS=$(($CCNT/2))
  [[ -n "$BUILDTHREADS" ]] || export BUILDTHREADS=$(($CCNT/2))
  export CMAKGENTYPE="Ninja"
  export INSTALLPREFIX="${BUILD_OUTPUT_DIR}"
  export ACLOCAL="aclocal -I ${BUILD_OUTPUT_DIR}/share/aclocal"
  export ACLOCAL_PATH="${BUILD_OUTPUT_DIR}/share/aclocal"
  export PATH="${WORKING_DIR}/build_output/bin:${PATH}"
  export PKG_CONFIG_PATH="${BUILD_OUTPUT_DIR}/lib/pkgconfig:${PKG_CONFIG_PATH}"
  export LDFLAGS="-Wl,--disable-new-dtags -Wl,-rpath=${BUILD_OUTPUT_DIR}/lib -L${BUILD_OUTPUT_DIR}/lib"
}


############################################################################
# Place in order still working on way to build packages out of order
# source all scripts to get access to function/task to execute
############################################################################
do_choose_pkgs() {
  RECIPES+=(zlib elfutils llvm libffi pciaccess xorg-macros x11proto xorgproto xcbproto wayland
            wayland-protocols xdmcp xau xcb xcb-ewmh xtrans x11 xext xrender xrandr vulkan-headers
            vulkan-loader spirv-headers spirv-tools robin-hood-hashing vulkan-validation-layers
            vulkan-tools libdrm xfixes xshmfence xxf86vm mesa libcap systemd glib gobject-introspection
            libpng pixman freetype harfbuzz libxml2 fontconfig cairo fribidi pango gdk-pixbuf
            gmp gdb valgrind)

  for recipe in "${RECIPES[@]}"; do source "${CUR_DIR}/recipes/${recipe}.sh" || return $FAILURE ; done
  chmod 0755 "${CUR_DIR}/recipes"/*
  return $SUCCESS
}


do_print_running_recipe() {
  recipe=$1
  print_me warn "***************************************************************************************************************\n"
  print_me warn "\t\t\t\t\t Running recipe $recipe \n"
  print_me warn "***************************************************************************************************************\n"
}


#################################################################################################
# Provides a command to run all task in a given recipe
# Given parameters
# ARGS:
#   1. recipe: name of script with functions
#   2. runbuiltcheck: Checks add the do_check_is_built_ function so recipe doesn't run twice
# Returns:
#   0 on success
#   1 on failure
#################################################################################################
do_run_all_task() {
  recipe=$1
  runbuiltcheck=$2

  [[ $runbuiltcheck == "true" ]] && {
    do_check_is_built_$recipe && return $SUCCESS
  }

  do_print_running_recipe "$recipe"
  do_fetch_$recipe            || { do_clean_$recipe ; [[ $SOURCED -eq 1 ]] && return $FAILURE || exit $FAILURE; }
  do_patch_$recipe            || { do_clean_$recipe ; [[ $SOURCED -eq 1 ]] && return $FAILURE || exit $FAILURE; }
  do_configure_$recipe        || { do_clean_$recipe ; [[ $SOURCED -eq 1 ]] && return $FAILURE || exit $FAILURE; }
  do_compile_$recipe          || { do_clean_$recipe ; [[ $SOURCED -eq 1 ]] && return $FAILURE || exit $FAILURE; }
  do_install_$recipe          || { do_clean_$recipe ; [[ $SOURCED -eq 1 ]] && return $FAILURE || exit $FAILURE; }
  do_update_artifacts_$recipe || { do_clean_$recipe ; [[ $SOURCED -eq 1 ]] && return $FAILURE || exit $FAILURE; }
  do_clean_$recipe

  return $SUCCESS
}


########################################################################################
# Provides a command to quickly test a task/functions for a given recipe/package
# Given parameters
# ARGS:
#   1. recipe: name of script with functions
#   2. task: the name of the function/task to execute
# Returns:
#   0 on success
#   1 on failure
########################################################################################
underview-create() {
  recipe=$1
  task=$2

  [[ -n "${recipe}" ]] || [[ -n "${task}" ]] || {
    print_me err "[x] wrong arguments\n"
    print_me err "[x] underview-create <recipe> <optional task>\n"
    return $FAILURE
  }

  source "${CUR_DIR}/recipes/${recipe}.sh"
  [[ -n "${task}" ]] && {
    $task || return $FAILURE
  } || {
    do_run_all_task $recipe || return $FAILURE
  }

  return $SUCCESS
}


main() {
  do_configure_build_vars
  do_choose_pkgs
  [[ $SOURCED -eq 1 ]] && {
    return $SUCCESS
  } || {
    for recipe in "${RECIPES[@]}"; do
      do_run_all_task "$recipe" "true"
      wait $!
    done
  }
}


trap do_clean EXIT SIGINT

main
