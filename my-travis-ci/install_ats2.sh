#!/usr/bin/env sh
#
######
#
cp ${ATSHOME}/config.h .
make -f Makefile_devl CC=${CC} all
#
# make -f codegen/Makefile_atslib
#
# make GCFLAG=-D_ATS_GCATS -f Makefile_devl CC=${GCC} all
# make C3NSTRINTKND=intknd -f Makefile_devl CC=${CLANG} all
# make C3NSTRINTKND=intknd GCFLAG=-D_ATS_GCATS -f Makefile_devl CC=${CLANG} all
#
######
#
# make -C doc/DISTRIB atspackaging
# make -C doc/DISTRIB atspacktarzvcf
# make -C ${PATSHOME}/doc/DISTRIB atscontribing
# make -C ${PATSHOME}/doc/DISTRIB atscntrbtarzvcf
# make -C ${PATSHOME}/doc/DISTRIB cleanall
#
######
#
###### end of [install_ats2.sh] ######

