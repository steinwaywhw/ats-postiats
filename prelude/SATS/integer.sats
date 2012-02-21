(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: September, 2011
//
(* ****** ****** *)

#include "prelude/params.hats"

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [integer.sats] starts!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)
//
// HX: for unindexed integer types
//
(* ****** ****** *)

fun{a:t@ype}
g0int_neg (x: g0int (a)):<> g0int (a)
overload ~ with g0int_neg of 0

(* ****** ****** *)

fun{a:t@ype}
g0int_add
  (x: g0int (a), y: g0int (a)):<> g0int (a)
overload + with g0int_add of 0

fun{a:t@ype}
g0int_sub
  (x: g0int (a), y: g0int (a)):<> g0int (a)
overload - with g0int_sub of 0

fun{a:t@ype}
g0int_mul
  (x: g0int (a), y: g0int (a)):<> g0int (a)
overload * with g0int_mul of 0

fun{a:t@ype}
g0int_div
  (x: g0int (a), y: g0int (a)):<> g0int (a)
overload / with g0int_div of 0

(* ****** ****** *)

fun{a:t@ype}
g0int_lt (x: g0int (a), y: g0int (a)):<> bool
overload < with g0int_lt of 0
fun{a:t@ype}
g0int_lte (x: g0int (a), y: g0int (a)):<> bool
overload <= with g0int_lte of 0

fun{a:t@ype}
g0int_gt (x: g0int (a), y: g0int (a)):<> bool
overload > with g0int_gt of 0
fun{a:t@ype}
g0int_gte (x: g0int (a), y: g0int (a)):<> bool
overload >= with g0int_gte of 0

fun{a:t@ype}
g0int_eq (x: g0int (a), y: g0int (a)):<> bool
overload = with g0int_eq of 0
fun{a:t@ype}
g0int_neq (x: g0int (a), y: g0int (a)):<> bool
overload != with g0int_neq of 0

fun{a:t@ype}
g0int_compare (x: g0int (a), y: g0int (a)):<> int
overload compare with g0int_compare of 0

(* ****** ****** *)

fun{a:t@ype}
g0int_max (x: g0int (a), y: g0int (a)): g0int (a)
overload max with g0int_max of 0

fun{a:t@ype}
g0int_min (x: g0int (a), y: g0int (a)): g0int (a)
overload min with g0int_min of 0

(* ****** ****** *)
//
// HX: for indexed integer types
//
castfn
g1ofg0_int
  {a:t@ype} (x: g0int a):<> g1int (a)
(*
macdef g1ofg0_int (x) = g1ofg0_int ,(x)
*)

(* ****** ****** *)

fun{a:t@ype}
g1int_neg {i:int}
  (x: g1int (a, i)):<> g1int (a, ~i)
overload ~ with g1int_neg of 1

(* ****** ****** *)

fun{a:t@ype}
g1int_add {i,j:int} (
  x: g1int (a, i), y: g1int (a, j)
) :<> g1int (a, i+j)
overload + with g1int_add of 2

fun{a:t@ype}
g1int_sub {i,j:int} (
  x: g1int (a, i), y: g1int (a, j)
) :<> g1int (a, i-j)
overload - with g1int_sub of 2

fun{a:t@ype}
g1int_mul {i,j:int}
  (x: g1int (a, i), y: g1int (a, j)):<> g1int (a, i*j)
overload * with g1int_mul of 2

fun{a:t@ype}
g1int_mul2 {i,j:int} (
  x: g1int (a, i), y: g1int (a, j)
) :<> [ij:int] (MUL (i, j, ij) | g1int (a, ij))

fun{a:t@ype}
g1int_div {i,j:int | j != 0}
  (x: g1int (a, i), y: g1int (a, j)):<> g1int (a)
overload / with g1int_div of 2

fun{a:t@ype}
g1int_ndiv {i,j:int | j > 0}
  (x: g1int (a, i), y: g1int (a, j)):<> g1int (a)
fun{a:t@ype}
g1int_ndiv2 {i,j:int | j > 0} (
  x: g1int (a, i), y: g1int (a, j)
) :<> [q,r:int | 0 <= r; r < j] (DIVMOD (i, j, q, r) | g1int (a, q))

(* ****** ****** *)

fun{a:t@ype}
g1int_lt {i,j:int}
  (x: g1int (a, i), y: g1int (a, j)):<> bool (i < j)
overload < with g1int_lt of 2
fun{a:t@ype}
g1int_lte {i,j:int}
  (x: g1int (a, i), y: g1int (a, j)):<> bool (i <= j)
overload <= with g1int_lte of 2

fun{a:t@ype}
g1int_gt {i,j:int}
  (x: g1int (a, i), y: g1int (a, j)):<> bool (i > j)
overload > with g1int_gt of 2
fun{a:t@ype}
g1int_gte {i,j:int}
  (x: g1int (a, i), y: g1int (a, j)):<> bool (i >= j)
overload >= with g1int_gte of 2

fun{a:t@ype}
g1int_eq {i,j:int}
  (x: g1int (a, i), y: g1int (a, j)):<> bool (i == j)
overload = with g1int_eq of 2
fun{a:t@ype}
g1int_neq {i,j:int}
  (x: g1int (a, i), y: g1int (a, j)):<> bool (i != j)
overload != with g1int_neq of 2

fun{a:t@ype}
g1int_compare
  {i,j:int} (x: g1int (a, i), y: g1int (a, j)):<> int
overload compare with g1int_compare of 2

fun{a:t@ype}
g1int_compare2
  {i,j:int} (
  x: g1int (a, i), y: g1int (a, j)
) :<> [k:int] (SGN (i-j, k) | int (k))

