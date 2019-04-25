type expr = 
  | Num of int
  | Var of char
  | Add of expr*expr
  | Sub of expr*expr
  | Mul of expr*expr
  | Pow of expr*int
  | Pos of expr
  | Neg of expr

let rec 
  print_op1 c e = 
    Printf.printf "%s(" c;
    print_expr_r e;
    Printf.printf ")"
and
  print_op2 c e1 e2 = 
    Printf.printf "(";
    print_expr_r e1;
    Printf.printf "%s" c;
    print_expr_r e2;
    Printf.printf ")"
and 
  print_expr_r (e:expr): unit = 
    match e with
      | Num(i) -> Printf.printf "%d" i
      | Var(c) -> Printf.printf "%c" c
      | Add(e1,e2) -> print_op2 "+" e1 e2
      | Sub(e1,e2) -> print_op2 "-" e1 e2
      | Mul(e1,e2) -> print_op2 "*" e1 e2
      | Pow(e,i) -> 
        Printf.printf "(";
        print_expr_r e;
        Printf.printf ")^%d" i;
      | Pos(e) -> print_op1 "+" e
      | Neg(e) -> print_op1 "-" e

(*
  Print expression and pass it through
*)
let print_expr (e:expr) :expr = 
  print_expr_r e;
  print_newline ();
  e