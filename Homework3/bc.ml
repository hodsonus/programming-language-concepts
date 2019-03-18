open Core
open Stdlib

(*
why environment queue and not stack

how to enforce return type of tuple
if statement in test had a condition of "true"
*)

(*
TODO AT END
Write tests
Check to make sure input to fxns is the correct state
*)

(* ============================== types ============================== *)

type expr = (* a fragment of code *)
    | Num    of float
    | Var    of string
    | Op1    of string*expr
    | Op2    of string*expr*expr
    | Assign of string*expr
    | FCall  of string*expr list
    | None   of unit

type printElement =
    | String of string
    | Expr   of expr

type statement = (* a line of code *)
    | Expr     of expr
    | If       of expr*statement list*statement list
    | While    of expr*statement list
    | For      of expr*expr*expr*statement list
    | FDef     of string*string list*statement list
    | Return   of expr
    | Break    of unit
    | Continue of unit
    | Print    of printElement list
    | String   of string

type block = (* a block of code *)
    statement list

type fxndef = (* a function definition *)
    { name: string; blk:block; params:string list }

type vars = (* a variable store for a given scope *)
    (string,float)Stdlib.Hashtbl.t
type fxns = (* a global store for function definitions *)
    (string,fxndef)Stdlib.Hashtbl.t
type scopeStack = (* a stack maintaining variable store scopes *)
    (string,float)Stdlib.Hashtbl.t list

exception ReturnInProgress of float*scopeStack
exception BreakInProgress of scopeStack
exception ContinueInProgress of scopeStack

(* ============================== functions ============================== *)

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

(* performs a variable value lookup given a program state *)
let rec evalVar (v: string) (ss: scopeStack) : float =
    match List.length ss with
    | 0 -> raise(Failure "Illegal variable environment state.")
    | 1 -> ( (* in global scope *)
        let vs = List.hd ss in
            let res_opt = Stdlib.Hashtbl.find_opt vs v in
                match res_opt with
                | Some(res) -> res
                | None -> 0.
        )
    | _ -> ( (* not in global scope *)
        let vs = List.nth ss ((List.length ss)-1) in
            let res_opt = Stdlib.Hashtbl.find_opt vs v in
                match res_opt with
                | Some(res) -> res
                | None -> (
                    let globals = (List.hd ss)::[] in
                        evalVar v globals
                )
        )

