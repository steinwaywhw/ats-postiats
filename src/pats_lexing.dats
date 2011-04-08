(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)
//
// HX: The implementation of lexing is plainly ad hoc
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload UTL = "pats_utils.sats"
staload LOC = "pats_location.sats"

(* ****** ****** *)

staload "pats_lexbuf.sats"
staload "pats_lexing.sats"

(* ****** ****** *)
//
#define u2c char_of_uchar
//
#define i2c char_of_int
#define c2i int_of_char
//
#define i2uc uchar_of_int
#define uc2i int_of_uchar
//
#define i2u uint_of_int
#define u2i int_of_uint
//
#define l2u uint_of_lint
#define sz2i int1_of_size1
//
(* ****** ****** *)

macdef T_INTEGER_oct (x, sfx) = T_INTEGER (8, ,(x), ,(sfx))
macdef T_INTEGER_dec (x, sfx) = T_INTEGER (10, ,(x), ,(sfx))
macdef T_INTEGER_hex (x, sfx) = T_INTEGER (16, ,(x), ,(sfx))

(* ****** ****** *)
//
// HX: some shorthand function names
//
macdef posincby1
  (pos) = $LOC.position_incby_count (,(pos), 1u)
// end of [posincby1]

macdef posdecby1
  (pos) = $LOC.position_decby_count (,(pos), 1u)
// end of [posdecby1]

macdef posincbyc
  (pos, i) = $LOC.position_incby_char (,(pos), ,(i))
// end of [posincbyc]

(* ****** ****** *)

fun
char_for_escaped
  (c: char): char = begin
  case+ c of
  | 'n' => '\012' (* newline *)
  | 't' => '\011' (* horizontal tab *)
  | 'v' => '\013' (* vertical tab *)
  | 'b' => '\010' (* backspace *)
  | 'r' => '\015' (* carriage return *)
  | 'f' => '\014' (* line feed *)
  | 'a' => '\007' (* alert *)
  |  _  => c
end // end of [char_for_escaped]

fun xdigit_get_val
  (c: char): int =
  case+ 0 of
  | _ when c <= '9' => c - '0'
  | _ when c <= 'F' => 10 + (c - 'A')
  | _ => 10 + (c - 'a')
// end of [xdigit_get_val]    

(* ****** ****** *)

//
// HX: there are various "irregular" tokens in ATS
// (e.g., type+, type-, t@ype, fold@, free@, while*),
// which complicate lexing considerably; [lexsym] is
// primarily introduced for handling such tokens.
//

datatype
lexsym =
//
  | LS_NONE of () // this is a dymmy
//
  | LS_ABST // for abst@ype
  | LS_ABSVIEWT // for absviewt@ype
  | LS_CASE // for case+ and case-
  | LS_FIX // for fix@
  | LS_FN // for fn*
  | LS_FOR // for for*
  | LS_LAM // for lam@
  | LS_LLAM // for llam@
  | LS_PROP // for prop+ and prop-
  | LS_T // for t@ype
  | LS_TYPE // for type+ and type-
  | LS_T0YPE // for t0ype+ and t0ype-
  | LS_VAL // for val+ and val-
  | LS_VIEW // for view+ and view-
  | LS_VIEWT // for viewt@ype
  | LS_VIEWTYPE // for viewtype+ and viewtype-
  | LS_VIEWT0YPE // for viewt0ype+ and viewt0ype-
  | LS_WHILE // for while*
//
  | LS_FOLD // for fold@
  | LS_FREE // for free@
//
(*
  | LS_LTBANG of () // "<!" // not a symbol
  | LS_LTDOLLAR of () // "<$" // not a symbol
*)
  | LS_QMARKGT of () // "?>" // not a symbol
//
  | LS_SLASH2 of () // "//" line comment
  | LS_SLASHSTAR of () // "/*" block comment
  | LS_SLASH4 of () // "////" // rest-of-file comment
// end of [lexsym]

(* ****** ****** *)

local
//
// HX: hashtable based on linear probing seems
// unwieldy to use
//
%{^
typedef ats_ptr_type string ;
typedef ats_ptr_type lexsym ;
%} // end of [%{^]
staload
"libats/SATS/hashtable_linprb.sats"
staload _(*anon*) =
"libats/DATS/hashtable_linprb.dats"
//
#define HASHTBLSZ 53
//
symintr encode decode
//
abstype string_t = $extype"string"
extern castfn string_encode (x: string):<> string_t
extern castfn string_decode (x: string_t):<> string
overload encode with string_encode
overload decode with string_decode
//
abstype lexsym_t = $extype"lexsym"
extern castfn lexsym_encode (x: lexsym):<> lexsym_t
extern castfn lexsym_decode (x: lexsym_t):<> lexsym
overload encode with lexsym_encode
overload decode with lexsym_decode
//
typedef key = string_t
typedef itm = lexsym_t
typedef keyitm = (key, itm)
//
implement
keyitem_nullify<keyitm>
  (x) = () where {
  extern prfun __assert (x: &keyitm? >> keyitm): void
  prval () = __assert (x)
  val () = x.0 := $UN.cast{key} (null)
  prval () = Opt_some (x)
} (* end of [keyitem_nullify] *)
//
implement
keyitem_isnot_null<keyitm>
  (x) = b where {
  extern prfun __assert1 (x: &Opt(keyitm) >> keyitm): void
  prval () = __assert1 (x)
  val b = $UN.cast{ptr} (x.0) <> null
  val [b:bool] b = bool1_of_bool (b)
  extern prfun __assert2 (x: &keyitm >> opt (keyitm, b)): void
  prval () = __assert2 (x)
} (* end of [keyitem_isnot_null] *)
//
implement
hash_key<key> (x, _) = string_hash_33 (decode(x))
implement
equal_key_key<key>
  (x1, x2, _) = compare (decode(x1), decode(x2)) = 0
// end of [equal_key_key]
//
val hash0 = $UN.cast{hash(key)} (null)
val eqfn0 = $UN.cast{eqfn(key)} (null)
val [l:addr] ptbl = hashtbl_make_hint<key,itm> (hash0, eqfn0, HASHTBLSZ)
//
fun insert (
  ptbl: !HASHTBLptr (key, itm, l)
, k: string, i: lexsym
) : void = () where {
  val k = encode (k); var i = encode (i)
  val _ = hashtbl_insert<key,itm> (ptbl, k, i)
  prval () = opt_clear (i)
} // end of [insert]
//
val () = insert (ptbl, "abst", LS_ABST)
val () = insert (ptbl, "absviewt", LS_ABSVIEWT)
val () = insert (ptbl, "case", LS_CASE)
val () = insert (ptbl, "fix", LS_FIX)
val () = insert (ptbl, "fn", LS_FN)
val () = insert (ptbl, "for", LS_FOR)
val () = insert (ptbl, "fold", LS_FOLD)
val () = insert (ptbl, "free", LS_FREE)
val () = insert (ptbl, "lam", LS_LAM)
val () = insert (ptbl, "llam", LS_LLAM)
val () = insert (ptbl, "prop", LS_PROP)
val () = insert (ptbl, "t", LS_T)
val () = insert (ptbl, "type", LS_TYPE)
val () = insert (ptbl, "t0ype", LS_T0YPE) // = t@ype
val () = insert (ptbl, "val", LS_VAL)
val () = insert (ptbl, "view", LS_VIEW)
val () = insert (ptbl, "viewt", LS_VIEWT)
val () = insert (ptbl, "viewtype", LS_VIEWTYPE)
val () = insert (ptbl, "viewt0ype", LS_VIEWT0YPE) // = viewt@ype
val () = insert (ptbl, "while", LS_WHILE)
//
val () = insert (ptbl, "fold", LS_FOLD)
val () = insert (ptbl, "free", LS_FREE)
//
val rtbl = HASHTBLref_make_ptr {key,itm} (ptbl)

