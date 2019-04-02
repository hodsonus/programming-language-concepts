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



(* Print a pExpr nicely
  Term(3,0) -> 3
  Term(5,1) -> 5x
  Term(4,2) -> 4x^2
  Plus... -> () + ()
  Times ... -> ()() .. ()

  Hint 1: Print () around elements that are not Term(
  Hint 2: Recurse on the elements of Plus[..] or Times[..]
*)
let rec print_pExp_helper (e: pExp) : unit =
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
            (* print_string "%plus_list%"; *)
            print_string "(";
            print_pExp_list l " + ";
            print_string ")";
            ()
        )
        | Times(l) ->  (
            (* print_string "%times_list%"; *)
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
            print_pExp_helper hd;
            print_string symbol;
            print_pExp_list ([nxt]@tl) symbol
        )
        (* If the list contains 1 element only, print the element and return *)
        | hd::tl -> (
            print_pExp_helper hd;
            ()
        )
let print_pExp (e: pExp) : unit =
    print_pExp_helper e;
    print_string "\n";
    ()


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



let rec bubbleSort (lis: pExp list) : (pExp list) = 
    let sorted = 
        match lis with
            | hd1 :: hd2 :: tl -> (
                (* print_string "bubblesorting "; *)
                match (compare hd1 hd2) with 
                | true -> hd2 :: bubbleSort (hd1 :: tl)
                | false -> hd1 :: bubbleSort (hd2 :: tl)
            )
            | tl -> tl
    in match (equal_list lis sorted) with
        | true -> lis (* fixed point, the list is sorted *)
        | false -> bubbleSort sorted (* recurse and pass over the list again *)

let rec flattenPlusses (accum: pExp list) (lis: pExp list):  (pExp list) =
    match lis with
        | [] -> accum
        | hd::tl -> (
            match hd with
                | Plus(lis) -> flattenPlusses (accum@lis) tl (* Reduce the plus and add it to this level *)
                | _ -> flattenPlusses (accum@[hd]) tl
        )

let rec combinePlusTerms (accum: pExp list) (lis: pExp list):  (pExp list) = 
    match lis with
        | [] -> accum (* Nothing left, so we return *)
        | hd::nxt::tl -> (
            match hd with
                | Term(n1,m1) -> (
                    match nxt with
                        | Term (n2,m2) -> (
                            match m1=m2 with
                                | true -> ( (* we can combine terms!! *)
                                    let combined = Term(n1+n2,m1) in 
                                        combinePlusTerms (accum@[combined]) (tl)
                                )
                                | false -> combinePlusTerms (accum@[hd]) ([nxt]@tl) (* Nothing we can combine, so we advance *)
                        )
                        | _ -> combinePlusTerms (accum@[hd]) ([nxt]@tl) (* Nothing we can combine, so we advance *)
                )
                | _ -> combinePlusTerms (accum@[hd]) ([nxt]@tl) (* Nothing we can combine, so we advance *)
        )
        | hd::[] -> (accum@[hd]) (* Nothing left, so we return *)

let rec remove0Terms (accum: pExp list) (lis: pExp list) :  (pExp list) =
    match lis with
        | [] -> accum
        | hd::tl -> (
            match hd with
                | Term(n,m) -> (
                    match n with
                        | 0 -> remove0Terms accum tl
                        | _ -> remove0Terms (accum@[hd]) tl
                )
                | _ -> remove0Terms (accum@[hd]) tl
        )


let rec flattenTimes (accum: pExp list) (lis: pExp list):  (pExp list) =
    match lis with
        | [] -> accum
        | hd::tl -> (
            match hd with
                | Times(lis) -> flattenTimes (accum@lis) tl (* Reduce the plus and add it to this level *)
                | _ -> flattenTimes (accum@[hd]) tl
        )

let rec accumulateTimesTerms (accum: pExp list) (lis: pExp list):  (pExp list) = 
    match lis with
        | [] -> accum (* Nothing left, so we return *)
        | hd::nxt::tl -> (
            match hd with
                | Term(n1,m1) -> (
                    match nxt with
                        | Term (n2,m2) -> (
                            let combined = Term(n1*n2,m1+m2) in 
                                accumulateTimesTerms (accum@[combined]) (tl)
                        )
                        | _ -> accumulateTimesTerms (accum@[hd]) ([nxt]@tl) (* Nothing we can combine, so we advance *)
                )
                | _ -> accumulateTimesTerms (accum@[hd]) ([nxt]@tl) (* Nothing we can combine, so we advance *)
        )
        | hd::[] -> (accum@[hd]) (* Nothing left, so we return *)

