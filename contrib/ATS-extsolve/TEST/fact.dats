(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
stacst fact: int -> int
//
(* ****** ****** *)
//
extern
praxi
fact_bas(): [fact(0)==1] void
extern
praxi
fact_ind{n:pos}(): [fact(n)==n*fact(n-1)] void
//
(* ****** ****** *)

fun
fact
{n:nat}
(
  n: int(n)
) : int(fact(n)) = let
//
fun
loop
{n:nat}
{r:int} .<n>.
(
  n: int(n), r: int(r)
) : int(fact(n)*r) = (
//
if
n = 0
then let
  prval () = fact_bas() in (r)
end // end of [then]
else let
  prval () = fact_ind{n}() in loop(n-1, n*r)
end // end of [else]
//
) (* end of [loop] *)
//
in
  loop(n, 1)
end // end of [fact]

(* ****** ****** *)

implement
main0(argc, argv) =
{
//
val n =
(
if (argc >= 2)
  then g0string2int(argv[1]) else 10
// end of [if]
) : int // end of [val]
//
val n = g1ofg0(n)
val n = (if n >= 0 then n else 0): intGte(0)
//
val () = println! ("fact(", n, ") = ", fact(n))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [fact.dats] *)