in // in of [local]

fun IDENT_alp_get_lexsym
  (x: string): lexsym = let
  val (fptbl | ptbl) = HASHTBLref_takeout_ptr (rtbl)
  var res: itm?
  val b = hashtbl_search<key,itm> (ptbl, encode(x), res)
  prval () = fptbl (ptbl)
in
  if b then let
    prval () = opt_unsome {itm} (res) in decode (res)
  end else let
    prval () = opt_unnone {itm} (res) in LS_NONE
  end // end of [if]
end // end of [IDENT_alp_get_lexsym]

end // end of [local]

(* ****** ****** *)

fun IDENT_sym_get_lexsym
  (x: string): lexsym = let
//
  fun slash2_test
    {n:int} {i:nat | i <= n} 
    (x: string n, i: int i): bool = let
//
    staload STRING = "libc/SATS/string.sats" // for [string.cats]
    extern fun substrncmp
      (x1: string, i1: int, x2: string, i2: int): int = "mac#atslib_substrcmp"
    // end of [substrncmp]
  in
    substrncmp (x, i, "//", 0) = 0
  end // end of [slash2_test]
//
  val x = string1_of_string (x)
//
in
  if string_isnot_at_end (x, 0) then let
    val x0 = x[0]
  in
    case+ x0 of
(*
    | '<' =>
        if string_isnot_at_end (x, 1) then let
          val x1 = x[1]
        in
          case+ x1 of
          | '!' => LS_LTBANG ()
          | '$' => LS_LTDOLLAR ()
          | _ => LS_NONE ()
        end else LS_NONE ()
*)
    | '?' =>
        if string_isnot_at_end (x, 1) then let
          val x1 = x[1]
        in
          case+ x1 of
          | '>' => LS_QMARKGT ()
          | _ => LS_NONE ()
        end else LS_NONE ()
    | '/' =>
        if string_isnot_at_end (x, 1) then let
          val x1 = x[1]
        in
          case+ x1 of
          | '*' => LS_SLASHSTAR ()
          | '/' => if slash2_test (x, 2) then LS_SLASH4 () else LS_SLASH2 ()
          | _ => LS_NONE ()
        end else LS_NONE ()
    | _ => LS_NONE ()
  end else LS_NONE () // end of [if]
end // end of [IDENT_sym_get_lexsym]

(* ****** ****** *)

fun BLANK_test
  (c: char): bool = char_isspace (c)
// end of [BLANK_test]

(* ****** ****** *)

fun IDENTFST_test
  (c: char): bool = case+ 0 of
  | _ when ('a' <= c andalso c <= 'z') => true
  | _ when ('A' <= c andalso c <= 'Z') => true
  | _ when c = '_' => true
  | _ => false
// end of [IDENTFST_test]

fun IDENTRST_test
  (c: char): bool = case+ 0 of
  | _ when ('a' <= c andalso c <= 'z') => true
  | _ when ('A' <= c andalso c <= 'Z') => true
  | _ when ('0' <= c andalso c <= '9') => true
  | _ when c = '_' => true
  | _ when c = '\'' => true
  | _ => false
// end of [IDENTRST_test]

(* ****** ****** *)

fun SYMBOLIC_test
  (c: char): bool = let
  val symbolic = "%&+-./:=@~`^|*!$#?<>"
in
  string_contains (symbolic, c)
end // end of [SYMBOLIC_test]

(* ****** ****** *)

fun xX_test
  (c: char): bool =
  if c = 'x' then true else c = 'X'
// end of [xX_test]

fun DIGIT_test
  (c: char): bool = char_isdigit (c)
fun XDIGIT_test
  (c: char): bool = char_isxdigit (c)

(* ****** ****** *)

fun INTSP_test
  (c: char): bool = string_contains ("LlUu", c)
fun FLOATSP_test
  (c: char): bool = string_contains ("dDfFlL", c)

(* ****** ****** *)

fun eE_test
  (c: char): bool =
  if c = 'e' then true else c = 'E'
// end of [eE_test]

fun pP_test
  (c: char): bool =
  if c = 'p' then true else c = 'P'
// end of [pP_test]

fun SIGN_test
  (c: char): bool =
  if c = '+' then true else c = '-'
// end of [SIGN_test]

(* ****** ****** *)

fun ESCHAR_test
  (c: char): bool = let
  val escaped = "ntvbrfa\\\?\'\"\(\[\{"
in
  string_contains (escaped, c)
end // end of [ESCHAR_test]

(* ****** ****** *)
//
// HX: f('\n') must be false!
//
extern
fun ftesting_opt (
  buf: &lexbuf, pos: &position, f: char -> bool
) : uint // end of [ftesting_opt]
implement
ftesting_opt
  (buf, pos, f) = let
  val i = lexbufpos_get_char (buf, pos)
in
  if i >= 0 then (
    if f ((i2c)i) then let
      val () = posincby1 (pos) in 1u
    end else 0u // end of [if]
  ) else 0u // end of [if]
end // end of [ftesting_opt]

(* ****** ****** *)
//
// HX: f('\n') must be false!
//
extern
fun ftesting_seq0 (
  buf: &lexbuf, pos: &position, f: char -> bool
) : uint // end of [ftesting_seq0]
implement
ftesting_seq0
  (buf, pos, f) = diff where {
  fun loop (
    buf: &lexbuf, nchr: uint, f: char -> bool
  ) : uint = let
    val i = lexbuf_get_char (buf, nchr)
  in
    if i >= 0 then
      if f ((i2c)i)
        then loop (buf, succ(nchr), f) else nchr
      // end of [if]
    else nchr // end of [if]
  end // end of [loop]
  val nchr0 = lexbufpos_diff (buf, pos)
  val nchr1 = loop (buf, nchr0, f)
  val diff = nchr1 - nchr0
  val () = if diff > 0u 
    then $LOC.position_incby_count (pos, diff) else ()
  // end of [val]
} // end of [ftesting_seq0]

(* ****** ****** *)
//
// HX: f('\n') must be false!
//
extern
fun ftesting_seq1 (
  buf: &lexbuf, pos: &position, f: char -> bool
) : int // end of [ftesting_seq1]
implement
ftesting_seq1
  (buf, pos, f) = let
  val i = lexbufpos_get_char (buf, pos)
in
  if i >= 0 then (
    if f ((i2c)i) then let
      val () = posincby1 (pos)
      val nchr = ftesting_seq0 (buf, pos, f)
    in
      (u2i)nchr + 1
    end else ~1 // end of [if]
  ) else ~1 // end of [if]
end // end of [ftesting_seq1]

(* ****** ****** *)
//
// HX-2011-03-07:
// this one cannot be based on [ftesting_seq0]
// as '\n' is considered a blank character
//
fun
testing_blankseq0 (
  buf: &lexbuf, pos: &position
) : uint = diff where {
  fun loop (
    buf: &lexbuf, pos: &position, nchr: uint
  ) : uint = let
    val i = lexbuf_get_char (buf, nchr)
  in
    if i >= 0 then (
      if BLANK_test ((i2c)i) then let
        val () = posincbyc (pos, i) in loop (buf, pos, succ(nchr))
      end else nchr // end of [if]
    ) else nchr // end of [if]
  end // end of [loop]
  val nchr0 = lexbufpos_diff (buf, pos)
  val nchr1 = loop (buf, pos, nchr0)
  val diff = nchr1 - nchr0
} // end of testing_blankseq0]

(* ****** ****** *)