(* performs an expression evaluation *)
let rec evalExpr (e: expr) (ss: scopeStack) (fs: fxns) (* : (float,scopeStack) *) =
    match e with
    | Num(flt) -> flt,ss
    | Var(str) -> (evalVar str ss),ss
    | Op1(op,ex) -> (
        match op with
        | "-" -> let v,ss1 = evalExpr ex ss fs in -.v,ss1
        | "!" -> let v,ss1 = evalExpr ex ss fs in float_of_bool(not(bool_of_float(v))),ss1
        | "++a" -> (
            match ex with
            | Var(vName) -> 
                let res = (evalVar vName ss) in
                    Stdlib.Hashtbl.replace (List.nth ss (List.length ss-1)) vName (res+.1.);
                    (res+.1.),ss
            | _ -> raise(Failure ("Operator " ^ op ^ "cannot be applied to the given expression."))
        )
        | "--a" -> (
            match ex with
            | Var(vName) ->
                let res = (evalVar vName ss) in
                    Stdlib.Hashtbl.replace (List.nth ss (List.length ss-1)) vName (res-.1.);
                    (res-.1.),ss
            | _ -> raise(Failure ("Operator " ^ op ^ "cannot be applied to the given expression."))
        )
        | "a++" -> (
            match ex with
            | Var(vName) ->
                let res = (evalVar vName ss) in
                    Stdlib.Hashtbl.replace (List.nth ss (List.length ss-1)) vName (res+.1.);
                    res,ss
            | _ -> raise(Failure ("Operator " ^ op ^ "cannot be applied to the given expression."))
        )
        | "a--" -> (
            match ex with
            | Var(vName) ->
                let res = (evalVar vName ss) in
                    Stdlib.Hashtbl.replace (List.nth ss (List.length ss-1)) vName (res-.1.);
                    res,ss
            | _ -> raise(Failure ("Operator " ^ op ^ "cannot be applied to the given expression."))
        )
        | _   -> raise(Failure ("Unknown unary operator `" ^ op ^ "`."))
        )
    | Op2(op,expr1,expr2) -> (
        match op with
        | "+"  -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (val1 +. val2),ss2
        )
        | "-"  -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (val1 -. val2),ss2
        )
        | "*"  -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (val1 *. val2),ss2
        )
        | "/"  -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (val1 /. val2),ss2
        )
        | "%"  -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (Core.Float.mod_float val1 val2),ss2
        )
        | "^"  -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (val1 ** val2),ss2
        )
        | "<=" -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (float_of_bool (val1 <= val2)),ss2
        )
        | "<"  -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (float_of_bool (val1 < val2)),ss2
        )
        | ">=" -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (float_of_bool (val1 >= val2)),ss2
        )
        | ">"  -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (float_of_bool (val1 > val2)),ss2
        )
        | "==" -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (float_of_bool (val1 = val2)),ss2
        )
        | "!=" -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (float_of_bool (val1 <> val2)),ss2
        )
        | "&&" -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (float_of_bool ((bool_of_float val1) && (bool_of_float val2))),ss2
        )
        | "||" -> (
            let val1,ss1 = (evalExpr expr1 ss fs) in
                let val2,ss2 = (evalExpr expr2 ss1 fs) in
                    (float_of_bool ((bool_of_float val1) || (bool_of_float val2))),ss2
        )
        | _    -> raise(Failure ("Unknown binary operator `" ^ op ^ "`."))
    )
    | Assign(vName,expr) -> (
        let vVal,ss1 = evalExpr expr ss fs in
            Stdlib.Hashtbl.replace (List.nth ss1 (List.length ss1-1)) vName vVal;
            vVal,ss1
    )
    | FCall(f,exprList) -> (
        match Stdlib.Hashtbl.find_opt fs f with
        | Some(fxn) -> evalFxn fxn exprList ss fs
        | None -> (
            match f with
            | "s"    -> (
                match List.length exprList = 1 with
                | true  -> let x,ss1 = evalExpr (List.hd exprList) ss fs in sin(x),ss1
                | false -> raise(Failure "Sine function takes one argument."))
            | "c"    -> (
                match List.length exprList = 1 with
                | true  -> let x,ss1 = evalExpr (List.hd exprList) ss fs in cos(x),ss1
                | false -> raise(Failure "Cosine function takes one argument."))
            | "e"    -> (
                match List.length exprList = 1 with
                | true  -> let x,ss1 = evalExpr (List.hd exprList) ss fs in exp(x),ss1
                | false -> raise(Failure "Exp function takes one argument."))
            | "l"    -> (
                match List.length exprList = 1 with
                | true  -> let x,ss1 = evalExpr (List.hd exprList) ss fs in log(x),ss1
                | false -> raise(Failure "Log function takes one argument."))
            | "sqrt" -> (
                match List.length exprList = 1 with
                | true  -> let x,ss1 = evalExpr (List.hd exprList) ss fs in sqrt(x),ss1
                | false -> raise(Failure "Sqrt function takes one argument."))
            | "read" -> (
                match List.length exprList = 0 with
                | true  -> ( let x = read_float() in x,ss )
                | false -> raise(Failure "Read function takes no arguments."))
            | _ -> raise(Failure ("Unknown function call to " ^ f ^ "."))
        )
    )
    | None() -> (0.,ss)

