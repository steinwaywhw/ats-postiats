#!/usr/bin/env sh

(cd ${PATSHOME}/contrib/CATS-parsemit && make all)
(cd ${PATSHOME}/contrib/CATS-atscc2js && make all && cp -f bin/atscc2js ${PATSHOME}/bin  && ./bin/atscc2js)
(cd ${PATSHOME}/contrib/CATS-atscc2php && make all && cp -f bin/atscc2php ${PATSHOME}/bin && ./bin/atscc2php)
(cd ${PATSHOME}/contrib/CATS-atscc2py3 && make all && cp -f bin/atscc2py3 ${PATSHOME}/bin && ./bin/atscc2py3)
(cd ${PATSHOME}/contrib/CATS-atscc2cli && make all && cp -f bin/atscc2cli ${PATSHOME}/bin && ./bin/atscc2cli)
(cd ${PATSHOME}/contrib/CATS-atscc2scm && make all && cp -f bin/atscc2scm ${PATSHOME}/bin && ./bin/atscc2scm)

(cd ${PATSHOME}/contrib/ATS-extsolve && make all && cp -f bin/patsolve ${PATSHOME}/bin && ./bin/patsolve)
(cd ${PATSHOME}/contrib/ATS-extsolve-z3 && make all && cp -f bin/patsolve_z3 ${PATSHOME}/bin && ./bin/patsolve_z3)
(cd ${PATSHOME}/contrib/ATS-extsolve-smt2 && make all && cp -f bin/patsolve_smt2 ${PATSHOME}/bin && ./bin/patsolve_smt2)



