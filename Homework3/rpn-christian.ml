type rpn_t =
  | Rpn of string
  | RpnErr of string

type opr_t =
  | Op of (float->float->float)
  | OpErr of string

type exp_t =
  | Exp of float
  | ExpErr of string


let rpn (expr: string) : rpn_t =
  
  let rec step (args: string list) (stk: float list) : exp_t =
    
    let check_op (op: string) : opr_t =
      match op with
        | "+"->Op(+.) | "-"->Op(-.) | "*"->Op( *.) | "/"->Op(/.) | "^"->Op( **)
        | _ -> OpErr("invalid token found in rpn exp") in
    
    match args with
    | h::t -> (
      match float_of_string_opt(h) with
        | Some(f) -> step t (f::stk)
        | None -> (
          match check_op(h) with
            | Op(o) -> (
              match stk with
                | h1::h2::t2 -> step t (o h2 h1::t2)
                | _ -> (
                  match args with
                    | [] -> Exp(List.hd stk)
                    | _ -> ExpErr("excess operators or insufficient operands")
                )
            )
            | OpErr(e) -> ExpErr(e)
        )
    )
    | [] -> (
      match stk with
        | _::[] -> Exp(List.hd stk)
        | _ -> ExpErr("insufficient operators or excess operands")
    ) in
  
  match step (Str.split(Str.regexp " +") expr) [] with
    | Exp(ro) -> Rpn(string_of_float(ro))
    | ExpErr(re) -> RpnErr(re)


let rec main() =
  print_string("Enter rpn exp or `q` to quit: ");
  let in_str = String.trim(read_line()) in
  match in_str with
    | "" -> print_string("\n"); main()
    | "q" -> print_string("quit.\n")
    | _ -> (
      match rpn(in_str) with
        | Rpn(f) -> print_string(in_str^" = "^f^"\n"); main()
        | RpnErr(s) -> print_string(in_str^" :: "^s^"\n"); main()
    )


;; main() ;;