let extractSingleElement (e: pExp) :  pExp = 
    match e with
        | Times(lis) -> (
            match lis with
                | [] -> e (* This is a weird state, potentially an invalid state *)
                | hd::[] -> hd
                | _ -> e
        )
        | Plus(lis) -> (
            match lis with
                | [] -> e (* This is a weird state, potentially an invalid state *)
                | hd::[] -> hd
                | _ -> e
        )
        | _ -> e

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
        | Plus(lis) -> (
            let newExp = Plus(simplify1_plus lis) in
                extractSingleElement newExp
        )
        | Times(lis) -> (
            let newExp = Times(simplify1_times lis) in 
                extractSingleElement newExp
        )
(* Where does distributivity, i.e. hint 5, fit in? *)
and simplify1_plus (lis : pExp list) : pExp list =
    (* 1. flatten plusses, i.e. hint 2 *)
    let lis1 = flattenPlusses [] lis in
        (* 3. sort the list by degree of each pExp in the list, i.e. hint 1 *)
        let lis2 = bubbleSort lis1 in
            (* 1. Iterate over the list and call simplify1 on each of the expressions. *)
            let lis3 = simplify1_list [] lis2 in 
                (* 4. iterate over list and combine Terms** with like exponents (pretty sure we should be only attempting to combine like exponents between terms, NOT any pExp), keeping track of the previous term and the current term. if the rpevious term has teh same degree as the current term, replace both the previous term, say Term(n1,m), and the current term, say Term(n2,m) with Term(n1+n2,m), i.e. hint 4 *)
                let lis4 =  combinePlusTerms [] lis3 in
                    (* 5. remove any terms with n = 0 *)
                    remove0Terms [] lis4
and simplify1_times (lis : pExp list) : pExp list =
    (* 1. Iterate over the list and call simplify1 on each of the expressions. *)
    let lis1 = simplify1_list [] lis in 
        (* 2. Flatten all of the multiplication, i.e. hint 3 *)
        let lis2 = flattenTimes [] lis1 in
            (* 3. Iterate over the list and accumulate terms. Term(n1, m1)*Term(n2,m2) => Term(n1*n2, m1+m2). This can only be done between consecutive terms, so we must simplify all the components first. *)
            accumulateTimesTerms [] lis2
                
and simplify1_list (accum : pExp list) (lis: pExp list) : (pExp list) =
    match lis with
        | [] -> accum
        | hd::tl -> (
            let res = simplify1 hd in
                simplify1_list (accum@[res]) tl
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



(* Helper fucntion used below for the equal_pExp_numeric fxn. Evaluates from n downto 0 for a total of n+1 evaluations *)
let rec countdown_eval (exp1: pExp) (exp2: pExp) (n: int) : bool =
    match n < 0 with
        | true -> true
        | false -> (
            let res1 = (evaluate_pExp exp1 n) in
                let res2 = (evaluate_pExp exp2 n) in
                    match res1=res2 with
                        | false -> false
                        | true -> (countdown_eval exp1 exp2 (n-1))
        )
(* Compute if two pExp are the same.
   This computes numerical equality, i.e. the type of equality
   where the polynomials produce the same output given input.
*)
let equal_pExp_numeric (exp1: pExp) (exp2: pExp) : bool = 
    let deg1 = degree exp1 in
        let deg2 = degree exp2 in
            let maxDeg = (max deg1 deg2) in
                (countdown_eval exp1 exp2 maxDeg)



(* Fixed point version of simplify1
  i.e. Apply simplify1 until no progress is made
*)
let rec simplify (e:pExp): pExp =
    let rE = simplify1(e) in
      let areEquiv = equal_pExp_numeric rE e in
        match areEquiv with
        | true -> (
            print_pExp rE;
            if (equal_pExp e rE) then
                e
            else
                simplify(rE)
        )
        | false -> raise(Failure("Error in simplification."))