(* John Hodson
 * University of Florida
 * COP4020 - Programming Language Concepts
 * Professor Alin Dobra
 * RPN Calculator Testing Unit
 *)

open OUnit

let test_fixture = "test suite for rpn" >:::
[
  "addition" >:: ( fun () -> assert_equal 5. (Rpn.eval "2 3 +"));
]

let _ = run_test_tt test_fixture