(* ****** ****** *)

fun{a:t@ype}
g1int_max {i,j:int}
  (x: g1int (a, i), y: g1int (a, j)):<> g1int (a, max(i, j))
overload max with g1int_max of 2

fun{a:t@ype}
g1int_min {i,j:int}
  (x: g1int (a, i), y: g1int (a, j)):<> g1int (a, min(i, j))
overload min with g1int_min of 2

(* ****** ****** *)
//
// HX: for unsigned unindexed integer types
//
(* ****** ****** *)

fun{a:t@ype}
g0uint_add
  (x: g0uint (a), y: g0uint (a)):<> g0uint (a)
overload + with g0uint_add of 0

fun{a:t@ype}
g0uint_sub
  (x: g0uint (a), y: g0uint (a)):<> g0uint (a)
overload - with g0uint_sub of 0

fun{a:t@ype}
g0uint_mul
  (x: g0uint (a), y: g0uint (a)):<> g0uint (a)
overload * with g0uint_mul of 0

fun{a:t@ype}
g0uint_div
  (x: g0uint (a), y: g0uint (a)):<> g0uint (a)
overload / with g0uint_div of 0

(* ****** ****** *)

fun{a:t@ype}
g0uint_lt (x: g0uint (a), y: g0uint (a)):<> bool
overload < with g0uint_lt of 0

fun{a:t@ype}
g0uint_lte (x: g0uint (a), y: g0uint (a)):<> bool
overload <= with g0uint_lte of 0

fun{a:t@ype}
g0uint_gt (x: g0uint (a), y: g0uint (a)):<> bool
overload > with g0uint_gt of 0

fun{a:t@ype}
g0uint_gte (x: g0uint (a), y: g0uint (a)):<> bool
overload >= with g0uint_gte of 0

fun{a:t@ype}
g0uint_compare (x: g0uint (a), y: g0uint (a)):<> int
overload compare with g0uint_compare of 0

(* ****** ****** *)

fun{a:t@ype}
g0uint_max (x: g0uint (a), y: g0uint (a)): g0uint (a)
overload max with g0uint_max of 0

fun{a:t@ype}
g0uint_min (x: g0uint (a), y: g0uint (a)): g0uint (a)
overload min with g0uint_min of 0

(* ****** ****** *)
//
// HX: for unsigned indexed integer types
//
praxi
g1uint_param_lemma
  {a:t@ype} {i:int} (x: g1uint (a, i)):<> [i >= 0] void
// end of [g1uint_param_lemma]

castfn
g1ofg0_uint
  {a:t@ype} (x: g0uint a):<> g1uint (a)
(*
macdef g1ofg0_uint (x) = g1ofg0_uint ,(x)
*)

(* ****** ****** *)

fun{a:t@ype}
g1uint_add {i,j:int}
  (x: g1uint (a, i), y: g1uint (a, j)):<> g1uint (a, i+j)
overload + with g1uint_add of 2

fun{a:t@ype}
g1uint_sub {i,j:int}
  (x: g1uint (a, i), y: g1uint (a, j)):<> g1uint (a, i-j)
overload - with g1uint_sub of 2

fun{a:t@ype}
g1uint_mul {i,j:int}
  (x: g1uint (a, i), y: g1uint (a, j)):<> g1uint (a)
overload * with g1uint_mul of 2

fun{a:t@ype}
g1uint_mul2 {i,j:int} (
  x: g1uint (a, i), y: g1uint (a, j)
) :<> [ij:int] (MUL (i, j, ij) | g1uint (a, ij))

fun{a:t@ype}
g1uint_div {i,j:int | j != 0}
  (x: g1uint (a, i), y: g1uint (a, j)):<> g1uint (a)
overload / with g1uint_div of 2

(* ****** ****** *)

fun{a:t@ype}
g1uint_lt {i,j:int}
  (x: g1uint (a, i), y: g1uint (a, j)):<> bool (i < j)
overload < with g1uint_lt of 2

fun{a:t@ype}
g1uint_lte {i,j:int}
  (x: g1uint (a, i), y: g1uint (a, j)):<> bool (i <= j)
overload <= with g1uint_lte of 2

fun{a:t@ype}
g1uint_gt {i,j:int}
  (x: g1uint (a, i), y: g1uint (a, j)):<> bool (i > j)
overload > with g1uint_gt of 2

fun{a:t@ype}
g1uint_gte {i,j:int}
  (x: g1uint (a, i), y: g1uint (a, j)):<> bool (i >= j)
overload >= with g1uint_gte of 2

fun{a:t@ype}
g1uint_compare
  {i,j:int} (x: g1uint (a, i), y: g1uint (a, j)):<> int
overload compare with g1uint_compare of 2

fun{a:t@ype}
g1uint_compare2
  {i,j:int} (
  x: g1uint (a, i), y: g1uint (a, j)
) :<> [k:int] (SGN (i-j, k) | int (k))

(* ****** ****** *)

fun{a:t@ype}
g1uint_max {i,j:int}
  (x: g1uint (a, i), y: g1uint (a, j)):<> g1uint (a, max(i, j))
overload max with g1uint_max of 2

fun{a:t@ype}
g1uint_min {i,j:int}
  (x: g1uint (a, i), y: g1uint (a, j)):<> g1uint (a, min(i, j))
overload min with g1uint_min of 2

(* ****** ****** *)

#if VERBOSE_PRELUDE #then
#print "Loading [integer.sats] finishes!\n"
#endif // end of [VERBOSE_PRELUDE]

(* ****** ****** *)

(* end of [integer.sats] *)
