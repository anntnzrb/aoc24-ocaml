(** Transposes a 2x2 matrix. No folding, just tuples and [List.split] *)
let transpose2x2 matrix =
  matrix
  |> List.map (function
       | [ a; b ] -> (a, b)
       | _ -> failwith "Each sublist must contain exactly 2 elements")
  |> List.split
  |> fun (a, b) -> [ a; b ]

(** The distance of two (2) lists is the absolute value of each element's
    difference *)
let calc_distance xs ys = List.map2 Util.Int.distance xs ys |> Util.List.sum

let part1 : string =
  let input = Util.IO.read_input_day 1 ~sample:false in

  let open List in
  let parse_line line =
    line |> String.split_on_char ' ' |> filter (( <> ) "") |> map int_of_string
  in
  input |> Util.String.mk_lines |> map parse_line |> transpose2x2
  |> map @@ sort Int.compare
  |> ( function
  | [ xs; ys ] -> calc_distance xs ys
  | _ -> failwith "Could not calculate distance" )
  |> string_of_int
