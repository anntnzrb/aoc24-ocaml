open Base

(** The distance of two (2) lists is the absolute value of each element's
    difference *)
let calc_distance xs ys =
  List.map2_exn xs ys ~f:Util.Int.distance |> Util.List.Int.sum

let parse_line line =
  line |> String.split ~on:' '
  |> List.filter ~f:(fun s -> not (String.is_empty s))
  |> List.map ~f:Int.of_string

let input = Util.IO.read_input_day 1 ~sample:false

let part1 =
  input |> String.split_lines |> List.map ~f:parse_line |> List.transpose_exn
  |> List.map ~f:(List.sort ~compare:Int.compare)
  |> ( function
  | [ xs; ys ] -> calc_distance xs ys
  | _ -> failwith "Could not calculate distance" )
  |> Int.to_string
