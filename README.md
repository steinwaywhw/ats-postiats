# [ATS2](http://www.ats-lang.org/) - ATS/Postiats

A Programming Language System to Unleash the Potentials of Types and Templates

## Project Description

ATS/Postiats (or ATS2/Postiats) is the name for the current compiler of
ATS2, the successor of ATS (or ATS1).

The actual implementation of ATS/Postiats started in March, 2011, and
it took about two and one-half years to reach the first release of ATS2 at
the beginning of September, 2013. As of now, the code base for the compiler
of ATS2 consists of 170,000+ lines of code (LOC), which are nearly all
written in ATS1.

When compared to ATS1, the single most important new feature is the
template system of ATS2. This is a feature that could potentially change
the way a programmer writes his or her code. One can certainly feel that
this is a very powerful feature (a bit like feeling that OOP is a very
powerful feature). However, how this feature should be properly and
effectively used in practice needs a lot more investigation.

Another thing about ATS2 is that it is a lot leaner than ATS. One can make
good use of ATS2 without any need for compiled library (libatslib.a). Also,
GC support in ATS1 is now removed; if needed, third-party GC (e.g.,
Bohem-GC) can be readily employed.

## Build Status

* [![Build Status](https://travis-ci.org/githwxi/ATS-Postiats.svg?branch=master)](https://travis-ci.org/githwxi/ATS-Postiats) Ubuntu
* [![Build Status](https://ci.appveyor.com/api/projects/status/github/githwxi/ats-postiats?branch=master&svg=true)](https://ci.appveyor.com/project/githwxi/ats-postiats/branch/master) Cygwin
* [![Build Status](https://travis-ci.org/ats-lang/ATS-Postiats-release.svg?branch=master)](https://travis-ci.org/ats-lang/ATS-Postiats-release) Release (Ubuntu/Mac * gcc/clang)

## Installing ATS2

Please see
[http://www.ats-lang.org/Downloads.html](http://www.ats-lang.org/Downloads.html) for
instructions.

Note that the code in this github directory is primarily meant for people
who would like to help develop ATS2. For someone who just wants to program
in ATS2, please install the current release of ATS2, which can be found at
the following site:
[https://sourceforge.net/projects/ats2-lang/](https://sourceforge.net/projects/ats2-lang/).
There are also pre-compiled debian packages for ATS2 available on-line.

## Developing ATS2

The compiler of ATS2 is nearly all implemented in ATS1, which is available
at [http://sourceforge.net/projects/ats-lang/](http://sourceforge.net/projects/ats-lang/).

## Documenting ATS2

ATS-users are encouraged to share what they have learned on the
[ATS2 wiki](https://github.com/githwxi/ATS-Postiats/wiki), which currently
contains over 45 articles with content.  A list of article stubs is
maintained at [TODO](https://github.com/githwxi/ATS-Postiats/wiki/TODO).

## Licenses for ATS2

* The Compiler (ATS/Postiats):
  [GPLv3](https://github.com/githwxi/ATS-Postiats/blob/master/COPYING-gpl-3.0.txt)
* The source for Libraries (ATSLIB/{prelude,libc,libats}):
  [GPLv3](https://github.com/githwxi/ATS-Postiats/blob/master/COPYING-gpl-3.0.txt).
* The object code for Libraries (ATSLIB/{prelude,libc,libats}):
  [LGPLv2.1](https://github.com/githwxi/ATS-Postiats/blob/master/COPYING-lgpl-2.1.txt).
* As a special exception, if you link the object code for Libraries with other files
  to create an executable, then the linking does not by itself cause the executable to
  be covered by LGPLv2.1. However, this exception does not invalidate any other reasons
  that might result in the executable being covered by LGPLv2.1.
* There is a separate release under the BSD license for the C header files of the
  Libraries, which one can freely insert into the C code generated from ATS source code.
