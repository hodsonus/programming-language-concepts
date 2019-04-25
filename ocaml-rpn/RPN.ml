(* John Hodson
 * University of Florida
 * COP4020 - Programming Language Concepts
 * Professor Alin Dobra
 * RPN Calculator
 *)

type token = 
    | Num of float
    | Op of string
    | TError of string

type state =
    | MyStack of float list
    | SError of string

type value = 
    | Val of float
    | VError of string

(* val toToken : string -> token = <fun> *)
let toToken (str: string) : token =
    match str with
    | "+" | "-" | "*" | "/" | "^" -> Op(str)
    | _ -> let f = float_of_string_opt(str) in 
        match f with 
        | Some(flt) -> Num(flt)
        | None -> TError("Expression contains an invalid token.")

(* val evalOp : float -> string -> float -> float = <fun> *)
let evalOp (a: float) (op: string) (b: float) : float = 
    match op with
        | "+" -> a +. b
        | "-" -> a -. b
        | "*" -> a *. b
        | "/" -> a /. b
        | "^" -> a ** b
        |  _  -> 0. (* this case will never occur *)

(* val nextState : state -> token -> state = <fun> *)
let nextState (st:state) (t: token) : state = 
    match st with
    | SError(str) -> st
    | MyStack(lst) -> 
        match t with 
        | Num(f) -> MyStack(f :: lst)
        | Op(op) -> (
            match lst with
            | b::a::tail -> MyStack( (evalOp a op b) :: tail)
            | _ -> SError("Invalid RPN expression, not enough operands.")
        )
        | TError(s) -> SError(s);;

(* val extractVal : state -> value = <fun> *)
let extractVal (endState:state) : value = 
    match endState with
        | SError(str) -> VError(str)
        | MyStack(stck) -> 
            match stck with
                | a::[] -> Val(a)
                | _ -> VError("Invalid RPN expression, too many elements on the stack.");;

(* val processRPN : string -> value = <fun> *)
let processRPN str =
    str |>
    String.split_on_char ' ' |>
    List.map toToken |>
    List.fold_left nextState (MyStack([])) |>
    extractVal;;

(* val print_value : value -> unit = <fun> *)
let print_value (endValue:value) = 
    match endValue with
        | Val(flt) -> print_float flt
        | VError(str) -> print_string str;;

(* val loop : unit -> unit = <fun> *)
let rec loop () =
    let str = read_line() in
        match str with
            | "q" -> ()
            | _ -> (
                print_value (processRPN str);
                print_newline();
                loop();
            );;

loop();