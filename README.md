# Build Underview Dependencies

Builds all dependencies used directly when developing underview software

## Dependencies

```sh
$ sudo apt update
$ sudo apt install -y aptitude
$ sudo aptitude install -y build-essential cmake clang automake autoconf libtool flex bison m4 yasm libcap-dev
$ sudo aptitude install -y pkg-config python3-pip ninja-build curl wget git gperf
$ sudo python3 -m pip install meson==0.61.4 Mako
```

## Usage

```sh
./build.sh
```

**Development**
```sh
$ . ./build.sh
$ underview-create <recipe> <optional task argument>
```
