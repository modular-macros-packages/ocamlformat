
$gen zero = << 0 >>

$gen pair x y = << ($x, $y) >>


let a = $(zero)

let b = $zero

let c = $Lib.zero

let d = $Lib.Deep.zero


let gen = 1

let e = $(gen)


let f = ! $a

let g = ! << 0 >>

let h = - $(succ n)

let i = - $zero


let j = f $ $a

let k = a $$ $b

let l = ( $ )

let m = ( $$ )

let n = List.fold_left ( $ ) x [ $a; $b ]


let o = << a >> b

let p = f << a >> $b


let q = $f x

let r = $(f x) y

let s = $x.field

let t = $(record ()).field

let u = match $scrutinee with Some x -> $(some x) | None -> $none


$gen v = << << $(pair << 1 >> << 2 >>) >> >>

let w = $($(inner))


let x = $(y )

let y = $(  z)

let z = <<  w >>

let aa = << $(  bb) >>


let bb =
  << List.fold_left (fun acc x -> acc + x) 0 [1; 2; 3; 4; 5; 6; 7; 8; 9] >>

let cc =
  << if $condition then $(then_branch ()) else $(else_branch_with_a_name ()) >>

let dd = << let x = $(binding ()) in x + $(other_binding ()) + 1 >>


let ee = (<< 0 >> [@attr])

let ff = << 0 >> [@@item_attr]
