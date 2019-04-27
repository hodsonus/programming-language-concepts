open Types

(* ============================== generate LLVM IR ============================== *)

(* type expr = (* a fragment of code *)
    | Num    of float
    | Var    of string
    | Op1    of string*expr
    | Op2    of string*expr*expr
    | Assign of string*expr
    | FCall  of string*expr list
    | ExprNone   of unit *)

let rec generate_expr (e: expr): unit =
    match e with
    | Num(flt) -> (
        () (* TODO *)
    )
    | Var(str) -> (
        () (* TODO *)
    )
    | Op1(op, e1) -> (
        () (* TODO *)
    )
    | Op2(op, e1, e2) -> (
        () (* TODO *)
    )
    | Assign(str, e1) -> (
        () (* TODO *)
    )
    | FCall(str, el) -> (
        () (* TODO *)
    )
    | ExprNone() -> (
        () (* TODO *)
    )

and generate_expr_list (el: expr list): unit =
    match el with
    | [] -> ()
    | hd::tl -> (
        generate_expr hd;
        generate_expr_list tl
    )

(* type statement = (* a line of code *)
    | Expr     of expr
    | If       of expr*statement list*statement list
    | While    of expr*statement list
    | For      of expr*expr*expr*statement list
    | FDef     of string*string list*statement list
    | Return   of expr
    | Break    of unit
    | Continue of unit
    | Print    of printElement list
    | String   of string *)

let rec generate_statement (s: statement): unit =
    match s with
    | Expr(e) -> (
        () (* TODO *)
    )
    | If(cond, blkT, blkF) -> (
        () (* TODO *)
    )
    | While(cond, blk) -> (
        () (* TODO *)
    )
    | For(init,cond,upd,blk) -> (
        () (* TODO *)
    )
    | FDef(f,params,blk) -> (
        () (* TODO *)
    )
    | Return(e) -> (
        () (* TODO *)
    )
    | Break() -> (
        () (* TODO *)
    )
    | Continue() -> (
        () (* TODO *)
    )
    | Print(elements) -> (
        () (* TODO *)
    )
    | String(str) -> (
        () (* TODO *)
    )

and generate_statement_list (sl: statement list): unit =
    match sl with
    | [] -> ()
    | hd::tl -> (
        generate_statement hd;
        generate_statement_list tl
    )

let generateCode (blk: block): unit =
    generate_statement_list blk