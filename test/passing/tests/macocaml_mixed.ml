
module type Numeric = sig
  type t

  val zero : t

  val add : t -> t -> t

  $val width : int

  $gen lift : t -> t expr
end


$gen rec power base n =
  if n = 0 then << 1 >>
  else if n mod 2 = 0 then << let half = $(power base (n / 2)) in half * half >>
  else << $base * $(power base (n - 1)) >>

$gen sum_of_first n =
  let rec go i acc = if i > n then acc else go (i + 1) << $acc + $(Expr.int i) >> in
  go 1 << 0 >>


$let table_size = 16

$let table = Array.init table_size (fun i -> i * i)

$gen lookup i = << $(Expr.int table.(i)) >>


module Make [N : Numeric] = struct
  type t = N.t

  $let scale = N.width * 2

  $gen scaled x = << $(N.lift x) + $(Expr.int scale) >>

  let zero = N.zero

  let unrolled = $(power << 3 >> 5)

  let from_table = $(lookup 7)

  module Inner [M : Numeric] = struct
    $gen combine a b = << N.add $(N.lift a) $(M.lift b) >>
  end
end


module Ints = struct
  type t = int

  let zero = 0

  let add = ( + )

  $let width = 32

  $gen lift x = Expr.int x
end

module I = Make [Ints]
module II = I.Inner [Ints]
module Anonymous = Make [struct
  type t = int

  let zero = 0

  let add = ( + )

  $let width = 8

  $gen lift x = Expr.int x
end]

let a = $(I.scaled 3)

let b = $(II.combine 1 2)

let c = ! $(I.scaled 1)

let d = - $(I.scaled 2)


let e = f $ $(I.scaled 4) $ $(I.scaled 5)

let f = List.map (( $ ) g) [ $(lookup 1); $(lookup 2) ]


$let%ext [@attr] instrumented = ref 0

$gen%ext [@attr] traced x = << incr counter; $x >> [@@doc "traced macro"]


$gen commented  x =
  <<  $(  x) >>

$gen commented_after x = << $(x ) >>

module Commented_functor [ P : Numeric] = struct
  let v = $(P.lift P.zero)
end


$gen long_quotation environment =
  <<
    let looked_up = $(lookup 3) and computed = $(power << 2 >> 8) in
    List.fold_left ( + ) 0 [ looked_up; computed; $(Expr.int table_size) ]
  >>

module Make_many
    [Alpha : Numeric]
    [Beta : Numeric]
    [Gamma : Numeric]
    (Delta : Numeric) = struct
  $gen widths () =
    <<
      [ $(Expr.int Alpha.width)
      ; $(Expr.int Beta.width)
      ; $(Expr.int Gamma.width)
      ; $(Expr.int Delta.width) ]
    >>
end

let () = Printf.printf "%d %d %d\n" a b $(I.scaled 6)
