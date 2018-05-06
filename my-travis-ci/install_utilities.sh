#!/usr/bin/env sh

# myatscc
(cd ${PATSHOME}/utils/myatscc && \
 make copy && make build && make clean)
(cp -f ${PATSHOME}/utils/myatscc/BUILD/myatscc ${PATSHOME}/bin)

# libatsopt
(cd ${PATSHOME} && make -C src cleanall)
(cd ${PATSHOME} && make -C src/CBOOT/libc)
(cd ${PATSHOME} && make -C src/CBOOT/libats)
(cd ${PATSHOME} && make -C src/CBOOT/prelude)
(cd ${PATSHOME}/utils/libatsopt && make build && make clean)
(cp -f ${PATSHOME}/utils/libatsopt/BUILD/libatsopt.a ${ATSHOME}/ccomp/lib)

# libatsynmark
(cd ${PATSHOME}/utils/libatsynmark && make build && make clean)
(cp -f ${PATSHOME}/utils/libatsynmark/BUILD/libatsynmark.a ${ATSHOME}/ccomp/lib)

###### end of [install_utilities.sh] ######
