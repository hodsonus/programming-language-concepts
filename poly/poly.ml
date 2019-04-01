(* Sum type to encode efficiently polynomial expressions *)
type pExp =
  | Term of int*int
    (* First int is the constant
       Second int is the power of x
       10  -> Term(10,0)
       2x -> Term(2,1)
       3x^20 -> Term(3, 20)
    *)
  | Plus of pExp list
    (* List of terms added Plus([Term(2,1); Term(1,0)]) *)
  | Times of pExp list (* List of terms multiplied *)

(* Function to traslate betwen AST expressions to pExp expressions *)
let rec from_expr (_e: Expr.expr) : pExp =
    match _e with
        | Num(num) -> (
            Term(num,0)
        )
        | Var(var) -> (
            match var with
                | 'x' -> Term(1,1)
                | _ -> raise(Failure("error unknown variable"))
        )
        | Add(exp1, exp2) -> (
            Plus([from_expr exp1; from_expr exp2])
        )
        | Sub(exp1, exp2) -> (
            Plus([from_expr exp1; Times([Term(-1,0); from_expr exp2])])
        )
        | Mul(exp1, exp2) -> (
            Times([from_expr exp1; from_expr exp2])
        )
        | Pow(exp, num) -> (
            Times(pow_expr [] (from_expr exp) num)
        )
        | Pos(exp) -> (
            from_expr exp
        )
        | Neg(exp) -> (
            Times([Term(-1,0); from_expr exp])
        )

and pow_expr(accum: pExp list) (e: pExp) (n: int) : (pExp list) =
    match n with
        | 0 -> accum
        | _ -> pow_expr (accum@[e]) e (n-1)

(*Compute degree of a polynomial expression.
    Hint 1: Degree of Term(n,m) is m
    Hint 2: Degree of Plus[...] is the max of the degree of args
    Hint 3: Degree of Times[...] is the sum of the degree of args
*)
let rec degree (_e:pExp): int =
    match _e with
        | Term(n,m) -> m
        | Plus(lis) -> deg_plus lis 0
        | Times(lis) -> deg_times lis 0

and deg_plus (lis : pExp list) (curMax : int) : int =
    match lis with
        | [] -> curMax
        | hd::tl -> (
            match hd with
                | Term(n,m) -> max curMax m
                | Plus(l) -> max curMax (deg_plus l 0)
                | Times(l) -> max curMax (deg_times l 0)
        )

and deg_times (lis : pExp list) (accum : int) : int =
    match lis with
        | [] -> accum
        | hd::tl -> (
            match hd with
                | Term(n,m) -> accum + m
                | Plus(l) -> accum + (deg_plus l 0)
                | Times(l) -> accum + (deg_times l 0)
        )

(* Comparison function useful for sorting of Plus[..] args to "normalize
    them". This way, terms that need to be reduced show up one after another.
  *)
let compare (e1: pExp) (e2: pExp) : bool =
  degree e1 > degree e2

let print_pow (m: int) : unit = 
    match m with
        | 0 -> ( 
            print_string "1";
            ()
        )
        | 1 -> (
            print_string "x";
            ()
        )
        | _ -> (
            print_string ("x^" ^ (string_of_int m));
            ()
        )

