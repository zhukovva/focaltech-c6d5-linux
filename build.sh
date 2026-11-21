#!/bin/sh
set -eu
cd "$(dirname "$0")"
mkdir -p build

usb_flags=$(pkgconf --cflags libfprint-2-tod-1 libfprint-2 gusb)
usb_libs=$(pkgconf --libs libfprint-2-tod-1 libfprint-2 gusb)
fprint_flags=$(pkgconf --cflags libfprint-2)
fprint_libs=$(pkgconf --libs libfprint-2)

# pkgconf lists compiler arguments as separate shell words.
${CC:-gcc} -O2 -fPIC -fvisibility=hidden $usb_flags -c src/focaltech_c6d5.c -o build/driver.o
${CXX:-g++} -O2 -std=c++17 -fPIC -I/usr/include/opencv4 -c src/ftmatch.cpp -o build/ftmatch.o
${CXX:-g++} -shared -Wl,--no-undefined -o build/libfprint-2-tod-focaltech-c6d5.so \
    build/driver.o build/ftmatch.o $usb_libs \
    -lopencv_calib3d -lopencv_features2d -lopencv_imgproc -lopencv_core
${CC:-gcc} -O2 $fprint_flags tools/fptest.c -o build/fptest $fprint_libs
