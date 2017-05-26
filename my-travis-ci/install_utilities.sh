#!/usr/bin/env sh


# libatsopt
make -C src cleanall
make -C src/CBOOT/prelude
make -C src/CBOOT/libc
make -C src/CBOOT/libats

cd utils/libatsopt && make build && make clean
cp -f utils/libatsopt/libatsopt.a ${ATSHOME}/ccomp/lib

# libatsynmark
cd utils/libatsynmark && make build && make clean
cp -f utils/libatsynmark/libatsynmark.a ${ATSHOME}/ccomp/lib

# myatscc
cd utils/myatscc && make && make build && make clean
cp -f utils/myatscc/BUILD/myatscc ${PATSHOME}/bin
