
module type S = sig
  type t

  val v : t
end


module F [X : S] = struct
  type t = X.t

  let v = X.v
end

module Unit_param [] = struct
  let v = 0
end

module Anonymous [_ : S] = struct
  let v = 0
end

module Template_first [X : S] (Y : S) = struct
  type t = X.t * Y.t
end

module Plain_first (X : S) [Y : S] = struct
  type t = X.t * Y.t
end

module Mixed [X : S] (Y : S) [] () = struct
  type t = X.t * Y.t
end

module Literal = functor [X : S] -> struct let v = X.v end

module Ascribed : [X : S] S = functor [X : S] -> struct
  type t = X.t

  let v = X.v
end


module A_template_functor_with_many_parameters
    [Alpha : S]
    [Beta : S]
    [Gamma : S]
    [Delta : S]
    [Epsilon : S] =
struct
  let v = 0
end


module A = F [B]

module A_unit = Unit_param []

module A_constrained = F [(B : S)]

module A_struct = F [struct
  type t = int

  let v = 0
end]

module A_nested = F [F [B]]

module A_curried = Mixed [B] (C) [] ()

module A_path = Lib.F [B]

include F [B]

include Unit_param []


module type T_template = [X : S] sig
  val v : X.t
end

module type T_unit = [] sig
  val v : int
end


module type T_unnamed = [S] S

module type T_nested = [X : S] [Y : S] S

module type T_mixed = [X : S] (Y : S) -> S

module type T_plain_first = (Y : S) -> [X : S] S


module type T_body_extends = [S] S -> S


module type T_fused = [X : S with type t = < a : int > ] S

module Fused [X : S with type t = < a : int > ] = struct
  let v = 0
end


module Commented [ X : S] = struct
  let v = 0
end

module Commented_arg = F [ B]

module Commented_unit [] = struct
  let v = 0
end