(* performs a function call given a program state and returns a value and new state *)
and evalFxn (fxn: fxndef) (el: expr list) (ss: scopeStack) (fs: fxns) (* : (float,scopeStack) *) =
    let table = Stdlib.Hashtbl.create 10 in (* instantiate local scope *)
        let ss1 = unpack_args table (fxn.params) el ss fs in
            let ss2 = ss1@[table] in (* add local scope to scope stack *)
                try (* call evalBlock to evaluate the body of the fxn. this throws (should) a return exception *)
                    let ss3,_ = evalBlock fxn.blk ss2 fs in
                        0.,(List.rev (List.tl (List.rev ss3))) (* pop local scope,no return encountered,return 0 *)
                with
                    | ReturnInProgress(flt,ssr) -> flt,(List.rev (List.tl (List.rev ssr))) (* pop local scope,return encountered -> return the ret val *)

(* recursively unpacks arguments into a new local scope for initializing function calls *)
and unpack_args (tbl: (string,float)Stdlib.Hashtbl.t) (params: string list) (el: expr list) (ss: scopeStack) (fs: fxns) : scopeStack =
    match (List.length params) = (List.length el) with
        | true -> (
            match (List.length el) with
                | 0 -> ss
                | _ -> (
                    let x,ss1 = evalExpr (List.hd el) ss fs in
                    Stdlib.Hashtbl.add tbl (List.hd params) x;
                    unpack_args tbl (List.tl params) (List.tl el) ss1 fs
                )
        )
        | false -> raise(Failure "Invalid number of arguments to custom function.")

(* takes a list of statements and evaluates them (global or function scope), returns new state *)
and evalBlock (blk: block) (ss: scopeStack) (fs: fxns) (* : scopeStack,fxns *) =
    match blk with
        | [] -> ss,fs
        | head::rest -> (
            let ss1,fs1 = evalStatement head ss fs in
                evalBlock rest ss1 fs1
        )

(* evaluates a single statement and updates the state *)
and evalStatement (s: statement) (ss: scopeStack) (fs: fxns) (* scopeStack,fxns *) =
    match s with
        | Expr(e) -> (
            let flt,ss1 = evalExpr e ss fs in
                match e with
                    | Assign(_,_) ->
                        ();
                        ss1,fs
                    | _ ->
                        print_float flt;
                        ss1,fs
        )
        | If(e,blkT,blkF) -> (
            match contains_fxndef blkT || contains_fxndef blkF with
                | true -> raise(Failure "Error defining function in if/else.")
                | false -> (
                    let flt,ss1 = evalExpr e ss fs in
                        match bool_of_float(flt) with
                            | true -> evalBlock blkT ss1 fs
                            | false -> evalBlock blkF ss1 fs
                )
        )
        | While(cond,blk) -> (
            match contains_fxndef blk with
                | true -> raise(Failure "Error defining function in while.")
                | false -> (
                    try
                        let ssr = ref ss in
                            let res,_ = (evalExpr cond !ssr fs) in
                                let resr = ref res in
                                    while bool_of_float(!resr) do
                                        let ss2,_ = evalBlock blk !ssr fs in
                                            ssr := ss2;
                                            let res2,ss3 = (evalExpr cond !ssr fs) in
                                                resr := res2;
                                                ssr := ss3;
                                    done;
                                    !ssr,fs
                    with BreakInProgress(ss) -> ss,fs
                )
        )
        | For(init,cond,upd,blk) -> (
            match contains_fxndef blk with
                | true -> raise(Failure "Error defining function in for.")
                | false -> (
                    try
                        let _,ss2 = evalExpr init ss fs in
                        let ssr = ref ss2 in (* a mutable scope stack for use throughout the loop *)
                            let res,_ = (evalExpr cond !ssr fs) in
                                let resr = ref res in (* a mutable condition result for the loop *)
                                    while bool_of_float(!resr) do
                                        try
                                            let ss3,_ = evalBlock blk !ssr fs in
                                                ssr := ss3;
                                                let res2,ss4 = (evalExpr cond !ssr fs) in
                                                    resr := res2;
                                                    ssr := ss4;
                                                    let _,ss5 = (evalExpr upd !ssr fs) in
                                                        ssr := ss5;
                                        with ContinueInProgress(ss1) ->
                                            (* update ssr and eval the update condition again *)
                                            let _,ss6 = (evalExpr upd ss1 fs) in
                                                ssr := ss6;
                                    done;
                                    !ssr,fs
                    with BreakInProgress(ss1) -> ss1,fs
                )
        )
        | FDef(f,params,blk) -> (
            match contains_fxndef blk with
            | true -> raise(Failure "Error defining function in \"define function\" statement.")
            | false -> (
                match List.length ss with
                    | 0 -> raise(Failure("Global scope not defined."))
                    | 1 ->
                            let newFxnDef = { name=f; blk=blk; params=params } in
                                (Stdlib.Hashtbl.replace fs f newFxnDef);
                                ss,fs
                    | _ -> raise(Failure("Function definition not in the global scope."))
            )
        )
        | Return(e) ->
            let res,ss1 = (evalExpr e ss fs) in
                raise(ReturnInProgress(res,ss1))
        | Break() -> raise(BreakInProgress(ss))
        | Continue() -> raise(ContinueInProgress(ss))
        | Print(elements) -> (print_printElement_list elements ss fs),fs
        | String(str) -> print_string str; ss,fs

