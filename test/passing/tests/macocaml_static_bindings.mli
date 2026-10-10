(** MacoCaml static and macro value descriptions. *)

$val width : int
(** A static value: available to the static and macro levels. *)

$val next : int -> int

val runtime : int
(** An ordinary value description, for contrast. *)

$val[..] const : int -> int expr
(** A macro. *)

$val[..] apply : (int expr -> int expr) -> int expr -> int expr

$val poly : 'a. 'a list -> 'a list

$val[..]%ext [@attr] gen_tagged : unit -> unit expr

$val [..] spaced : int expr -> int expr
(** A blank before the mark is accepted, and dropped. *)

external identity : int -> int = "%identity"

module type S = sig
  type t

  $val v : int

  $val[..] m : int expr -> int expr

  val w : t
end

module M : sig
  $val v : int

  $val[..] m : int expr -> int expr
end

$val a_value_description_with_a_very_long_name :
  int list -> (int -> int -> int) -> int list -> int

$val[..] a_macro_description_with_a_very_long_name :
  int expr -> int expr -> int expr -> int expr
