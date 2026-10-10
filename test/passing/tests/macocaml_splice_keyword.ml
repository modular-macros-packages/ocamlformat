(* MacoCaml: a dollar glued to a keyword with no staged form, or to _, is a
   lexical error (fork b46ccc6dde): $if, $in and $_ do not lex, while $let
   and $val are keywords.  A variable whose name is a keyword is spliced by
   its raw identifier, $\#if, or through parentheses, $(\#if); the compiler
   prints both $(\#if), with no dollar glued to an escape, and so does
   ocamlformat. *)

let \#if = << 1 >>

let \#match = << 2 >>

let a = << $\#if + $\#match >>

let b = << $(\#if) * $(\#match) >>

let c = << $\#if.contents + $\#match x >>

(* let and val too: $let and $val are keywords, $\#let and $\#val are
   splices. *)

let d = << $\#let + $(\#let) + $\#val + $(\#val) >>

(* An escape is kept on a name that is not a keyword, and so are the
   parentheses. *)

let e = << $\#foo + $(\#foo) + $\#été >>

(* A qualified name may end in an escape: [$M.\#if] is accepted, and printed
   in parentheses as before. *)

module M = struct
  let \#if = << 3 >>
end

let f = << $M.\#if + $(M.\#if) >>

(* As the compiler reads them, f $\#if applies f to a splice, while
   f $ \#if applies the operator ( $ ). *)

let g = << f $\#if >>

let h = << f $ \#if >>

(* Comments around a splice spelt with an escape. *)

let i = << (* before *) $\#if + $\#match (* after *) >>

(* The domain of a template type: a keyword used as a name is written with an
   escape, which keeps the parentheses, $(\#in) -> S, as the compiler prints
   it, unless the name is qualified, $M.\#in -> S. *)

module type T_keyword = $\#in -> $(\#in) -> $M.\#in -> $(M.\#in) -> S

module type T_staged_keyword = $\#let -> $(\#val) -> $M.\#let -> S

module type T_not_a_keyword = $\#s -> $(\#s) -> $s -> S

module type T_comment = (* before *) $\#in -> $(\#in) (* after *) -> S

module type T_signature = sig
  module F : $\#in -> $M.\#in -> S

  module G : $\#if -> $(X : S) -> \#if
end