and print_printElement_list (elements: printElement list) (ss: scopeStack) (fs: fxns): scopeStack = 
    match elements with
    | hd::tl ->
        let ss1 = print_printElement hd ss fs in
            print_printElement_list tl ss1 fs
    | [] -> ss

and print_printElement (element: printElement) (ss: scopeStack) (fs: fxns): scopeStack =
    match element with
    | String(str) -> (
        Stdlib.print_string str;
        ss
    )
    | Expr(e) -> (
        let res,ss1 = (evalExpr e ss fs) in
            Stdlib.print_float res;
            ss1
    )

(* primes and performs initial function call to eval program *)
let runCode(blk: block): unit =
    try ignore(evalBlock blk [Stdlib.Hashtbl.create 10] (Stdlib.Hashtbl.create 10)); ()
    with
        | ReturnInProgress(_,_) -> raise(Failure "Return from main program.")
        | BreakInProgress(_) -> raise(Failure "Break outside a for/while.")
        | ContinueInProgress(_) -> raise(Failure "Continue outside a for.")

(* ============================== tests ============================== *)

(* ------------------------------ test 0 ------------------------------ *)
(* provided, adapted to new interface *)
let%expect_test "evalNum" =
    let flt,_ = evalExpr (Num 10.0) [Stdlib.Hashtbl.create 10] (Stdlib.Hashtbl.create 10) in
    flt |>
    printf "%F";
    [%expect {| 10. |}]

(*
(* ------------------------------ test 1 ------------------------------ *)
(* provided, adapted to new interface *)
(* Sample Program 1
v = 10;
v
*)
let%expect_test "p1" =
    let p1: block = [
        Assign("v",Num(1.0));
        Expr(Var("v"))
    ] in
    runCode p1 [Stdlib.Hashtbl.create 10] (Stdlib.Hashtbl.create 10);
    [%expect {| 1. |}]

(* ------------------------------ test 2 ------------------------------ *)
(* provided, adapted to new interface *)
(* Sample Program 2
v = 1.0;
if (v>10.0)
  v = v + 1.0
else
  for(i=2.0; i<10.0; i++)
    v = v * i
v
*)
let%expect_test "p1" =
    let p2: block = [
        Assign("v",Num(1.0));
        If(Op2(">",Var("v"),Num(10.0)),
            [Assign("v",Op2("+",Var("v"),Num(1.0)))],
            [For(Assign("i",Num(2.0)),Op2("<",Var("i"),Num(10.0)),Expr(Op1("++a",Var("i"))),
            [Assign("v",Op2("*",Var("v"),Var("i")))]
            )]
        );
        Expr(Var("v"))
    ] in
    runCode p2 [];
    [%expect {| 3628800. |}]

(* ------------------------------ test 3 ------------------------------ *)
(* provided, adapted to new interface *)
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
let%expect_test "p3" =
    let p3: block = [
    FDef("f",["x"],[
        If(Op2("<",Var("x"),Num(1.0)),
        [Return(Num(1.0))],
        [Return(
            Op2("+",
            FCall("f",[Op2("-",Var("x"),Num(1.0))]),
            FCall("f",[Op2("-",Var("x"),Num(1.0))])
            )
        )]
        )]
    );
    Expr(FCall("f",[Num(3.0)]));
    Expr(FCall("f",[Num(5.0)]));
    ] in
    runCode p3 [];
    [%expect {| 2. 5. |}]
*)

