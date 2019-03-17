open Core
open Stdlib

(*
TODO: questions
why environment queue and not stack
how to handle pre/post inc/dec ops
how to handle mod
how to read command line input

is multiple params better than product type breakdown
*)

(* ============================== types ============================== *)

type expr = (* a fragment of code evaluable to float, no state change *)
| Num   of float
| Var   of string
| Op1   of string*expr
| Op2   of string*expr*expr

type statement = (* a line of code, possible state change *)
| Expr     of expr
| Assign   of string*expr
| If       of expr*statement list*statement list
| While    of expr*statement list
| For      of statement*expr*statement*statement list
| FDef     of string*string list*statement list
| FCall    of string*expr list
| Return   of expr
| Break    of unit
| Continue of unit
type block = (* a block of code, composition of statements *)
(* | Block of *) statement list

type vars = (* a variable store for a given scope *)
| Vars of (string, float)Hashtbl.t
type fxns = (* a global store for function definitions *)
(*| Fxns of *) (string, block)Hashtbl.t
type scopeStack = (* a stack maintaining variable store scopes *)
(* | ScopeStack of *) vars list

(* ============================== functions ============================== *)

(* converts a float to a bool *)
let bool_of_float (flt: float) : bool =
    match flt with | 0. -> false | _ -> true

(* converts a bool to a float *)
let float_of_bool (value: bool) : float =
    match value with | true -> 1. | false -> 0.

(* performs a variable value lookup given a program state *)
let rec evalVar (v: string) (ss: scopeStack) : float =
    match List.length ss with
    | 0 -> raise(Failure "Illegal variable environment state.")
    | 1 -> ( (* in global scope *)
        match List.hd ss with
        | Vars(vs) -> (
            match Hashtbl.find_opt vs v with
            | float -> (Hashtbl.find vs v) (* look in local (tail) *)
            | None  -> ( (* call to look in global scope *)
                let globalSS = Vars(vs)::[] in
                evalVar v globalSS
                )
            )
        )
    | _ -> ( (* not in global scope *)
        match (List.nth ss ((List.length ss)-1)) with
        | Vars(vs) -> (
            match Hashtbl.find_opt vs v with
            | float -> Hashtbl.find vs v (* look in global (head) *)
            | None  -> 0.
            )
        )

(* performs an expression evaluation given a program state *)
let rec evalExpr (e: expr) (ss: scopeStack) (fs: fxns) : float =
    match e with
    | Num(flt) -> flt
    | Var(str) -> evalVar str ss
    | Op1(op, ex) -> (
        match op with
        | "-" -> -.(evalExpr ex ss fs)
        | "!" -> float_of_bool(not(bool_of_float(evalExpr ex ss fs)))
        | _   -> raise(Failure ("Unknown unary operator `" ^ op ^ "`."))
        )
    | Op2(op, expr1, expr2) -> (
        match op with
        | "+"  -> ((evalExpr expr1 ss fs) +. (evalExpr expr2 ss fs))
        | "-"  -> ((evalExpr expr1 ss fs) -. (evalExpr expr2 ss fs))
        | "*"  -> ((evalExpr expr1 ss fs) *. (evalExpr expr2 ss fs))
        | "/"  -> ((evalExpr expr1 ss fs) /. (evalExpr expr2 ss fs))
        | "^"  -> ((evalExpr expr1 ss fs) ** (evalExpr expr2 ss fs))
        | "<=" -> float_of_bool ((evalExpr expr1 ss fs) <= (evalExpr expr2 ss fs))
        | "<"  -> float_of_bool ((evalExpr expr1 ss fs) <  (evalExpr expr2 ss fs))
        | ">=" -> float_of_bool ((evalExpr expr1 ss fs) >= (evalExpr expr2 ss fs))
        | ">"  -> float_of_bool ((evalExpr expr1 ss fs) >  (evalExpr expr2 ss fs))
        | "==" -> float_of_bool ((evalExpr expr1 ss fs) =  (evalExpr expr2 ss fs))
        | "!=" -> float_of_bool ((evalExpr expr1 ss fs) <> (evalExpr expr2 ss fs))
        | "&&" -> float_of_bool (
            (bool_of_float (evalExpr expr1 ss fs)) && (bool_of_float (evalExpr expr2 ss fs)))
        | "||" -> float_of_bool (
            (bool_of_float (evalExpr expr1 ss fs)) || (bool_of_float (evalExpr expr2 ss fs)))
        | "%"  -> float_of_int ( (* TODO verify casting solution is acceptable *)
            int_of_float(evalExpr expr1 ss fs) % int_of_float(evalExpr expr1 ss fs))
        | _    -> raise(Failure ("Unknown binary operator `" ^ op ^ "`."))
        )

(*  *)
let evalBlock(blk: block) (ss: scopeStack) (fs: fxns) : unit =
  (* TODO *)
  (* create new environment *)
  (* user fold_left *)
  (* pop the local environment *)
  print_endline "Not implemented"

