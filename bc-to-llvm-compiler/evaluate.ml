open Core
open Stdlib
open Types
open Helpers

(* ============================== evaluation in OCaml ============================== *)

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
    | ExprNone() -> (0.,ss)

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

(* takes a list of statements and evaluates them (global or function scope),returns new state *)
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
                    | Assign(_,_) -> (); ss1,fs
                    | Op1(op,_) -> (
                        match op with
                            | ("-"|"!") -> (
                                print_float flt;
                                Stdlib.print_string "\n";
                                ss1,fs
                            )
                            | _ -> ( (); ss1,fs )
                    )
                    | ExprNone() -> ( (); ss1,fs )
                    | _ -> (
                        print_float flt;
                        Stdlib.print_string "\n";
                        ss1,fs
                    )
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
                                                let _,ss4 = (evalExpr upd !ssr fs) in
                                                    ssr := ss4;
                                                    let res2,ss5 = (evalExpr cond !ssr fs) in
                                                        resr := res2;
                                                        ssr := ss5;
                                        with ContinueInProgress(ssCont) ->
                                            (* update ssr and eval the update condition again *)
                                            let _,ss6 = (evalExpr upd ssCont fs) in
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
    | PrintString(str) -> (
        Stdlib.print_string str; ss
    )
    | PrintExpr(e) -> (
        let res,ss1 = (evalExpr e ss fs) in
            Stdlib.print_float res; ss1
    )

(* primes and performs initial function call to eval program *)
let runCode(blk: block): unit =
    print_string "AST EVALUATION:\n====================================================\n";
    try 
        ignore(evalBlock blk [Stdlib.Hashtbl.create 10] (Stdlib.Hashtbl.create 10));
        print_string "====================================================\n"
    with
        | ReturnInProgress(_,_) -> raise(Failure "Return from main program.")
        | BreakInProgress(_)    -> raise(Failure "Break outside a for/while.")
        | ContinueInProgress(_) -> raise(Failure "Continue outside a for.")