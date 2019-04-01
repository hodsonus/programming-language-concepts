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
                    ();
                    print_pow m
                )
                | _ -> (
                    print_string (string_of_int n);
                    print_pow m
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
let simplify1 (e:pExp): pExp =
    e

(*Compute if two pExp are the same
  Make sure this code works before you work on simplify1
*)
let equal_pExp (_e1: pExp) (_e2: pExp) :bool =
  true

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