(*  *)
let evalStatement (s: statement) (ss: scopeStack) (fs: fxns) : scopeStack =
    match s with
    | Expr(e) -> ( let ee = evalExpr e ss fs in ss ) (* TODO fix all these bullshit lines *)
    | Assign(v, e) -> ( (*let ee = Hashtbl.replace (List.nth ss (List.length ss-1)) (evalExpr e ss fs) in*) ss )
    | If(e, blkT, blkF) ->
        let x = (
        match bool_of_float(evalExpr e ss fs) with
        | true -> evalBlock blkT ss fs; ss
        | false -> evalBlock blkF ss fs; ss
        ) in ss
    | While(e, blk) -> ss
    | For(init, cond, term, blk) -> ss
    | FDef(f, params, blk) -> ss
    | FCall(f, exprList) -> (
        match Hashtbl.find_opt fs f with
        | block -> evalBlock (Hashtbl.find fs f) ss fs; ss
        | None -> (
            match f with (* TODO *)
            | "s"    -> ( match List.length exprList == 1 with
                    | true  -> let x = sin(evalExpr (List.hd exprList) ss fs) in ss
                    | false -> raise(Failure "Sine function takes one argument."))
            | "c"    -> ( match List.length exprList == 1 with
                    | true  -> let x = cos(evalExpr (List.hd exprList) ss fs) in ss
                    | false -> raise(Failure "Cosine function takes one argument."))
            | "e"    -> ( match List.length exprList == 1 with
                    | true  -> let x = exp(evalExpr (List.hd exprList) ss fs) in ss
                    | false -> raise(Failure "Exp function takes one argument."))
            | "l"    -> ( match List.length exprList == 1 with
                    | true  -> let x = log(evalExpr (List.hd exprList) ss fs) in ss
                    | false -> raise(Failure "Log function takes one argument."))
            | "sqrt" -> ( match List.length exprList == 1 with
                    | true  -> let x = sqrt(evalExpr (List.hd exprList) ss fs) in ss
                    | false -> raise(Failure "Sqrt function takes one argument."))
            | "read" -> ( match List.length exprList == 0 with
                    | true  -> ( let x = read_float() in ss )
                    | false -> raise(Failure "Read function takes no arguments."))
            | _ -> raise(Failure ("Unknown function call to " ^ f ^ "."))
            )
        )
    | Return(e) -> ss
    | Break() -> ss
    | Continue() -> ss
    | _ -> ss (*ignore *)

(*  *)
let runCode(blk: block): unit = ()
  (*evalBlock(param1, param2, ...)*)

(* ============================== tests ============================== *)

(* ------------------------------ test 0 ------------------------------ *)
let%expect_test "evalNum" =
  evalExpr (Num 10.0) [] |>
  printf "%F";
  [%expect {| 10. |}]

(* ------------------------------ test 1 ------------------------------ *)
(* Sample Program 1
v = 10;
v
*)
let p1: block = [
  Assign("v", Num(1.0));
  Expr(Var("v"))
]
let%expect_test "p1" =
  evalBlock p1 []; (* TODO use runCode? *)
  [%expect {| 1. |}]

(* ------------------------------ test 2 ------------------------------ *)
(* Sample Program 2
v = 1.0;
if (v>10.0)
  v = v + 1.0
else
  for(i=2.0; i<10.0; i++)
    v = v * i
v
*)
let p2: block = [
  Assign("v", Num(1.0));
  If(Op2(">", Var("v"), Num(10.0)),
    [Assign("v", Op2("+", Var("v"), Num(1.0)))],
    [For(Assign("i", Num(2.0)), Op2("<", Var("i"), Num(10.0)), Expr(Op1("++a", Var("i"))),
      [Assign("v", Op2("*", Var("v"), Var("i")))]
    )]
  );
  Expr(Var("v"))
]
let%expect_test "p1" =
  evalBlock p2 []; (* TODO use runCode? *)
  [%expect {| 3628800. |}]

(* ------------------------------ test 3 ------------------------------ *)
(* Fibbonaci Sequence
define f(x) {
    if (x<1.0)
        return (1.0)
    else
        return (f(x-1)+f(x-2))
}
f(3)
f(5)
*)
let p3: block = [
  FDef("f", ["x"], [
    If(Op2("<", Var("x"), Num(1.0)),
      [Return(Num(1.0))],
      [Return(
        Op2("+",
          FCall("f", [Op2("-", Var("x"), Num(1.0))]),
          FCall("f", [Op2("-", Var("x"), Num(1.0))])
        )
      )]
    )]
  );
  Expr(FCall("f", [Num(3.0)]));
  Expr(FCall("f", [Num(5.0)]));
]
let%expect_test "p3" =
  evalBlock p3 []; (* TODO use runCode? *)
  [%expect {| 2. 5. |}]