extern
fun testing_char (
  buf: &lexbuf, pos: &position, lit: char
) : int // end of [testing_char]
implement testing_char
  (buf, pos, lit) = res where {
  val i = lexbufpos_get_char (buf, pos)
  val res = (
    if i >= 0 then
      if (i2c)i = lit then 1 else ~1
    else ~1
  ) : int // end of [val]
  val () = if res >= 0 then posincbyc (pos, i)
} // end of [testing_char]

(* ****** ****** *)
//
// HX: [lit] contains no '\n'!
//
extern
fun testing_literal (
  buf: &lexbuf, pos: &position, lit: string
) : int // end of [testing_literal]
implement testing_literal
  (buf, pos, lit) = res where {
  val [n:int] lit = string1_of_string (lit)
  fun loop
    {k:nat | k <= n} (
    buf: &lexbuf, nchr: uint, lit: string n, k: size_t k
  ) : int =
    if string_isnot_at_end (lit, k) then let
      val i = lexbuf_get_char (buf, nchr)
    in
      if i >= 0 then
        if ((i2c)i = lit[k])
          then loop (buf, succ(nchr), lit, k+1) else ~1
        // end of [if]
      else ~1 // end of [if]
    end else (sz2i)k // end of [if]
  val nchr0 = lexbufpos_diff (buf, pos)
  val res = loop (buf, nchr0, lit, 0)
  val () = if res >= 0
    then $LOC.position_incby_count (pos, (i2u)res) else ()
  // end of [val]
} // end of [testing_literal]

(* ****** ****** *)

fun testing_identrstseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, IDENTRST_test)
// end of [testing_identrstseq0]

fun testing_symbolicseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, SYMBOLIC_test)
// end of [testing_symbolicseq0]

(* ****** ****** *)

fun testing_digitseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, DIGIT_test)
// end of [testing_digitseq0]

fun testing_xdigitseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, XDIGIT_test)
// end of [testing_xdigitseq0]

(* ****** ****** *)

fun testing_intspseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, INTSP_test)
// end of [testing_intspseq0]

(* ****** ****** *)

fun testing_floatspseq0
  (buf: &lexbuf, pos: &position): uint
  = ftesting_seq0 (buf, pos, FLOATSP_test)
// end of [testing_floatspseq0]

(* ****** ****** *)

fun testing_fexponent (
  buf: &lexbuf, pos: &position
) : int = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i
in
  if eE_test (c) then let
    val () = posincby1 (pos)
    val k1 = ftesting_opt (buf, pos, SIGN_test)
    val k2 = testing_digitseq0 (buf, pos) // err: k2 = 0
//
    val () = if k2 = 0u then {
      val loc = lexbufpos_get_location (buf, pos)
      val err = lexerr_make (loc, LE_FEXPONENT_empty)
      val () = the_lexerrlst_add (err)
    } // end of [if] // end of [val]
//
  in
    u2i (k1+k2+1u)
  end else ~1 // end [if]
end else ~1 // end of [if]
//
end // end of [testing_fexponent]

fun testing_deciexp (
  buf: &lexbuf, pos: &position
) : int = let  
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i in
  if c = '.' then let
    val () = posincby1 (pos)
    val k1 = testing_digitseq0 (buf, pos)
    val k2 = testing_fexponent (buf, pos)
    val k12 = (
      if k2 >= 0 then (u2i)k1 + k2 else (u2i)k1
    ) : int // end of [val]
//
(*
    val () = if (k12 = 0) then {
      val loc = lexbufpos_get_location (buf, pos)
      val err = lexerr_make (loc, LE_FEXPONENT_empty)
      val () = the_lexerrlst_add (err)
    } // end of [if] // end of [val]
*)
//
  in
    k12 + 1
  end else ~1 // end of [if]
end else ~1 // end of [if]
//
end // end of [testing_deciexp]

(* ****** ****** *)

fun testing_fexponent_bin (
  buf: &lexbuf, pos: &position
) : int = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i
in
  if pP_test (c) then let
    val () = posincby1 (pos)
    val k1 = ftesting_opt (buf, pos, SIGN_test)
    val k2 = testing_digitseq0 (buf, pos) // err: k2 = 0
//
    val () = if k2 = 0u then {
      val loc = lexbufpos_get_location (buf, pos)
      val err = lexerr_make (loc, LE_FEXPONENT_empty)
      val () = the_lexerrlst_add (err)
    } // end of [if] // end of [val]
//
  in
    u2i (k1+k2+1u)
  end else ~1 // end [if]
end else ~1 // end of [if]
//
end // end of [testing_fexponent]

fun testing_hexiexp (
  buf: &lexbuf, pos: &position
) : int = let  
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i in
  if c = '.' then let
    val () = posincby1 (pos)
    val k1 = testing_xdigitseq0 (buf, pos)
    val k2 = testing_fexponent_bin (buf, pos)
  in
    if k2 >= 0 then (u2i)k1 + k2 + 1 else (u2i)k1 + 1
  end else ~1 // end of [if]
end else ~1 // end of [if]
//
end // end of [testing_hexiexp]

(* ****** ****** *)

implement
token_make
  (loc, node) = '{
  token_loc= loc, token_node= node
} // end of [token_make]

(* ****** ****** *)

fun
lexbufpos_token_reset (
  buf: &lexbuf
, pos: &position
, node: token_node
) : token = let
  val loc =
    lexbufpos_get_location (buf, pos)
  val () = lexbuf_reset_position (buf, pos)
in
  token_make (loc, node)
end // end of [lexbufpos_token_reset]

fun
lexbufpos_lexerr_reset (
  buf: &lexbuf
, pos: &position
, node: lexerr_node
) : token = let
  val loc = lexbufpos_get_location (buf, pos)
  val () = the_lexerrlst_add (lexerr_make (loc, node))
  val () = lexbuf_reset_position (buf, pos)
in
  token_make (loc, T_ERR)
end // end of [lexbufpos_token_reset]

(* ****** ****** *)

extern
fun lexing_FLOAT_deciexp
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_FLOAT_hexiexp
  (buf: &lexbuf, pos: &position): token

extern
fun lexing_INTEGER_dec
  (buf: &lexbuf, pos: &position, k1: uint): token
extern
fun lexing_INTEGER_oct
  (buf: &lexbuf, pos: &position, k1: uint): token
extern
fun lexing_INTEGER_hex
  (buf: &lexbuf, pos: &position, k1: uint): token

extern
fun lexing_IDENT_alp
  (buf: &lexbuf, pos: &position, k1: uint): token
extern
fun lexing_IDENT1_alp {l:agz}
  (buf: &lexbuf, pos: &position, str: strptr l): token

extern
fun lexing_IDENT_sym
  (buf: &lexbuf, pos: &position, k1: uint): token

extern
fun lexing_IDENT_dlr
  (buf: &lexbuf, pos: &position, k1: uint): token
extern
fun lexing_IDENT_srp
  (buf: &lexbuf, pos: &position, k1: uint): token

(* ****** ****** *)

extern
fun lexing_COMMENT_line
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_COMMENT_block_c
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_COMMENT_block_ml {l:pos}
  (buf: &lexbuf, pos: &position, xs: list_vt (position, l)): token
extern
fun lexing_COMMENT_rest
  (buf: &lexbuf, pos: &position): token

(* ****** ****** *)

extern
fun lexing_EXTCODE
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_EXTCODE_knd
  (buf: &lexbuf, pos: &position, knd: int): token

(* ****** ****** *)

implement
lexing_COMMENT_line
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)  
in
//
if i >= 0 then (
  case+ (i2c)i of
  | '\n' => (
      lexbufpos_token_reset (buf, pos, T_COMMENT_line)
    ) // end of ['\n']
  | _ => let
      val () = posincby1 (pos) in lexing_COMMENT_line (buf, pos)
    end // end of [_]
) else (
  lexbufpos_token_reset (buf, pos, T_COMMENT_line)
) // end of [if]
//
end // end of [lexing_COMMENT_line]

