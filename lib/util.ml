open Base

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

module Int = struct
  let distance (x : int) (y : int) : int = Int.abs (x - y)
end

module List = struct
  module Int = struct
    type t = int list

    let sum xs = List.fold xs ~init:0 ~f:( + )
    let is_increasing xs = List.is_sorted xs ~compare:ascending
    let is_decreasing xs = List.is_sorted xs ~compare:descending
    let is_increasing_or_decreasing xs = is_increasing xs || is_decreasing xs
  end
end
