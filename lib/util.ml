module IO = struct
  let read_file_as_string (filename : string) : string =
    try In_channel.with_open_text filename In_channel.input_all
    with Sys_error msg -> failwith @@ "Failed to read from file: " ^ msg

  let read_input_day (day : int) ~(sample : bool) : string =
    if day < 1 || day > 25 then failwith "Day must be between 1 and 25."
    else
      let suffix = if sample then "-sample" else "" in
      let filename = Printf.sprintf "inputs/day%02d%s.in" day suffix in
      read_file_as_string filename
end

module String = struct
  let mk_lines (s : string) : string list =
    s |> String.trim |> String.split_on_char '\n'
end

module Int = struct
  let distance (x : int) (y : int) : int = Int.abs (x - y)
end

module List = struct
  let is_pairwise_monotonic (cmp : 'a -> 'a -> bool) (xs : 'a list) : bool =
    let rec aux = function
      | [] | [ _ ] -> true
      | x :: y :: rest -> cmp x y && aux (y :: rest)
    in
    aux xs

  let sum (xs : int list) : int = List.fold_left ( + ) 0 xs
end
