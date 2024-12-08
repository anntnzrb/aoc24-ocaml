open Base

module Level = struct
  type t = int

  let are_adjacents l1 l2 =
    match Int.abs (l1 - l2) with 1 | 2 | 3 -> true | _ -> false
end

module Report = struct
  type t = Level.t list

  let is_adjacent_safe report : bool =
    report
    |> CCList.combine_shortest (List.tl_exn report)
    |> List.for_all ~f:(fun (x, y) -> Level.are_adjacents x y)

  let is_safe report : bool =
    is_adjacent_safe report && Util.List.Int.is_increasing_or_decreasing report
end

let parse_line line = line |> String.split ~on:' ' |> List.map ~f:Int.of_string
let input = Util.IO.read_input_day 2 ~sample:false

let part1 =
  input |> String.split_lines |> List.map ~f:parse_line
  |> List.filter ~f:Report.is_safe
  |> List.length |> Int.to_string
