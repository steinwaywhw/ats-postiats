(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2017 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
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

(* Author: Hongwei Xi *)
(* Start time: December, 2017 *)
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)
  
staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

#staload "libats/ML/SATS/list.sats"

(* ****** ****** *)
//
implement
{a}(*tmp*)
list_tuple_0() = list_nil()
//
implement
{a}(*tmp*)
list_tuple_1(x0) = $list{a}(x0)
implement
{a}(*tmp*)
list_tuple_2(x0, x1) = $list{a}(x0, x1)
implement
{a}(*tmp*)
list_tuple_3(x0, x1, x2) = $list{a}(x0, x1, x2)
//
implement
{a}(*tmp*)
list_tuple_4
(x0, x1, x2, x3) = $list{a}(x0, x1, x2, x3)
implement
{a}(*tmp*)
list_tuple_5
(x0, x1, x2, x3, x4) = $list{a}(x0, x1, x2, x3, x4)
implement
{a}(*tmp*)
list_tuple_6
(x0, x1, x2, x3, x4, x5) = $list{a}(x0, x1, x2, x3, x4, x5)
//
(* ****** ****** *)
//
implement
{x}(*tmp*)
list_exists_cloref
  (xs, pred) = let
//
implement(x2)
list_exists$pred<x2>(x2) = pred($UN.cast{x}(x2))
//
in
  list_exists<x>(xs)
end // end of [list_exists_cloref]
//
(* ****** ****** *)

implement
{x}(*tmp*)
list_iexists_cloref
  {n}(xs, pred) = let
//
prval() = lemma_list_param(xs)
//
fun
loop
{ i,j:nat
| i+j == n
} .<n-i>.
(
  i: int(i), xs: list(x, j)
) :<> bool =
(
  case+ xs of
  | list_nil() => false
  | list_cons(x, xs) =>
      if pred(i, x) then true else loop(i+1, xs)
    // end of [list_cons]
)
//
in
  loop(0, xs)
end // end of [list_iexists_cloref]

(* ****** ****** *)

implement
{x}(*tmp*)
list_forall_cloref
  (xs, pred) = let
//
implement(x2)
list_forall$pred<x2>(x2) = pred($UN.cast{x}(x2))
//
in
  list_forall<x>(xs)
end // end of [list_forall_cloref]

(* ****** ****** *)

implement
{x}(*tmp*)
list_iforall_cloref
  {n}(xs, pred) = let
//
prval() = lemma_list_param(xs)
//
fun
loop
{ i,j:nat
| i+j == n
} .<n-i>.
(
  i: int(i), xs: list(x, j)
) :<> bool =
(
  case+ xs of
  | list_nil() => true
  | list_cons(x, xs) =>
      if pred(i, x) then loop(i+1, xs) else false
    // end of [list_cons]
)
//
in
  loop(0, xs)
end // end of [list_iforall_cloref]

(* ****** ****** *)

implement
{x}(*tmp*)
list_equal_cloref
  (xs1, xs2, eqfn) =
  list_equal<x>(xs1, xs2) where
{
//
implement{y}
list_equal$eqfn
  (x1, x2) = eqfn($UN.cast(x1), $UN.cast(x2))
//
} (* end of [list_equal_cloref] *)

(* ****** ****** *)

implement
{x}(*tmp*)
list_compare_cloref
  (xs1, xs2, cmpfn) =
  list_compare<x>(xs1, xs2) where
{
//
implement{y}
list_compare$cmpfn
  (x1, x2) = cmpfn($UN.cast(x1), $UN.cast(x2))
//
} (* end of [list_compare_cloref] *)

(* ****** ****** *)

implement
{x}(*tmp*)
list_app_fun
  (xs, fwork) =
  list_app<x>(xs) where
{
//
implement
{x2}(*tmp*)
list_app$fwork(x2) = fwork($UN.cast{x}(x2))
//
} (* end of [list_app_fun] *)

implement
{x}(*tmp*)
list_app_clo
  (xs, fwork) =
  list_app<x>(xs) where
{
//
val fwork =
  $UN.cast{cfun(x,void)}(addr@fwork)
//
implement
{x2}(*tmp*)
list_app$fwork(x2) = fwork($UN.cast{x}(x2))
//
} (* end of [list_app_clo] *)

implement
{x}(*tmp*)
list_app_cloref
  (xs, fwork) = let
//
prval() = lemma_list_param(xs)
//
fun
loop
{n:nat} .<n>.
(
  xs: list(x, n)
, fwork: (x) -<cloref1> void
) : void = (
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => (fwork(x); loop(xs, fwork))
//
) (* end of [loop] *)
//
in
  loop(xs, fwork)
end // end of [list_app_cloref]

(* ****** ****** *)

implement
{x}{y}(*tmp*)
list_map_fun
  (xs, fopr) = let
//
implement
{x2}{y2}
list_map$fopr(x2) =
  $UN.castvwtp0{y2}(fopr($UN.cast{x}(x2)))
//
in
  list_map<x><y>(xs)
end // end of [list_map_fun]

implement
{x}{y}(*tmp*)
list_map_clo
  (xs, fopr) = let
//
val fopr =
  $UN.cast{(x) -<cloref1> y}(addr@fopr)
