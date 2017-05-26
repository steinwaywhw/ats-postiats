#!/usr/bin/env sh


# libatsopt
make -C src cleanall
make -C src/CBOOT/prelude
make -C src/CBOOT/libc
make -C src/CBOOT/libats

cd ${PATSHOME}/utils/libatsopt && make build && make clean
cp -f ${PATSHOME}/utils/libatsopt/BUILD/libatsopt.a ${ATSHOME}/ccomp/lib

# libatsynmark
cd ${PATSHOME}/utils/libatsynmark && make build && make clean
cp -f ${PATSHOME}/utils/libatsynmark/BUILD/libatsynmark.a ${ATSHOME}/ccomp/lib

# myatscc
cd ${PATSHOME}/utils/myatscc && make && make build && make clean
cp -f ${PATSHOME}/utils/myatscc/BUILD/myatscc ${PATSHOME}/bin
