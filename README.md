This repo builds a dockerimage containing a GCC toolchain targeting ARM/musl.

You can also download the image using:
```bash
docker pull gilnaa/arm-musl-gcc
```

For simplicity this is done using buildroot.

## Usage ##
Start by adding the following alias for ease of use
```bash
alias arm-musl-builder='docker run --rm -it -v "$(pwd)":/home/builder gilnaa/arm-musl-gcc'
```

And then you can run:
```bash
arm-musl-builder arm-buildroot-linux-musleabi-gcc --version
```