(* ------------------------------ test 3 ------------------------------ *)

let%expect_test "bool_of_float-float_of_bool" =
    let ab, bb, cb = bool_of_float(-.1.), bool_of_float(0.), bool_of_float(1.) in
    let af, bf = float_of_bool(true), float_of_bool(false) in
    ab |> printf "%B "; bb |> printf "%B "; cb |> printf "%B ";
    af |> printf "%F "; bf |> printf "%F ";
    [%expect {| true false true 1. 0. |}]

let%expect_test "contains_fxndef" =
    let p_no_fdef: block = [ Expr(Assign("v",Num(1.0))) ] in
    let p_fdef: block = [ FDef("",[],[]) ] in
    let p_x_fdef: block = [ Expr(Assign("v",Num(1.0))); FDef("",[],[]) ] in
    let p_fdef_x: block = [ FDef("",[],[]); Expr(Assign("v",Num(1.0))) ] in
    let p_x_fdef_x: block =
        [ Expr(Assign("v",Num(1.0))); FDef("",[],[]); Expr(Assign("v",Num(1.0))); ] in
    contains_fxndef p_no_fdef |> printf "%B ";
    contains_fxndef p_fdef |> printf "%B ";
    contains_fxndef p_x_fdef |> printf "%B ";
    contains_fxndef p_fdef_x |> printf "%B ";
    contains_fxndef p_x_fdef_x |> printf "%B ";
    [%expect {| false true true true true |}]

let%expect_test "evalVar" =
    let ss = [] in
    let global_ht = Stdlib.Hashtbl.create 10 in
        Stdlib.Hashtbl.add global_ht "x" 1.;
        Stdlib.Hashtbl.add global_ht "y" 2.;
    let mid_ht = Stdlib.Hashtbl.create 10 in
        Stdlib.Hashtbl.add mid_ht "x" 3.;
        Stdlib.Hashtbl.add mid_ht "z" 4.;
    let top_ht = Stdlib.Hashtbl.create 10 in
        Stdlib.Hashtbl.add top_ht "y" 5.;
        Stdlib.Hashtbl.add top_ht "z" 6.;
    try ignore(evalVar "" ss)
    with Failure(_) -> printf "fail ";
    let ss1 = ss@[global_ht] in
        evalVar "x" ss1 |> printf "%F ";
        evalVar "y" ss1 |> printf "%F ";
        evalVar "z" ss1 |> printf "%F ";
    let ss2 = ss1@[mid_ht] in
        evalVar "x" ss2 |> printf "%F ";
        evalVar "y" ss2 |> printf "%F ";
        evalVar "z" ss2 |> printf "%F ";
    let ss3 = ss2@[top_ht] in
        evalVar "x" ss3 |> printf "%F ";
        evalVar "y" ss3 |> printf "%F ";
        evalVar "z" ss3 |> printf "%F ";
    [%expect {| fail 1. 2. 0. 3. 2. 4. 1. 5. 6. |}]
