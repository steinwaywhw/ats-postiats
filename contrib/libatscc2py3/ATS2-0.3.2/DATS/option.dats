(*
** For writing ATS code
** that translates into Python
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_"
#define
ATS_STATIC_PREFIX "_ats2pypre_option_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/bool.sats"
#staload "./../SATS/integer.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/option.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/option.dats"
//
(* ****** ****** *)

(* end of [option.dats] *)
