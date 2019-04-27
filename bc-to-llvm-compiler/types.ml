(* ============================== types ============================== *)

type expr = (* a fragment of code *)
    | Num    of float
    | Var    of string
    | Op1    of string*expr
    | Op2    of string*expr*expr
    | Assign of string*expr
    | FCall  of string*expr list
    | ExprNone   of unit

type printElement =
    | PrintString of string
    | PrintExpr   of expr

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

exception ReturnInProgress   of float*scopeStack
exception BreakInProgress    of scopeStack
exception ContinueInProgress of scopeStack