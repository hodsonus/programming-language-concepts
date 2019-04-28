open Types
open Llvm
open PassManager

(* ============================== generate LLVM IR ============================== *)

let context = global_context ()
let the_module = create_module context "my cool jit"
let builder = builder context
let named_values:(string, llvalue) Hashtbl.t = Hashtbl.create 10
let double_type = double_type context

type proto = Prototype of string * string list
type func = Fxn of proto * statement list

let rec generate_expr (e: expr): Llvm.llvalue =
    match e with
    | Num(flt) -> (
        const_float double_type flt
    )
    | Var(vName) -> (
        (* If we cannot find it, then it is 0 (bc's behavior) *)
        (try Hashtbl.find named_values vName with
        | Not_found -> (const_float double_type 0.0))
    )
    | Op1(op, e2) -> (
        let e2_val = generate_expr e2 in
            match op with
            | "-" -> (
                build_fneg e2_val "negtmp" builder
            )
            | "!" -> (
                (* if its not equal to 0, then its 1. if its equal to 0, then its 0. this matches bc's bhv *)
                (* then take this value and 'not' it *)
                let bool_res = build_fcmp Fcmp.Une e2_val (const_float double_type 0.0) "cmptmp" builder in
                    let not_res = build_not bool_res "nottmp" builder in
                        build_uitofp not_res double_type "booltmp" builder
            )
            | "++a" -> (
                match e2 with
                | Var(vName) -> (
                    let vlookup = (try Hashtbl.find named_values vName with | Not_found -> (const_float double_type 0.0)) in
                        build_fadd vlookup (const_float double_type 1.0) "addtmp" builder
                )
                | _ -> raise(Failure ("Operator " ^ op ^ "cannot be applied to the given expression."))
            )
            | "--a" -> (
                match e2 with
                | Var(vName) -> (
                    let vlookup = (try Hashtbl.find named_values vName with | Not_found -> (const_float double_type 0.0)) in
                        build_fadd vlookup (const_float double_type (-.1.0)) "addtmp" builder
                )
                | _ -> raise(Failure ("Operator " ^ op ^ "cannot be applied to the given expression."))
            )
            | "a++" -> (
                match e2 with
                | Var(vName) -> (
                    let vlookup = (try Hashtbl.find named_values vName with | Not_found -> (const_float double_type 0.0)) in
                        build_fadd vlookup (const_float double_type 1.0) "addtmp" builder
                )
                | _ -> raise(Failure ("Operator " ^ op ^ "cannot be applied to the given expression."))
            )
            | "a--" -> (
                match e2 with
                | Var(vName) -> (
                    let vlookup = (try Hashtbl.find named_values vName with | Not_found -> (const_float double_type 0.0)) in
                        build_fadd vlookup (const_float double_type (-.1.0)) "addtmp" builder
                )
                | _ -> raise(Failure ("Operator " ^ op ^ "cannot be applied to the given expression."))
            )
            | _ -> raise(Failure ("Unknown unary operator `" ^ op ^ "`."))
    )
    | Op2(op, el, er) -> (
        let el_val = generate_expr el in
            let er_val = generate_expr er in 
                match op with
                | "+" -> (
                    build_fadd el_val er_val "addtmp" builder
                )
                | "-" -> (
                    build_fsub el_val er_val "subtmp" builder
                )
                | "*" -> (
                    build_fmul el_val er_val "multmp" builder
                )
                | "/" -> (
                    build_fdiv el_val er_val "divtmp" builder
                )
                | "%" -> (
                    let el_int_val = const_fptoui el_val double_type in
                        let er_int_val = const_fptoui er_val double_type in 
                            let int_res = build_srem el_int_val er_int_val "modtmp" builder in
                                build_uitofp int_res double_type "booltmp" builder
                )
                | "^" -> (
                    (const_float double_type 0.0) (* TODO *)
                )
                | "<=" -> (
                    (* unordered or less than or equal comparison that is cast to floating point *)
                    let bool_res = build_fcmp Fcmp.Ule el_val er_val "cmptmp" builder in
                        build_uitofp bool_res double_type "booltmp" builder
                )
                | "<" -> (
                    (* unordered or less than comparison that is cast to floating point *)
                    let bool_res = build_fcmp Fcmp.Ult el_val er_val "cmptmp" builder in
                        build_uitofp bool_res double_type "booltmp" builder
                )
                | ">=" -> (
                    (* unordered or greater than or equal comparison that is cast to floating point *)
                    let bool_res = build_fcmp Fcmp.Uge el_val er_val "cmptmp" builder in
                        build_uitofp bool_res double_type "booltmp" builder
                )
                | ">" -> (
                    (* unordered or greater than comparison that is cast to floating point *)
                    let bool_res = build_fcmp Fcmp.Ugt el_val er_val "cmptmp" builder in
                        build_uitofp bool_res double_type "booltmp" builder
                )
                | "==" -> (
                    (* unordered or equal comparison that is cast to floating point *)
                    let bool_res = build_fcmp Fcmp.Ueq el_val er_val "cmptmp" builder in
                        build_uitofp bool_res double_type "booltmp" builder
                )
                | "!=" -> (
                    (* unordered or not equal comparison that is cast to floating point *)
                    let bool_res = build_fcmp Fcmp.Une el_val er_val "cmptmp" builder in
                        build_uitofp bool_res double_type "booltmp" builder
                )
                | "&&" -> (
                    (* if its not equal to 0, then its 1. if its equal to 0, then its 0. this matches bc's bhv *)
                    (* apply this to both the left and the right float value, and then and then together *)
                    (* then, cast back to a float value *)
                    let el_bool_val = build_fcmp Fcmp.Une el_val (const_float double_type 0.0) "cmptmp" builder in
                        let er_bool_val = build_fcmp Fcmp.Une er_val (const_float double_type 0.0) "cmptmp" builder in
                            let and_res = build_and el_bool_val er_bool_val "andtmp" builder in
                                build_uitofp and_res double_type "booltmp" builder
                )
                | "||" -> (
                    (* if its not equal to 0, then its 1. if its equal to 0, then its 0. this matches bc's bhv *)
                    (* reference the "and" operator above for the behavior below *)
                    let el_bool_val = build_fcmp Fcmp.Une el_val (const_float double_type 0.0) "cmptmp" builder in
                        let er_bool_val = build_fcmp Fcmp.Une er_val (const_float double_type 0.0) "cmptmp" builder in
                            let or_res = build_or el_bool_val er_bool_val "ortmp" builder in
                                build_uitofp or_res double_type "booltmp" builder
                )
                | _ -> raise(Failure ("Unknown binary operator `" ^ op ^ "`."))
    )
    | Assign(vName, ex) -> (
        (* TODO, verify that this is correct behavior - no local vars? *)
        let ex_val = generate_expr ex in
            set_value_name vName ex_val;
            Hashtbl.add named_values vName ex_val;
            ex_val
    )
    | FCall(str, args) -> (
        (* Look up the name in the module table. *)
        let callee =
            match lookup_function str the_module with
            | Some callee -> callee
            | None -> raise (Failure "unknown function referenced")
        in
        let params = params callee in

        (* If argument mismatch error. *)
        if Array.length params == List.length args then () else
            raise (Failure "incorrect # arguments passed");
        let args = Array.map generate_expr (Array.of_list args) in
            build_call callee args "calltmp" builder
    )
    | ExprNone() -> (
        (* Used only in the representation of a return with no value attached, we
        return 0 (bc's behavior) *)
        (const_float double_type 0.0)
    )

let rec generate_statement (s: statement): Llvm.llvalue =
    match s with
    | Expr(e) -> (
        (* a top level expression should always be printed, this is bc's bhv *)
        (* this match should NEVER result in None, it should be primed with the extern printd fxn *)
        let fxn =
            match (lookup_function "printd" the_module) with
            | Some callee -> callee
            | None -> raise (Failure "invalid call to generate_statement")
        in
        build_call fxn [|(generate_expr e)|] "calltmp" builder;
    )
    | If(cond, blkT, blkF) -> (
        const_float double_type 0.0 (* TODO *)
    )
    | While(cond, blk) -> (
        const_float double_type 0.0 (* TODO *)
    )
    | For(init,cond,upd,blk) -> (
        const_float double_type 0.0 (* TODO *)
    )
    | FDef(f,params,blk) -> (
        (* TODO, this logic probably needs to be extracted out so that we can 
        define functions outside of the global anonymous function's space *)

        (* generate code for the function definition *)
        codegen_func (Fxn ((Prototype (f, params), blk)))
    )
    | Return(e) -> (
        let ret_val = generate_expr e in
            build_ret ret_val builder
    )
    | Break() -> (
        const_float double_type 0.0 (* TODO *)
    )
    | Continue() -> (
        const_float double_type 0.0 (* TODO *)
    )
    | Print(elements) -> (
        (* TODO, the below needs to be implemented in order to implement this *)
        const_float double_type 0.0
    )
    | String(str) -> (
        (* TODO, construct an external print string method in bindings.c and call it here *)
        const_float double_type 0.0
    )

and generate_statement_list (sl: statement list): Llvm.llvalue =
    match sl with
    | [] -> raise (Failure "statement list is empty")
    | hd::[] -> (
        generate_statement hd
    )
    | hd::tl -> (
        ignore(generate_statement hd);
        generate_statement_list tl
    )

and codegen_proto = function
    | Prototype (name, args) ->
      (* Make the function type: double(double,double) etc. *)
      let doubles = Array.make (List.length args) double_type in
      let ft = function_type double_type doubles in
      let f =
        match lookup_function name the_module with
        | None -> declare_function name ft the_module

        (* If 'f' conflicted, there was already something named 'name'. If it
         * has a body, don't allow redefinition or reextern. *)
        | Some f ->
            (* If 'f' already has a body, reject this. *)
            if block_begin f <> At_end f then
              raise (Failure "redefinition of function");

            (* If 'f' took a different number of arguments, reject. *)
            if element_type (type_of f) <> ft then
              raise (Failure "redefinition of function with different # args");
            f
      in

      (* Set names for all arguments. *)
      Array.iteri (fun i a ->
        let n = List.nth args i in
        set_value_name n a;
        Hashtbl.add named_values n a;
      ) (params f);
      f

and codegen_func = function
  | Fxn (proto, body) ->
      Hashtbl.clear named_values;
      let the_function = codegen_proto proto in

      (* Create a new basic block to start insertion into. *)
      let bb = append_block context "entry" the_function in
      position_at_end bb builder;

      try
        let ret_val = generate_statement_list body in

        (* Finish off the function. *)
        let _ = build_ret ret_val builder in

        (* Validate the generated code, checking for consistency. *)
        Llvm_analysis.assert_valid_function the_function;

        the_function
      with e ->
        delete_function the_function;
        raise e

let generateCode (blk: block)  =
    enable_pretty_stacktrace();
    ignore(codegen_proto( Prototype("printd", ["X"]))); (* declare the external print function in bindings.c *)
    ignore(codegen_func (Fxn ((Prototype ("", []), blk)))); (* Top level anonymous function *)
    print_string (string_of_llmodule the_module)