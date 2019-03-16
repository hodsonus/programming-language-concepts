(* includes *)
open Core.Std


(* types *)
type sExpr =
  | Atom of string
  | List of sExpr list

type expr =
  | Num of float
  | Var of string
  | Op1 of string*expr
  | Op2 of string*expr*expr
  | Fct of string*expr list

type statement =
  | Assign of string*expr
  | Return of expr
  | Expr of expr
  | If of expr*statement list * statement list
  | While of expr*statement list
  | For of statement*expr*statement*statement list
  | FctDef of string * string list * statement list
  | Break of ()
  | Continue of ()

type block = statement list

type env = N of float (* TODO *)

type envStack = env list


(* functions *)
let varEval (_v: string) (_q:envStack): float  =
  (* TODO *)
  0.0

  (* TODO *)
let evalExpr (_e: expr) (_q:envStack): float =
  match _e with
    | Num(flt) ->
    | Var(str) ->
    | Op1(uniOp) ->
    | Op2(binOp) ->
    | Fct(fctCall) ->

let evalCode (_code: block) (_q:envStack): unit =
  (* TODO *)
  (* create new environment *)
  (* user fold_left  *)
  (* pop the local environment *)
  print_endline "Not implemented"

let evalStatement (s: statement) (q:envStack): envStack =
  match s with
    | Assign(_v, _e) -> (* eval e and store in v *) q
    | If(e, codeT, codeF) ->
      let cond = evalExpr e q in
        if(cond>0.0) then
          evalCode codeT q
        else
          evalCode codeF q
        ;q
      | _ -> q (*ignore *)

let runCode(code: block): () =
  evalCode(param1, param2, ...)


(* tests *)
let%expect_test "evalNum" =
  evalExpr (Num 10.0) [] |>
  printf "%F";
  [%expect {| 10. |}]

(*v = 10; v // display v *)
let p1: block = [
  Assign("v", Num(1.0));
  Expr(Var("v"))
]
let%expect_test "p1" =
  runCode p1 [];
  [%expect {| 1. |}]

(* Sample Program
v = 1.0;
if (v>10.0) then
  v = v + 1.0
else
  for(i=2.0; i<10.0; i++) {
    v = v * i
  }
v // display v
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
  runCode p2 [];
  [%expect {| 3628800. |}]

(* Fibbonaci Sequence
define f(x) {
    if (x<1.0) then
        return (1.0)
    else
        return (f(x-1)+f(x-2))
}
f(3)
f(5)
*)
let p3: block = [
  FctDef("f", ["x"], [
    If(Op2("<", Var("x"), Num(1.0)),
      [Return(Num(1.0))],
      [Return(
        Op2("+",
          Fct("f", [Op2("-", Var("x"), Num(1.0))]),
          Fct("f", [Op2("-", Var("x"), Num(1.0))])
        )
      )]
    )]
  );
  Expr(Fct("f", [Num(3.0)]));
  Expr(Fct("f", [Num(5.0)]));
]
let%expect_test "p3" =
  runCode p3 [];
  [%expect {| 2. 5. |}]