(* ****** ****** *)

implement
lexing_COMMENT_block_c
  (buf, pos) = let
//
  fun feof (
    buf: &lexbuf, pos: &position
  ) : token =
    lexbufpos_lexerr_reset (buf, pos, LE_COMMENT_block_unclose)
  // end of [feof]
//
  val i = lexbufpos_get_char (buf, pos)
//
in
  if i >= 0 then (
    case+ (i2c)i of
    | '*' when
        testing_literal (buf, pos, "*/") >= 0 =>
        lexbufpos_token_reset (buf, pos, T_COMMENT_block)
      // end of ['*']
    | _ => let
        val () = posincbyc (pos, i) in
        lexing_COMMENT_block_c (buf, pos)
      end // end of [_]
  ) else feof (buf, pos) // end of [if]
end // end of [lexing_COMMENT_block_c]

(* ****** ****** *)

implement
lexing_COMMENT_block_ml
  (buf, pos, xs) = let
//
  fun feof {l:pos} (
    buf: &lexbuf
  , pos: &position
  , xs: list_vt (position, l)
  ) : token = let
    val list_vt_cons (!p_x, _) = xs
    val loc = $LOC.location_make_pos_pos (!p_x, pos)
    prval () = fold@ (xs)
    val () = list_vt_free (xs)
    val err = lexerr_make (loc, LE_COMMENT_block_unclose)
    val () = the_lexerrlst_add (err)
    val () = lexbuf_reset_position (buf, pos)
  in
    token_make (loc, T_ERR)
  end // end of [feof]
//
  val i = lexbufpos_get_char (buf, pos)
//
in
//
if i >= 0 then (
  case+ (i2c)i of
  | '\(' => let
      var x: position
      val () = $LOC.position_copy (x, pos)
      val ans = testing_literal (buf, pos, "(*")
    in
      if ans >= 0 then
        lexing_COMMENT_block_ml (buf, pos, list_vt_cons (x, xs))
      else let
        val () = posincby1 (pos) in
        lexing_COMMENT_block_ml (buf, pos, xs)
      end // end of [if]
    end // end of ['\(']
  | '*' when
      testing_literal
        (buf, pos, "*)") >= 0 => let
      val ~list_vt_cons (_, xs) = xs
    in
      case+ xs of
      | list_vt_cons _ => let
          prval () = fold@ (xs) in
          lexing_COMMENT_block_ml (buf, pos, xs)
        end // end of [list_vt_cons]
      | ~list_vt_nil () =>
          lexbufpos_token_reset (buf, pos, T_COMMENT_block)
        // end of [list_vt_nil]
      (* end of [case] *)
    end // end of ['*']
  | _ => let
      val () = posincbyc (pos, i) in
      lexing_COMMENT_block_ml (buf, pos, xs)
    end // end of [_]
) else feof (buf, pos, xs) // end of [if]
//
end // end of [lexing_COMMENT_block_ml]

(* ****** ****** *)

implement
lexing_COMMENT_rest
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)  
in
  if i >= 0 then let
    val () = posincbyc (pos, i) in
    lexing_COMMENT_rest (buf, pos)
  end else (
    lexbufpos_token_reset (buf, pos, T_COMMENT_rest)
  ) // end of [if]
end // end of [lexing_COMMENT_rest]

(* ****** ****** *)

implement
lexing_EXTCODE_knd
  (buf, pos, knd) = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i in
  case+ c of
  | '%' => let
      val res = testing_literal (buf, pos, "%}")
    in
      if res >= 0 then let
        val loc = lexbufpos_get_location (buf, pos)
        val nchr = (if knd = 1 then 2u else 3u): uint
        val len = lexbufpos_diff (buf, pos) - nchr - 2u // %}: 2u
//
        val str = lexbuf_get_substrptr1 (buf, nchr, len)
        val str = string_of_strptr (str)
//
        val () = lexbuf_reset_position (buf, pos)
      in
        token_make (loc, T_EXTCODE (knd, str))
      end else let
        val () = posincby1 (pos) in lexing_EXTCODE_knd (buf, pos, knd)
      end // end of [if]
    end // end of ['%']
  | _ => let
      val () = $LOC.position_incby_char (pos, i)
    in
      lexing_EXTCODE_knd (buf, pos, knd)
    end // end of [_]
end else
  lexbufpos_lexerr_reset (buf, pos, LE_EXTCODE_unclose)
// end of [if]
end // end of [lexing_EXTCODE_knd]

implement
lexing_EXTCODE
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i
  val knd = (case+ c of
    | '^' =>  0 | '$' =>  2 | '#' => ~1 | _ => 1
  ) : int // end of [val]
  val () = if knd <> 1 then posincby1 (pos)
in
  lexing_EXTCODE_knd (buf, pos, knd)
end else
  lexing_EXTCODE_knd (buf, pos, 1(*default*))
// end of [if]
end // end of [lexing_EXTCODE]

(* ****** ****** *)

extern
fun lexing_LPAREN
  (buf: &lexbuf, pos: &position): token
implement
lexing_LPAREN
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ (i2c)i of
  | '*' => let
      val () = posincby1 (pos)
      val poslst = list_vt_cons {position} (?, list_vt_nil)
      val list_vt_cons (!p_x, _) = poslst
      val () = lexbuf_get_position (buf, !p_x)
      prval () = fold@ (poslst)
    in
      lexing_COMMENT_block_ml (buf, pos, poslst)
    end // end of ['*']
  | _ => lexbufpos_token_reset (buf, pos, T_LPAREN)
end // en dof [lexing_LPAREN]

(* ****** ****** *)

extern
fun lexing_COMMA
  (buf: &lexbuf, pos: &position): token
implement
lexing_COMMA (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ (i2c)i of
  | '\(' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, T_COMMALPAREN)
    end // end of ['(']
  | _ => lexbufpos_token_reset (buf, pos, T_COMMA)
end // end of [lexing_COMMA]

(* ****** ****** *)

extern
fun lexing_AT
  (buf: &lexbuf, pos: &position): token
implement
lexing_AT (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ (i2c)i of
//
  | '\(' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, T_ATLPAREN)
    end
  | '\[' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, T_ATLBRACKET)
    end
  | '\{' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, T_ATLBRACE)
    end
//
  | _ => let
      val k = testing_symbolicseq0 (buf, pos) in
      lexing_IDENT_sym (buf, pos, succ(k))
    end // end of [_]
// end of [case]
end // end of [lexing_AT]

(* ****** ****** *)

extern
fun lexing_COLON
  (buf: &lexbuf, pos: &position): token
implement
lexing_COLON (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ (i2c)i of
  | '<' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, T_COLONLT)
    end // end of ['(']
  | _ => let
      val k = testing_symbolicseq0 (buf, pos) in
      lexing_IDENT_sym (buf, pos, succ(k))
    end // end of [_]
end // end of [lexing_COLON]

(* ****** ****** *)

fun FLOATDOT_test
  (buf: &lexbuf, c: char): bool =
  if lexbuf_get_nspace (buf) > 0 then DIGIT_test (c) else false
// end of [testing_float_dot]

extern
fun lexing_DOT
  (buf: &lexbuf, pos: &position): token
implement
lexing_DOT
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
  val c = (i2c)i
  val nspace = lexbuf_get_nspace (buf)
in
  case+ 0 of
  | _ when
      SYMBOLIC_test (c) => let
      val () = posincby1 (pos)
      val k = testing_symbolicseq0 (buf, pos) in
      lexing_IDENT_sym (buf, pos, k+2u)
    end
