open Types

(* converts a float to a bool *)
let bool_of_float (flt: float) : bool =
    match flt with | 0. -> false | _ -> true

(* converts a bool to a float *)
let float_of_bool (value: bool) : float =
    match value with | true -> 1. | false -> 0.

(* checks whether a block contains a function definition *)
let rec contains_fxndef (blk: block) : bool =
    match blk with
        | hd::tl -> (
            match hd with
                | FDef(_,_,_) -> true
                | _ -> contains_fxndef tl
        )
        | [] -> false