module Level = struct
  type t = int

  let check_safety (l1 : t) (l2 : t) : bool =
    match abs (l1 - l2) with 1 | 2 | 3 -> true | _ -> false

  let rec check_safety_all = function
    | [] | [ _ ] -> true
    | a :: b :: rest -> check_safety a b && check_safety_all (b :: rest)
end

module Report = struct
  type t = Level.t list

  let is_safe (report : t) : bool =
    let open Util.List in
    (is_pairwise_monotonic (fun x y -> y >= x) report
    || is_pairwise_monotonic (fun x y -> x >= y) report)
    && Level.check_safety_all report
end

let parse_line (line : string) =
  line |> String.split_on_char ' ' |> List.map int_of_string

let input : string = Util.IO.read_input_day 2 ~sample:false

let part1 =
  input |> Util.String.mk_lines |> List.map parse_line
  |> List.filter Report.is_safe |> List.length |> string_of_int