(*
  | _ when nspace = 0 => let
    in
      if IDENTFST_test (c) then let
        val () = posincby1 (pos)
        val k = testing_identrstseq0 (buf, pos)
        val str = lexbuf_get_substrptr1 (buf, 1u, k+1u)
        val str = string_of_strptr (str)
      in
        lexbufpos_token_reset (buf, pos, T_LABEL (0(*sym*), str))
      end else if DIGIT_test (c) then let
        val () = posincby1 (pos)
        val k = testing_digitseq0 (buf, pos)
        val str = lexbuf_get_substrptr1 (buf, 1u, k+1u)
        val str = string_of_strptr (str)
      in
        lexbufpos_token_reset (buf, pos, T_LABEL (1(*int*), str))
      end else
        lexbufpos_token_reset (buf, pos, DOT)
      // end of [if]
    end // end of [nspace = 0u]
*)
  | _ when
      FLOATDOT_test (buf, c) => let
      val () = posdecby1 (pos)
    in
      if testing_deciexp (buf, pos) >= 0 then
        lexing_FLOAT_deciexp (buf, pos)
      else (* HX: it cannot be taken *)
        lexbufpos_token_reset (buf, pos, T_ERR)
      // end of [if]
    end // end of [nspace > 0]
  | _ => lexbufpos_token_reset (buf, pos, DOT)
end // end of [lexing_DOT]
  
(* ****** ****** *)

extern
fun lexing_PERCENT
  (buf: &lexbuf, pos: &position): token
implement
lexing_PERCENT
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
  val c = (i2c)i
in
  case+ c of 
  | '\(' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, T_PERCENTLPAREN)
    end // end of ['\(']
  | '\{' => let
      val () = posincby1 (pos) in lexing_EXTCODE (buf, pos)
    end // end of ['\{']
  | _ => let
      val k = testing_symbolicseq0 (buf, pos) in
      lexing_IDENT_sym (buf, pos, succ(k))
    end // end of [_]
end // end of [lexing_PERCENT]

(* ****** ****** *)

extern
fun lexing_DOLLAR
  (buf: &lexbuf, pos: &position): token
implement
lexing_DOLLAR
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
  val c = (i2c)i
in
  case+ c of
  | _ when IDENTFST_test (c) => let
      val () = posincby1 (pos)
      val k = testing_identrstseq0 (buf, pos)
    in
      lexing_IDENT_dlr (buf, pos, k+2u)
    end // end of [_ when ...]
  | _ => let
      val k = testing_symbolicseq0 (buf, pos) in
      lexing_IDENT_sym (buf, pos, succ(k))
    end // end of [_]
end // end of [lexing_DOLLAR]

(* ****** ****** *)

extern
fun lexing_SHARP
  (buf: &lexbuf, pos: &position): token
implement
lexing_SHARP
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
  val c = (i2c)i
in
  case+ c of
  | '\[' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, T_HASHLBRACKET)
    end // end of ['\(']
  | _ when IDENTFST_test (c) => let
      val () = posincby1 (pos)
      val k = testing_identrstseq0 (buf, pos)
    in
      lexing_IDENT_srp (buf, pos, k+2u)
    end // end of [_ when ...]
  | _ => let
      val k = testing_symbolicseq0 (buf, pos) in
      lexing_IDENT_sym (buf, pos, succ(k))
    end // end of [_]
end // end of [lexing_SHARP]

(* ****** ****** *)

extern
fun lexing_QUOTE
  (buf: &lexbuf, pos: &position): token
// end of [lexing_QUOTE]
extern
fun lexing_DQUOTE
  (buf: &lexbuf, pos: &position): token
// end of [lexing_DQUOTE]

(* ****** ****** *)

local

extern
fun lexing_char_oct
  (buf: &lexbuf, pos: &position, k: uint): token
extern
fun lexing_char_hex
  (buf: &lexbuf, pos: &position, k: uint): token
extern
fun lexing_char_special
  (buf: &lexbuf, pos: &position): token
extern
fun lexing_char_closing
  (buf: &lexbuf, pos: &position, c: char): token

implement
lexing_char_oct
  (buf, pos, k) = let
  fun loop (
    buf: &lexbuf
  , k: uint, nchr: uint, i: int
  ) : int =
    if k > 0u then let
      val d = lexbuf_get_char (buf, nchr)
      val i = i * 8 + ((i2c)d - '0')
    in
      loop (buf, pred(k), succ(nchr), i)
    end else i
  val i = loop (buf, k, 2u, 0)
  val c = (i2c)i
in
  lexing_char_closing (buf, pos, c)
end // end of [lexing_char_oct]

implement
lexing_char_hex
  (buf, pos, k) = let
  fun loop (
    buf: &lexbuf
  , k: uint, nchr: uint, i: int
  ) : int =
    if k > 0u then let
      val d = lexbuf_get_char (buf, nchr)
      val i = i * 16 + xdigit_get_val ((i2c)d)
    in
      loop (buf, pred(k), succ(nchr), i)
    end else i
  val i = loop (buf, k, 3u, 0)
  val c = (i2c)i
in
  lexing_char_closing (buf, pos, c)
end // end of [lexing_char_hex]

implement
lexing_char_special
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
  val c = (i2c)i
in
  case+ 0 of
  | _ when ESCHAR_test (c) => let
      val () = posincby1 (pos)
      val c = char_for_escaped (c)
    in
      lexing_char_closing (buf, pos, c)
    end // end of [_ when ...]
  | _ when xX_test (c) => let
      val () = posincby1 (pos)
      val k = testing_xdigitseq0 (buf, pos)
    in
      if k = 0u then
        lexbufpos_lexerr_reset (buf, pos, LE_CHAR_hex)
      else
        lexing_char_hex (buf, pos, k)
      // end of [if]
    end // end of [_ when ...]
  | _ => let
      val k = testing_digitseq0 (buf, pos)
    in
      if k = 0u then
        lexbufpos_lexerr_reset (buf, pos, LE_CHAR_oct)
      else
        lexing_char_oct (buf, pos, k)
      // end of [if]
    end // end of [_]
  // end of [case]
end // end of [lexing_char_special]

implement
lexing_char_closing
  (buf, pos, c) = let
  val res = testing_char (buf, pos, '\'')
in
  if res >= 0 then
    lexbufpos_token_reset (buf, pos, T_CHAR (c))
  else
    lexbufpos_lexerr_reset (buf, pos, LE_CHAR_unclose)
  // end of [if]
end // end of [lexing_char_closing]

in // in of [local]