//
implement
{x2}{y2}
list_map$fopr(x2) =
  $UN.castvwtp0{y2}(fopr($UN.cast{x}(x2)))
//
in
  list_map<x><y>(xs)
end // end of [list_map_clo]

implement
{x}{y}(*tmp*)
list_map_cloref
  (xs, fopr) = let
//
implement
{x2}{y2}
list_map$fopr(x2) =
  $UN.castvwtp0{y2}(fopr($UN.cast{x}(x2)))
//
in
  list_map<x><y>(xs)
end // end of [list_map_cloref]

(* ****** ****** *)

implement
{a}(*tmp*)
list_tabulate_fun
  (n, fopr) =
  list_tabulate<a>(n) where
{
//
val fopr = $UN.cast{int->a}(fopr)
//
implement(a2)
list_tabulate$fopr<a2>(n) = $UN.castvwtp0{a2}(fopr(n))
//
} (* end of [list_tabulate_fun] *)

implement
{a}(*tmp*)
list_tabulate_clo
  (n, fopr) =
  list_tabulate<a>(n) where
{
//
val fopr = $UN.cast{cfun(int,a)}(addr@fopr)
//
implement(a)
list_tabulate$fopr<a>(n) = $UN.castvwtp0{a}(fopr(n))
//
} (* end of [list_tabulate_clo] *)

implement
{a}(*tmp*)
list_tabulate_cloref
  (n, fopr) = let
//
val fopr =
$UN.cast{int -<cloref1> a}(fopr)
//
implement(a)
list_tabulate$fopr<a>(n) = $UN.castvwtp0{a}(fopr(n))
//
in
  list_tabulate<a>(n)
end // end of [list_tabulate_cloref]

(* ****** ****** *)

implement
{x}(*tmp*)
list_foreach_fun
  (xs, fwork) = let
//
fun
loop(xs: List(x)): void =
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => (fwork(x); loop(xs))
//
in
  $effmask_all (loop(xs))
end // end of [list_foreach_fun]

(* ****** ****** *)
//
implement
{x}(*tmp*)
list_foreach_clo
  (xs, fwork) =
(
$effmask_all
  (list_foreach_cloref<x>(xs, $UN.cast(addr@fwork)))
) (* list_foreach_clo *)
implement
{x}(*tmp*)
list_foreach_vclo
  (pf | xs, fwork) =
(
$effmask_all
  (list_foreach_cloref<x>(xs, $UN.cast(addr@fwork)))
) (* list_foreach_vclo *)
//
(* ****** ****** *)

implement
{x}(*tmp*)
list_foreach_cloptr
  (xs, fwork) =
  cloptr_free
  ($UN.castvwtp0{cloptr(void)}(fwork)) where
{
val () =
$effmask_all
  (list_foreach_cloref<x>(xs, $UN.castvwtp1(fwork)))
} (* list_foreach_cloptr *)
implement
{x}(*tmp*)
list_foreach_vcloptr
  (pf | xs, fwork) =
  cloptr_free
  ($UN.castvwtp0{cloptr(void)}(fwork)) where
{
val () =
$effmask_all
  (list_foreach_cloref<x>(xs, $UN.castvwtp1(fwork)))
} (* list_foreach_vcloptr *)

(* ****** ****** *)

implement
{x}(*tmp*)
list_foreach_cloref
  (xs, fwork) = let
//
fun
loop(xs: List(x)): void =
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => (fwork(x); loop(xs))
//
in
  $effmask_all (loop(xs))
end // end of [list_foreach_cloref]

(* ****** ****** *)
//
implement
{a}(*tmp*)
list_foreach_method(xs) =
  lam(fwork) => list_foreach_cloref<a>(xs, fwork)
//
(* ****** ****** *)

implement
{x}(*tmp*)
list_iforeach_cloref
  {n}(xs, fwork) = let
//
prval() = lemma_list_param(xs)
//
fun
loop
{
  i,j:nat
| i+j == n
} .<n-i>.
(
  i: int(i), xs: list(x, j)
) : void =
//
case+ xs of
| list_nil() => ()
| list_cons(x, xs) => (fwork (i, x); loop(i+1, xs))
//
in
  loop(0, xs)
end // end of [list_iforeach_cloref]

(* ****** ****** *)
//
implement
{a}(*tmp*)
list_iforeach_method(xs) =
  lam(fwork) => list_iforeach_cloref<a>(xs, fwork)
//
(* ****** ****** *)

implement
{res}{x}
list_foldleft_cloref
  (xs, ini, fopr) = let
//
implement
{res2}{x2}
list_foldleft$fopr
  (res2, x2) =
(
$UN.castvwtp0{res2}
  (fopr($UN.castvwtp0{res}(res2), $UN.cast{x}(x2)))
)
//
in
  list_foldleft<res><x>(xs, ini)
end // end of [list_foldleft_cloref]

(* ****** ****** *)

implement
{x}{res}
list_foldright_cloref
  (xs, fopr, snk) = let
//
implement
{x2}{res2}
list_foldright$fopr
  (x2, res2) =
(
$UN.castvwtp0{res2}
  (fopr($UN.cast{x}(x2), $UN.castvwtp0{res}(res2)))
)
//
in
  list_foldright<x><res>(xs, snk)
end // end of [list_foldright_cloref]

(* ****** ****** *)

(* end of [list.dats] *)
