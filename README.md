# Build Underview Dependencies

Builds all dependencies used directly when developing underview software

**Tested Distro's**
- Ubuntu 20.04
- Ubuntu 22.04

## Dependencies

```sh
$ sudo apt update
$ sudo apt install -y aptitude
$ sudo aptitude install -y build-essential cmake clang automake autoconf libtool flex bison m4 yasm
$ sudo aptitude install -y pkg-config python3-pip ninja-build curl wget git gperf texinfo libmount-dev
$ sudo python3 -m pip install meson==0.61.4 Mako jinja2
```

## Usage

```sh
./build.sh
```

**Override TASKTHREADS/BUILDTHREADS variables**

* BUILDTHREADS - variable used to specify cpu core count when building with ninja/make/etc...
* TASKTHREADS  - TBA

NOTE: by doing so you are now at the mercy of the Out Of Memory (OOM) killer.

```sh
BUILDTHREADS=$(nproc) ./build.sh
```

**Development**
```sh
$ . ./build.sh
$ underview-create <recipe> <optional task argument>
```

**Set environment variables**
```sh
$ . ./setenvars.sh
```