implement
lexing_QUOTE (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i
  val () = posincby1 (pos) in
  case+ c of
//
  | '\(' => lexbufpos_token_reset (buf, pos, T_QUOTELPAREN)
  | '\[' => lexbufpos_token_reset (buf, pos, T_QUOTELBRACKET)
  | '\{' => lexbufpos_token_reset (buf, pos, T_QUOTELBRACE)
//
  | _ when c = '\\' =>
      lexing_char_special (buf, pos)
  | _ => lexing_char_closing (buf, pos, c)
end else
  lexbufpos_lexerr_reset (buf, pos, LE_QUOTE_dangling)
// end of [if]
end // end of [lexing_QUOTE]

end // end of [local]

(* ****** ****** *)

local

staload "libats/SATS/linqueue_arr.sats"
staload _(*anon*) = "prelude/DATS/array.dats"
staload _(*anon*) = "libats/DATS/linqueue_arr.dats"
staload _(*anon*) = "libats/ngc/DATS/deque_arr.dats"

fun lexing_string_char_oct (
  buf: &lexbuf, pos: &position
) : int = let
  fun loop (
    buf: &lexbuf
  , pos: &position
  , n: &int, i: int
  ) : int =
    if n > 0 then let
      val d = lexbufpos_get_char (buf, pos)
      val c = (i2c)d
    in
      case+ 0 of
      | _ when
          DIGIT_test (c) => let
          val () = posincby1 (pos)
          val () = n := n-1
        in
          loop (buf, pos, n, 8*i+(c-'0'))
        end // end of [_ when ...]
      | _ => i
    end else i
  // end of [loop]
  var n: int = 3 // HX: \d1d2d3
  val i = loop (buf, pos, n, 0) // = 8*(8*d1 + d2) + d3
//
  val () = if (n = 3) then {
    val loc = $LOC.location_make_pos_pos (pos, pos)
    val err = lexerr_make (loc, LE_STRING_char_oct)
    val () = the_lexerrlst_add (err)
  } // end of [if]
//
in
  i // char code
end // end of [lexing_string_char_oct]

fun lexing_string_char_hex (
  buf: &lexbuf, pos: &position
) : int = let
  fun loop (
    buf: &lexbuf
  , pos: &position
  , n: &int, i: int
  ) : int =
    if n > 0 then let
      val d = lexbufpos_get_char (buf, pos)
      val c = (i2c)d
    in
      case+ 0 of
      | _ when
          XDIGIT_test (c) => let
          val () = posincby1 (pos)
          val () = n := n-1
        in
          loop (buf, pos, n, 16*i+xdigit_get_val (c))
        end // end of [_ when ...]
      | _ => i
    end else i
  // end of [loop]
  var n: int = 2 // HX: 0xd1d2
  val i = loop (buf, pos, n, 0) // 16*d1 + d2
//
  val () = if (n = 2) then {
    val loc = $LOC.location_make_pos_pos (pos, pos)
    val err = lexerr_make (loc, LE_STRING_char_hex)
    val () = the_lexerrlst_add (err)
  } // end of [if]
//
in
  i // char code
end // end of [lexing_string_char_hex]

#define AGAIN 1
fun lexing_string_char_special (
  buf: &lexbuf, pos: &position, err: &int
) : int = let
  val i = lexbufpos_get_char (buf, pos)
in
//
if i >= 0 then let
  val c = (i2c)i in
  case+ c of
  | '\n' => let
      val () = err := AGAIN
      val () = posincbyc (pos, i)
    in
      0 // HX: of no use
    end // end of ['\n']
  | _ when ESCHAR_test (c) => let
      val () = posincby1 (pos) in c2i(char_for_escaped(c))
    end // end of [_ when ...]
  | _ when xX_test (c) => let
      val () = posincby1 (pos) in lexing_string_char_hex (buf, pos)
    end // end of [_ when ...]
  | _ => lexing_string_char_oct (buf, pos)
end else 0  // end of [if]
//
end // end of [lexing_string_char_special]

in // in of [local]

implement
lexing_DQUOTE
  (buf, pos) = let
//
  fn* loop {m,n:int | m > 0} (
    buf: &lexbuf
  , pos: &position
  , q: &QUEUE (uchar, m, n) >> QUEUE (uchar, m, n)
  , m: size_t (m), n: size_t (n)
  ) : #[m,n:nat] size_t (n) = let
    val i = lexbufpos_get_char (buf, pos)
    prval () = queue_param_lemma (q) // m >= n >= 0
  in
    if i >= 0 then let
      val c = (i2c)i
      val () = posincbyc (pos, i)
    in
      case+ c of
      | '"' => n // string is properly closed
      | '\\' => let
          var err: int = 0
          val i = lexing_string_char_special (buf, pos, err)
        in
          if err = AGAIN then
            loop (buf, pos, q, m, n)
          else
            loop_ins (buf, pos, q, m, n, i)
          // end of [if]
        end // end of ['\\']
      | _ => loop_ins (buf, pos, q, m, n, i)
    end else let
      val loc = lexbufpos_get_location (buf, pos)
      val err = lexerr_make (loc, LE_STRING_unclose)
      val () = the_lexerrlst_add (err)
    in
      queue_size {uchar} (q)
    end (* end of [if] *)
  end // end of [loop]
//  
  and loop_ins {m,n:int | m > 0} (
    buf: &lexbuf
  , pos: &position
  , q: &QUEUE (uchar, m, n) >> QUEUE (uchar, m, n)
  , m: size_t (m), n: size_t (n), i: int
  ) : #[m,n:nat] size_t (n) = let
    val c = (i2uc)i
    prval () = queue_param_lemma (q) // m >= n >= 0
  in
    case+ 0 of
    | _ when m > n => let
        val () = queue_insert<uchar> (q, c) in
        loop (buf, pos, q, m, n+1)
      end
    | _ => let
        val m2 = m + m
        val () = queue_update_capacity<uchar> (q, m2)
        val () = queue_insert (q, c)
      in
        loop (buf, pos, q, m2, n+1)
      end
  end // end of [loop_ins]
//
  var q: QUEUE0(uchar)
  #define m0 128 // HX: chosen randomly
  val () = queue_initialize<uchar> (q, m0)
//
  val n = loop (buf, pos, q, m0, 0)
  val str = $UTL.queue_get_strptr1 (q, 0, n)
  val str = string_of_strptr (str)
//
  val () = queue_uninitialize (q)
in
  lexbufpos_token_reset (buf, pos, T_STRING (str))
end // end of [lexing_DQUOTE]

end // end of [local]

(* ****** ****** *)

fun lexing_postfix (
  buf: &lexbuf
, pos: &position
, tn: tnode, tn_post: tnode, c0: char
) : token = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ 0 of
  | _ when c0 = (i2c)i => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, tn_post)
    end
  | _ => lexbufpos_token_reset (buf, pos, tn)
end // end of [lexing_postfix]

fun lexing_polarity (
  buf: &lexbuf, pos: &position
, tn: tnode, tn_pos: tnode, tn_neg: tnode
) : token = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ (i2c)i of
  | '+' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, tn_pos)
    end
  | '-' => let
      val () = posincby1 (pos) in
      lexbufpos_token_reset (buf, pos, tn_neg)
    end
  | _ => lexbufpos_token_reset (buf, pos, tn)
end // end of [lexing_polarity]

(* ****** ****** *)

fun lexing_FN (
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, FN, FNSTAR, '*')
fun lexing_FOR (
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, FOR, FORSTAR, '*')
fun lexing_WHILE (
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, WHILE, WHILESTAR, '*')

(* ****** ****** *)

fun lexing_CASE (
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, CASE, CASE_pos, CASE_neg)
// end of [lexing_CASE]

fun lexing_VAL (
  buf: &lexbuf, pos: &position
) : token = 
  lexing_polarity (buf, pos, VAL, VAL_pos, VAL_neg)
// end of [lexing_VAL]

(* ****** ****** *)

fun lexing_TYPE (
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, TYPE, TYPE_pos, TYPE_neg)
// end of [lexing_TYPE]
fun lexing_T0YPE (
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, T0YPE, T0YPE_pos, T0YPE_neg)
// end of [lexing_T0YPE]
fun lexing_PROP (
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, PROP, PROP_pos, PROP_neg)
// end of [lexing_PROP]
fun lexing_VIEW (
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, VIEW, VIEW_pos, VIEW_neg)
// end of [lexing_VIEW]
fun lexing_VIEWTYPE (
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, VIEWTYPE, VIEWTYPE_pos, VIEWTYPE_neg)
// end of [lexing_VIEWTYPE]
fun lexing_VIEWT0YPE (
  buf: &lexbuf, pos: &position
) : token =
  lexing_polarity (buf, pos, VIEWT0YPE, VIEWT0YPE_pos, VIEWT0YPE_neg)
// end of [lexing_VIEWT0YPE]

(* ****** ****** *)

fun lexing_LAM (
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, LAM, LAMAT, '@')
fun lexing_LLAM (
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, LLAM, LLAMAT, '@')
fun lexing_FIX (
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, FIX, FIXAT, '@')

