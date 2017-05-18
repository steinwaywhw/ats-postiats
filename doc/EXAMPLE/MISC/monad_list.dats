(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxiATcsDOTbuDOTedu
// Time: the 10th of November, 2015
//
// Please see:
// http://rosettacode.org/wiki/Amb
//
(* ****** ****** *)
//
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -
*)
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
staload "libats/ML/SATS/monad_list.sats"
staload _ = "libats/ML/DATS/monad_list.dats"
//
(* ****** ****** *)
//
datatype
words =
  | Sing of stringGt(0)
  | Comb of (words, words)
//
(* ****** ****** *)
//
extern
fun words_get_beg(words): char
extern
fun words_get_end(words): char
//
(* ****** ****** *)
//
implement
words_get_beg(w0) =
(
case+ w0 of
| Sing(cs) => cs[0]
| Comb(w1, w2) => words_get_beg(w1)
)
//
implement
words_get_end(w0) =
(
case+ w0 of
| Sing(cs) => cs[pred(length(cs))]
| Comb(w1, w2) => words_get_end(w2)
)
//
(* ****** ****** *)
//
fun
words_comb
(
  w1: words, w2: words
) : list0(words) =
  if (words_get_end(w1)=words_get_beg(w2))
    then list0_sing(Comb(w1, w2)) else list0_nil()
//
(* ****** ****** *)
//
extern
fun
fprint_words: fprint_type(words)
//
overload fprint with fprint_words
//
implement
fprint_words(out, ws) =
(
case+ ws of
| Sing(w) => fprint(out, w)
| Comb(w1, w2) => fprint!(out, w1, ' ', w2)
)
//
implement fprint_val<words> = fprint_words
//
(* ****** ****** *)
//
typedef
a = stringGt(0) and b = words
//
val ws1 =
  $list{a}("this", "that", "a")
val ws1 =
  list_map_fun<a><b>(ws1, lam(x) => Sing(x))
val ws1 = monad_list_list(list0_of_list_vt(ws1))
//
val ws2 =
  $list{a}("frog", "elephant", "thing")
val ws2 =
  list_map_fun<a><b>(ws2, lam(x) => Sing(x))
val ws2 = monad_list_list(list0_of_list_vt(ws2))
//
val ws3 =
  $list{a}("walked", "treaded", "grows")
val ws3 =
  list_map_fun<a><b>(ws3, lam(x) => Sing(x))
val ws3 = monad_list_list(list0_of_list_vt(ws3))
//
val ws4 =
  $list{a}("slowly", "quickly")
val ws4 =
  list_map_fun<a><b>(ws4, lam(x) => Sing(x))
val ws4 = monad_list_list(list0_of_list_vt(ws4))
//
(* ****** ****** *)
//
val
ws12 =
monad_bind2<b,b><b>
  (ws1, ws2, lam (w1, w2) => monad_list_list(words_comb(w1, w2)))
val
ws123 =
monad_bind2<b,b><b>
  (ws12, ws3, lam (w12, w3) => monad_list_list(words_comb(w12, w3)))
val
ws1234 =
monad_bind2<b,b><b>
  (ws123, ws4, lam (w123, w4) => monad_list_list(words_comb(w123, w4)))
//
(* ****** ****** *)

implement main0 () =
{
  val () = fprintln! (stdout_ref, "ws1234 = ", ws1234)
}

(* ****** ****** *)

(* end of [monad_list.dats] *)
