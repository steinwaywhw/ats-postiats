(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
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
// Time: December, 2012
//
(* ****** ****** *)
//
// HX: generic nodes: singly-linked, doubly-linked, parental
//
(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no need for staloading at run-time

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)
//
abstype gnode (a:viewt@ype+, l:addr)
//
typedef gnode (a:vt0p) = [l:addr] gnode (a, l)
typedef gnode0 (a:vt0p) = [l:addr | l >= null] gnode (a, l)
typedef gnode1 (a:vt0p) = [l:addr | l >  null] gnode (a, l)
//
(* ****** ****** *)

praxi lemma_gnode
  {a:vt0p}{l:addr} (nx: gnode (a, l)): [l >= null] void
// end of [lemma_gnode]

(* ****** ****** *)

castfn gnode2ptr {a:vt0p}{l:addr} (nx: gnode (a, l)):<> ptr (l)

(* ****** ****** *)

fun{a:vt0p}
gnode_null ():<> gnode (a, null)

fun{a:vt0p}
gnode_make_elt (x: a):<> gnode1 (a)

fun{a:t0p}
gnode_free (nx: gnode1 (a)):<!wrt> void

fun{a:vt0p}
gnode_free_elt
  (nx: gnode1 (a), res: &(a?) >> a):<!wrt> void
// end of [gnode_free_elt]

(* ****** ****** *)

fun{a:vt0p}
gnode_is_null
  {l:addr} (nx: gnode (a, l)):<> bool (l==null)
// end of [gnode_is_null]

fun{a:vt0p}
gnode_isnot_null
  {l:addr} (nx: gnode (a, l)):<> bool (l > null)
// end of [gnode_isnot_null]

(* ****** ****** *)

fun{a:vt0p}
gnode_getref_elt (nx: gnode1 (a)):<> Ptr1

(* ****** ****** *)

fun{a:vt0p}
gnode_getref_prev (nx: gnode1 (a)):<> Ptr1

fun{a:vt0p} // implemented
gnode_get_prev (nx: gnode1 (a)):<> gnode0 (a)
fun{a:vt0p} // implemented
gnode_set_prev (nx: gnode1 (a), nx2: gnode (a)):<!wrt> void
fun{a:vt0p}
gnode_set_prev_null (nx: gnode1 (a)):<!wrt> void

(* ****** ****** *)

fun{a:vt0p}
gnode_getref_next (nx: gnode1 (a)):<> Ptr1

fun{a:vt0p} // implemented
gnode_get_next (nx: gnode1 (a)):<> gnode0 (a)
fun{a:vt0p} // implemented
gnode_set_next (nx: gnode1 (a), nx2: gnode (a)):<!wrt> void
fun{a:vt0p}
gnode_set_next_null (nx: gnode1 (a)):<!wrt> void

(* ****** ****** *)

fun{a:vt0p}
gnode_getref_parent (nx: gnode1 (a)):<> Ptr1

fun{a:vt0p} // implemented
gnode_get_parent (nx: gnode1 (a)):<> gnode0 (a)
fun{a:vt0p} // implemented
gnode_set_parent (nx: gnode1 (a), nx2: gnode (a)):<!wrt> void

fun{a:vt0p} // implemented
gnode_set_parent_null (nx: gnode1 (a)):<!wrt> void

(* ****** ****** *)

fun{a:vt0p}
gnode_get_children (nx: gnode1 (a)):<> gnode0 (a)
fun{a:vt0p}
gnode_set_children (nx: gnode1 (a), nx2: gnode (a)):<!wrt> void

(* ****** ****** *)

fun{a:vt0p}
gnode_link (nx1: gnode1 (a), nx2: gnode1 (a)):<!wrt> void
fun{a:vt0p}
gnode_link00 (nx1: gnode0 (a), nx2: gnode0 (a)):<!wrt> void
fun{a:vt0p}
gnode_link01 (nx1: gnode0 (a), nx2: gnode1 (a)):<!wrt> void
fun{a:vt0p}
gnode_link10 (nx1: gnode1 (a), nx2: gnode0 (a)):<!wrt> void

(* ****** ****** *)

fun{a:vt0p}
gnode_cons {l:agz}
  (nx1: gnode (a, l), nx2: gnode0 (a)):<!wrt> gnode (a, l)
// end of [gnode_cons]

fun{a:vt0p}
gnode_snoc {l:agz}
  (nx1: gnode0 (a), nx2: gnode (a, l)):<!wrt> gnode (a, l)
// end of [gnode_snoc]

(* ****** ****** *)

fun{a:vt0p}
gnode_insert_next
  (nx1: gnode1 (a), nx2: gnode1 (a)):<!wrt> void
// end of [gnode_insert_next]

fun{a:vt0p}
gnode_insert_prev
  (nx1: gnode1 (a), nx2: gnode1 (a)):<!wrt> void
// end of [gnode_insert_prev]

(* ****** ****** *)

fun{a:vt0p}
gnode_remove_next (nx: gnode1 (a)):<!wrt> gnode0 (a)
fun{a:vt0p}
gnode_remove_prev (nx: gnode1 (a)):<!wrt> gnode0 (a)

(* ****** ****** *)

macdef
gnodelst_is_nil (nxs) = gnode_is_null (,(nxs))
macdef
gnodelst_is_cons (nxs) = gnode_isnot_null (,(nxs))

(* ****** ****** *)

fun{a:vt0p}
gnodelst_length (nxs: gnode1 (a)):<!wrt> intGte(0)

fun{a:vt0p}
gnodelst_reverse (nxs: gnode1 (a)):<!wrt> gnode1 (a)

(* ****** ****** *)

fun{
a:vt0p}{env:vt0p
} gnodelst_foreach$fwork (x: &a, env: &env >> _): void
fun{a:vt0p}
gnodelst_foreach (nx: gnode0 (INV(a))): void
fun{
a:vt0p}{env:vt0p
} gnodelst_foreach_env (nx: gnode0 (INV(a)), env: &env >> _): void

(* ****** ****** *)

(* end of [gnode.sats] *)
