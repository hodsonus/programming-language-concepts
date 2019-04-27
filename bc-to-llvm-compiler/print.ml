open Types

(* ============================== print interpreted AST ============================== *)

let rec print_string_list (sl: string list): unit =
    match sl with
    | [] -> ()
    | hd::[] -> (
        print_string (hd^",");
        ()
    )
    | hd::tl -> (
        print_string (hd^",");
        print_string_list tl;
        ()
    )

let rec print_expr (e: expr): unit = 
    match e with
    | Num(flt) -> (
        print_float flt;
        ()
    )
    | Var(str) -> (
        print_string str;
        ()
    )
    | Op1(str, e2) -> (
        match str with
        | "a++"|"a--" -> (
            print_expr e2;
            print_string str;
            ()
        )
        | _ -> (
            print_string str;
            print_expr e2;
            ()
        )
    )
    | Op2(str,e2,e3) -> (
        print_expr e2;
        print_string str;
        print_expr e3;
        ()
    )
    | Assign (str, e2) -> (
        print_string (str^"=");
        print_expr e2;
        ()
    )
    | FCall(str,eList) -> (
        print_string str;
        print_string "(";
        print_string ")";
        ()
    )
    | ExprNone() -> (
        print_string "()";
        ()
    )

and print_expr_list (el: (expr list)): unit =
    match el with
    | [] -> ()
    | hd::[] -> (
        print_expr hd;
        ()
    )
    | hd::tl -> (
        print_expr hd;
        print_string ",";
        print_expr_list tl
    )

let rec print_printElement_list_interp (pel: printElement list): unit = 
    match pel with
    | [] -> ()
    | hd::[] -> (
        print_printElement_interp hd;
        print_string "\n"
    )
    | hd::tl -> (
        print_printElement_interp hd;
        print_string ",";
        print_printElement_list_interp tl
    )

and print_printElement_interp (pe: printElement): unit = 
    match pe with
    | PrintString(str) -> (
        print_string str
    )
    | PrintExpr(e) -> (
        print_expr e
    )

let rec print_statement_list (blk: block): unit =
    match blk with
    | [] -> ();
    | hd::tl -> (
        print_statement hd;
        print_statement_list tl
    )

and print_statement (s: statement): unit = 
    match s with
    | Expr(e) -> (
        print_expr e;
        print_string ";\n";
        ()
    )
    | If(e,blkT,blkF) -> (
        print_string "if (";
        print_expr e;
        print_string ") {\n";
        print_statement_list blkT;
        print_string "\n}\nelse {\n";
        print_statement_list blkF;
        print_string "\n}\n";
        ()
    )
    | While(cond,blk) -> (
        print_string "while (";
        print_expr cond;
        print_string ") {\n";
        print_statement_list blk;
        print_string "\n}\n";
        ()
    )
    | For(init,cond,upd,blk) ->(
        print_string "for (";
        print_expr init;
        print_string ",";
        print_expr cond;
        print_string ",";
        print_expr upd;
        print_string ") {\n";
        print_statement_list blk;
        print_string "\n}\n";
        ()
    )
    | FDef(f,params,blk) -> (
        print_string ("define "^f^"(");
        print_string_list params;
        print_string ") {\n";
        print_statement_list blk;
        print_string "\n}\n";
        ()
    )
    | Return(e) -> (
        print_string "return ";
        print_expr e;
        print_string "\n";
        ()
    )
    | Break() -> (
        print_string "break\n";
        ()
    )
    | Continue() -> (
        print_string "continue\n";
        ()
    )
    | Print(elements) -> (
        print_string "print ";
        print_printElement_list_interp elements
    )
    | String(str) -> (
        print_string str;
        print_string "\n";
        ()
    )

let printCode (blk: block): block =
    print_string "INTERPRETED AST:\n====================================================\n";
    print_statement_list blk;
    print_string "====================================================\n\n";
    blk