(*
For Effective ATS
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

abstype node
abstype nodelst

(* ****** ****** *)
//
extern
fun
node_mark(nx: node): void
and
node_unmark(nx: node): void
//
(* ****** ****** *)
//
extern
fun
process_node(nx: node): void
//
(* ****** ****** *)
//
extern
fun
node_get_neighbors(nx: node): nodelst
//
(* ****** ****** *)
//
extern
fun
theStore_insert(node): void
extern
fun
theStore_insert_lst(nodelst): void
//
extern
fun
theStore_choose((*void*)): Option_vt(node)
//
(* ****** ****** *)
//
extern
fun
GraphSearch_node(nx0: node): void
extern
fun
GraphSearch_nodelst(nxs: nodelst): void
//
(* ****** ****** *)

local

fun
theStore_search
  ((*void*)): void = let
//
val
opt = theStore_choose()
//
in
//
case+ opt of
| ~None_vt() => ()
| ~Some_vt(nx) =>
    theStore_search() where
  {
    val () = process_node(nx)
    val () = theStore_insert_lst(node_get_neighbors(nx))
  } (* end of [Some_vt] *)
//
end (* end of [theStore_search] *)

in (* in-of-local *)

implement
GraphSearch_node
  (nx0) = let
//
val () =
  theStore_insert(nx0)
//
in
  theStore_search((*void*))
end // end of [GraphSearch_node]

implement
GraphSearch_nodelst
  (nxs) = let
//
val () =
  theStore_insert_lst(nxs)
//
in
  theStore_search((*void*))
end // end of [GraphSearch_nodelst]

end // end of [local]

(* ****** ****** *)

(* end of [GraphSearch.dats] *)