(* ****** ****** *)

fun lexing_FOLD (
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, FOLD, FOLDAT, '@')
fun lexing_FREE (
  buf: &lexbuf, pos: &position
) : token = lexing_postfix (buf, pos, FREE, FREEAT, '@')

(* ****** ****** *)

implement
lexing_IDENT_alp
  (buf, pos, k) = let
  val i = lexbufpos_get_char (buf, pos)
in
  case+ (i2c)i of
  | '<' => let
      val () = posincby1 (pos)
      val str = lexbuf_get_strptr1 (buf, k)
      val str = string_of_strptr (str)
    in
      lexbufpos_token_reset (buf, pos, T_IDENT_tmp (str))
    end
  | '\[' => let
      val () = posincby1 (pos)
      val str = lexbuf_get_strptr1 (buf, k)
      val str = string_of_strptr (str)
    in
      lexbufpos_token_reset (buf, pos, T_IDENT_arr (str))
    end
  | _ => let
      val str = lexbuf_get_strptr1 (buf, k) in
      lexing_IDENT1_alp (buf, pos, str)
    end // end of [_]
  // end of [case]
end // end of [lexing_IDENT_alp]

implement
lexing_IDENT1_alp
  {l} (buf, pos, str) = let
  viewtypedef vt = strptr l
  val sym = IDENT_alp_get_lexsym ($UN.castvwtp1{string}{vt}(str))
in
  case+ sym of
  | LS_ABST () when
      testing_literal (buf, pos, "@ype") >= 0 => let
      val () = strptr_free (str) in
      lexbufpos_token_reset (buf, pos, ABST0YPE)
    end
  | LS_ABSVIEWT () when
      testing_literal (buf, pos, "@ype") >= 0 => let
      val () = strptr_free (str) in
      lexbufpos_token_reset (buf, pos, ABSVIEWT0YPE)
    end
  | LS_CASE () => let
      val () = strptr_free (str) in lexing_CASE (buf, pos)
    end
  | LS_FN () => let
      val () = strptr_free (str) in lexing_FN (buf, pos)
    end
  | LS_FOR () => let
      val () = strptr_free (str) in lexing_FOR (buf, pos)
    end
  | LS_PROP () => let
      val () = strptr_free (str) in lexing_PROP (buf, pos)
    end
  | LS_T () when
      testing_literal (buf, pos, "@ype") >= 0 => let
      val () = strptr_free (str) in lexing_T0YPE (buf, pos)
    end
  | LS_TYPE () => let
      val () = strptr_free (str) in lexing_TYPE (buf, pos)
    end
  | LS_T0YPE () => let
      val () = strptr_free (str) in lexing_T0YPE (buf, pos)
    end
  | LS_VAL () => let
      val () = strptr_free (str) in lexing_VAL (buf, pos)
    end
  | LS_VIEW () => let
      val () = strptr_free (str) in lexing_VIEW (buf, pos)
    end
  | LS_VIEWT () when
      testing_literal (buf, pos, "@ype") >= 0 => let
      val () = strptr_free (str) in lexing_VIEWT0YPE (buf, pos)
    end
  | LS_VIEWTYPE () => let
      val () = strptr_free (str) in lexing_VIEWTYPE (buf, pos)
    end
  | LS_VIEWT0YPE () => let
      val () = strptr_free (str) in lexing_VIEWT0YPE (buf, pos)
    end
  | LS_WHILE () => let
      val () = strptr_free (str) in lexing_WHILE (buf, pos)
    end
//
  | LS_FOLD () => let
      val () = strptr_free (str) in lexing_FOLD (buf, pos)
    end
  | LS_FREE () => let
      val () = strptr_free (str) in lexing_FREE (buf, pos)
    end
//
  | LS_LAM () => let
      val () = strptr_free (str) in lexing_LAM (buf, pos)
    end
  | LS_LLAM () => let
      val () = strptr_free (str) in lexing_LLAM (buf, pos)
    end
  | LS_FIX () => let
      val () = strptr_free (str) in lexing_FIX (buf, pos)
    end
//
  | _ => let
      val tnode =
        tnode_search ($UN.castvwtp1{string}{vt} (str))
      // end of [val]
    in
      case+ tnode of
      | T_NONE () => let
          val str = string_of_strptr (str) in
          lexbufpos_token_reset (buf, pos, T_IDENT_alp (str))
        end
      | _ => let
          val str = strptr_free (str) in
          lexbufpos_token_reset (buf, pos, tnode)
        end // end of [_]
    end // end of [_]
end // end of [lexing_IDENT1_alp]

(* ****** ****** *)

implement
lexing_IDENT_sym
  (buf, pos, k) = let
//
  val [l:addr] str = lexbuf_get_strptr1 (buf, k)
//
  viewtypedef vt = strptr l
  val sym = IDENT_sym_get_lexsym ($UN.castvwtp1{string}{vt}(str))
in
  case+ sym of
(*
  | LS_LTBANG () => let
      val () = posdecby1 (pos)
      val () = strptr_free (str) in
      lexbufpos_token_reset (buf, pos, LT)
    end // end of [LS_LTBANG]
  | LS_LTDOLLAR () => let
      val () = posdecby1 (pos)
      val () = strptr_free (str) in
      lexbufpos_token_reset (buf, pos, LT)
    end // end of [LS_LTDOLLOR]
*)
  | LS_QMARKGT () => let
      val () = posdecby1 (pos)
      val () = strptr_free (str) in
      lexbufpos_token_reset (buf, pos, QMARK)
    end // end of [LS_QMARKGT]
//
  | LS_SLASH2 () => let
      val () = strptr_free (str) in lexing_COMMENT_line (buf, pos)
    end // end of [LS_SLASH2]
  | LS_SLASHSTAR () => let
      val () = strptr_free (str) in lexing_COMMENT_block_c (buf, pos)
    end // end of [LS_SLASHSTAR]
  | LS_SLASH4 () => let
      val () = strptr_free (str) in lexing_COMMENT_rest (buf, pos)
    end // end of [LS_SLASH2]
//
  | _ => let
      val tnode = tnode_search ($UN.castvwtp1{string}{vt} (str))
    in
      case+ tnode of
      | T_NONE () => let
          val str = string_of_strptr (str) in
          lexbufpos_token_reset (buf, pos, T_IDENT_sym (str))
        end // end of [T_NONE]
      | _ => let
          val () = strptr_free (str) in
          lexbufpos_token_reset (buf, pos, tnode)
        end // end of [_]
    end // end of [_]
end // end of [lexing_IDENT_sym]

(* ****** ****** *)

implement
lexing_IDENT_dlr
  (buf, pos, k) = let
//
  val [l:addr] str = lexbuf_get_strptr1 (buf, k)
//
  viewtypedef vt = strptr l
  val tnode = tnode_search ($UN.castvwtp1{string}{vt} (str))
in
  case+ tnode of
  | T_NONE () => let
      val str = string_of_strptr (str) in
      lexbufpos_token_reset (buf, pos, T_IDENT_dlr (str))
    end
  | _ => let
      val str = strptr_free (str) in
      lexbufpos_token_reset (buf, pos, tnode)
    end // end of [_]
end // end of [lexing_IDENT_dlr]

implement
lexing_IDENT_srp
  (buf, pos, k) = let
//
  val [l:addr] str = lexbuf_get_strptr1 (buf, k)
//
  viewtypedef vt = strptr l
  val tnode = tnode_search ($UN.castvwtp1{string}{vt} (str))
in
  case+ tnode of
  | T_NONE () => let
      val str = string_of_strptr (str) in
      lexbufpos_token_reset (buf, pos, T_IDENT_srp (str))
    end
  | _ => let
      val () = strptr_free (str) in
      lexbufpos_token_reset (buf, pos, tnode)
    end // end of [_]