(* Print a pExpr nicely
  Term(3,0) -> 3
  Term(5,1) -> 5x
  Term(4,2) -> 4x^2
  Plus... -> () + ()
  Times ... -> ()() .. ()

  Hint 1: Print () around elements that are not Term(
  Hint 2: Recurse on the elements of Plus[..] or Times[..]
*)
let rec print_pExp (e: pExp) : unit =
    match e with
        | Term(n, m) -> (
            match n with
                | 0 -> ( 
                    print_string "0";
                    ()
                )
                | 1 -> (
                    match m with 
                        | 0 -> print_string (string_of_int n)
                        | 1 -> print_string "x"
                        | _ -> print_string ("x^"^(string_of_int m))
                )
                | _ -> (
                    match m with 
                        | 0 -> print_string (string_of_int n)
                        | 1 -> print_string ((string_of_int n)^"x")
                        | _ -> print_string ((string_of_int n)^"x^"^(string_of_int m))
                )
        )
        | Plus(l) -> (
            print_string "(";
            print_pExp_list l " + ";
            print_string ")";
            ()
        )
        | Times(l) ->  (
            print_string "(";
            print_pExp_list l " * ";
            print_string ")";
            ()
        )

and print_pExp_list (lis : pExp list) (symbol : string) : unit =
    match lis with 
        (* If the list is empty, return *)
        | [] -> ()
        (* If list contains 2 or more elements, print the first element, followed by the symbol, and then recurse *)
        | hd::nxt::tl -> (
            print_pExp hd;
            print_string symbol;
            print_pExp_list ([nxt]@tl) symbol
        )
        (* If the list contains 1 element only, print the element and return *)
        | hd::tl -> (
            print_pExp hd;
            ()
        )

(*Function to simplify (one pass) pExpr

  n1 x^m1 * n2 x^m2 -> n1*n2 x^(m1+m2)
  Term(n1,m1)*Term(n2,m2) -> Term(n1*n2,m1+m2)

  Hint 1: Keep terms in Plus[...] sorted
  Hint 2: flatten plus, i.e. Plus[ Plus[..], ..] => Plus[..]
  Hint 3: flatten times, i.e. times of times is times
  Hint 4: Accumulate terms. Term(n1,m)+Term(n2,m) => Term(n1+n2,m)
          Term(n1, m1)*Term(n2,m2) => Term(n1*n2, m1+m2)
  Hint 5: Use distributivity, i.e. Times[Plus[..],] => Plus[Times[..],]
    i.e. Times[Plus[Term(1,1); Term(2,2)]; Term(3,3)]
      => Plus[Times[Term(1,1); Term(3,3)]; Times[Term(2,2); Term(3,3)]]
      => Plus[Term(2,3); Term(6,5)]
  Hint 6: Find other situations that can arise
*)
let rec simplify1 (e:pExp): pExp =
    match e with
        | Term(n,m) -> e
        | Plus(lis) -> Plus(simplify1_plus lis) (* TODO *)
        | Times(lis) -> Times(simplify1_times lis) (* TODO *)

and simplify1_plus (lis : pExp list) : pExp list = lis
    (* match lis with
        | hd::[] ->  *)

and simplify1_times (lis : pExp list) : pExp list = lis




(* Compute if two pExp are the same
   Make sure this code works before you work on simplify1
   This computes structural equality, i.e. the type of equality
   where the polynomials have the same node nesting
*)
let rec equal_pExp (e1: pExp) (e2: pExp) : bool =
    match e1 with
        | Term(n1,m1) -> (
            match e2 with
                | Term(n2,m2) -> ((m1=m2) && (n1=n2))
                | Plus(_) -> false
                | Times(_) -> false
        )
        | Plus(lis1) -> (
            match e2 with
                | Term(_,_) -> false
                | Plus(lis2) -> (equal_list lis1 lis2)
                | Times(_) -> false
        )
        | Times(lis1) -> (
            match e2 with
                | Term(_,_) -> false
                | Plus(_) -> false
                | Times(lis2) -> (equal_list lis1 lis2)
        )
and equal_list (lis1: pExp list) (lis2: pExp list) : bool = 
    match lis1 with
        | [] -> (
            match lis2 with
                | [] -> true
                | _ -> false
        )
        | hd1::tl1 -> (
            match lis2 with
                | [] -> false
                | hd2::tl2 -> (
                    match (equal_pExp hd1 hd2) with
                        | false -> false
                        | true -> (
                            equal_list tl1 tl2
                        )
                )
        )



let rec fastexpt : int -> int -> int = fun b n ->
    if n = 0 then 1
    else 
    let b2 = fastexpt b (n / 2) in
    if n mod 2 = 0 then b2 * b2 
    else b * b2 * b2



(* evaluate a pExp at a given x value *)
let rec evaluate_pExp (exp: pExp) (x: int) : int =
    match exp with
        | Term(n,m) -> n*(fastexpt x m)
        | Times(lis) -> (evaluate_times_list lis x)
        | Plus(lis) -> (evaluate_plus_list lis x)
and evaluate_times_list (lis: pExp list) (x: int) : int = 
    match lis with
        | [] -> 1
        | hd::tl -> (evaluate_pExp hd x)*(evaluate_times_list tl x)
and evaluate_plus_list (lis: pExp list) (x: int) : int =
    match lis with
        | [] -> 0
        | hd::tl -> (evaluate_pExp hd x)+(evaluate_plus_list tl x)


(* TODO *)
(* Helper fucntion used below for the equal_pExp_numeric fxn *)
let equal_pExp_numeric_helper (exp1: pExp) (exp2: pExp) (n: int) : bool = true

(* Compute if two pExp are the same.
   This computes numerical equality, i.e. the type of equality
   where the polynomials produce the same output given input.
*)
let equal_pExp_numeric (exp1: pExp) (exp2: pExp) : bool = 
    let deg1 = degree exp1 in
        let deg2 = degree exp2 in
            let maxDeg = (max deg1 deg2) in
                (equal_pExp_numeric_helper exp1 exp2 maxDeg)

(* Fixed point version of simplify1
  i.e. Apply simplify1 until no progress is made
*)
let rec simplify (e:pExp): pExp =
    let rE = simplify1(e) in
      print_pExp rE;
      if (equal_pExp e rE) then
        e
      else
        simplify(rE)