end // end of [lexing_IDENT_srp]

(* ****** ****** *)

implement
lexing_FLOAT_deciexp
  (buf, pos) = let
  val k = testing_floatspseq0 (buf, pos)
  val str = lexbufpos_get_strptr1 (buf, pos)
  val str = string_of_strptr (str)
in
  lexbufpos_token_reset (buf, pos, T_FLOAT (10(*base*), str, k))
end // end of [lexing_FLOAT_deciexp]

implement
lexing_FLOAT_hexiexp
  (buf, pos) = let
  val k = testing_floatspseq0 (buf, pos)
  val str = lexbufpos_get_strptr1 (buf, pos)
  val str = string_of_strptr (str)
in
  lexbufpos_token_reset (buf, pos, T_FLOAT (16(*base*), str, k))
end // end of [lexing_FLOAT_hexiexp]

(* ****** ****** *)

implement
lexing_INTEGER_dec
  (buf, pos, k1) =
  case+ 0 of
  | _ when
      testing_deciexp (buf, pos) >= 0 => let
    in
      lexing_FLOAT_deciexp (buf, pos)
    end // end of [_ when ...]
  | _ when
      testing_fexponent (buf, pos) >= 0 => let
    in
      lexing_FLOAT_deciexp (buf, pos)
    end // end of [_ when ...]
  | _ => let
      val k2 = testing_intspseq0 (buf, pos)
      val str = lexbufpos_get_strptr1 (buf, pos)
      val str = string_of_strptr (str)
    in
      lexbufpos_token_reset (buf, pos, T_INTEGER_dec (str, k2))
    end // end of [_]
// end of [lexing_INTEGER_dec]

(* ****** ****** *)

implement
lexing_INTEGER_oct
  (buf, pos, k1) =
if k1 >= 2u then let
  val k2 = testing_intspseq0 (buf, pos)
  val str = lexbuf_get_strptr1 (buf, k1+k2+1u) // 0: 1u
  val str = string_of_strptr (str)
in
  lexbufpos_token_reset (buf, pos, T_INTEGER_oct (str, k2))
end else
  lexing_INTEGER_dec (buf, pos, k1)
// end of [lexing_INTEGER_oct]

(* ****** ****** *)

implement
lexing_INTEGER_hex
  (buf, pos, k1) =
  case+ 0 of
  | _ when
      testing_hexiexp (buf, pos) >= 0 => let
    in
      lexing_FLOAT_hexiexp (buf, pos)
    end // end of [_ when ...]
  | _ when
      testing_fexponent_bin (buf, pos) >= 0 => let
    in
      lexing_FLOAT_hexiexp (buf, pos)
    end // end of [_ when ...]
  | _ => let
      val k2 = testing_intspseq0 (buf, pos)
      val str = lexbufpos_get_strptr1 (buf, pos)
      val str = string_of_strptr (str)
    in
      lexbufpos_token_reset (buf, pos, T_INTEGER_hex (str, k2))
    end // end of [_]
// end of [lexing_INTEGER_hex]

(* ****** ****** *)

extern
fun lexing_ZERO
  (buf: &lexbuf, pos: position): token
implement
lexing_ZERO
  (buf, pos) = let
  val i = lexbufpos_get_char (buf, pos)
in
  if i >= 0 then let
    val c = (i2c)i in
    case+ 0 of
    | _ when xX_test (c) => let
        val () = posincby1 (pos)
        val k1 = testing_xdigitseq0 (buf, pos)
      in
        lexing_INTEGER_hex (buf, pos, k1)
      end // end of [_ when ...]
    | _ => let
        val k1 = testing_digitseq0 (buf, pos)
      in
        lexing_INTEGER_oct (buf, pos, k1)
      end // end of [_]
    // end of [case]
  end else
    lexbufpos_token_reset (buf, pos, ZERO)
  // end of [if]
end // end of [lexing_ZERO]

(* ****** ****** *)

implement
lexing_next_token
  (buf) = let
//
  var pos: position
  val () = lexbuf_get_position (buf, pos)
  val k = testing_blankseq0 (buf, pos)
  val () = lexbuf_set_nspace (buf, (u2i)k)
  val () = lexbuf_reset_position (buf, pos)
  val i0 = lexbuf_get_char (buf, 0u)
//
in
//
if i0 >= 0 then let
  val c = (i2c)i0 // the first character
  val () = posincbyc (pos, i0)
in
  case+ 0 of
//
  | _ when c = '\(' =>
      lexing_LPAREN (buf, pos)
  | _ when c = ')' =>
      lexbufpos_token_reset (buf, pos, T_RPAREN)
  | _ when c = '\[' =>
      lexbufpos_token_reset (buf, pos, T_LBRACKET)
  | _ when c = ']' =>
      lexbufpos_token_reset (buf, pos, T_RBRACKET)
  | _ when c = '\{' =>
      lexbufpos_token_reset (buf, pos, T_LBRACE)
  | _ when c = '}' =>
      lexbufpos_token_reset (buf, pos, T_RBRACE)
//
  | _ when c = ',' => lexing_COMMA (buf, pos)
  | _ when c = ';' =>
      lexbufpos_token_reset (buf, pos, T_SEMICOLON)
//
  | _ when c = '@' => lexing_AT (buf, pos)
  | _ when c = ':' => lexing_COLON (buf, pos)
  | _ when c = '.' => lexing_DOT (buf, pos)
  | _ when c = '%' => lexing_PERCENT (buf, pos)
  | _ when c = '$' => lexing_DOLLAR (buf, pos)
  | _ when c = '#' => lexing_SHARP (buf, pos)
//
  | _ when c = '\'' => lexing_QUOTE (buf, pos)
  | _ when c = '"' => lexing_DQUOTE (buf, pos) // for strings
//
  | _ when c = '\\' =>
      lexbufpos_token_reset (buf, pos, T_BACKSLASH)
//
  | _ when IDENTFST_test (c) => let
      val k = testing_identrstseq0 (buf, pos)
    in
      lexing_IDENT_alp (buf, pos, succ(k))
    end // end of [_ when ...]
  | _ when SYMBOLIC_test (c) => let
      val k = testing_symbolicseq0 (buf, pos) in
      lexing_IDENT_sym (buf, pos, succ(k))
    end // end of [_ when ...]
//
  | _ when c = '0' => lexing_ZERO (buf, pos)
//
  | _ when DIGIT_test (c) => let
      val k1 = testing_digitseq0 (buf, pos)
    in
      lexing_INTEGER_dec (buf, pos, k1)
    end // end of [_ when ...]
//
  | _ => let
//
// HX: skipping unrecognized chars
//
      val loc = lexbufpos_get_location (buf, pos)
      val err = lexerr_make (loc, LE_UNSUPPORTED (c))
      val () = the_lexerrlst_add (err)
      val () = lexbuf_reset_position (buf, pos)
    in
      lexing_next_token (buf)
    end // end of [_]
end else
  lexbufpos_token_reset (buf, pos, T_EOF)
// end of [if]
//
end // end of [lexing_get_next_token]

(* ****** ****** *)

implement
lexing_next_token_ncmnt
  (buf) = let
  val tok = lexing_next_token (buf)
in
  case+ tok.token_node of
  | T_COMMENT_line _ => lexing_next_token_ncmnt (buf)
  | T_COMMENT_block _ => lexing_next_token_ncmnt (buf)
  | T_COMMENT_rest _ => lexing_next_token_ncmnt (buf)
  | _ => tok
end // end of [lexing_next_token_ncmnt]

(* ****** ****** *)

(* end of [pats_lexing.dats] *)
