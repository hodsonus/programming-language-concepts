open Lexing
open Parser
open Lexer
(* open MenhirBasics *)
open Bc

let filename = Sys.argv.(1)

let () = 
  open_in filename |>
  Lexing.from_channel |>
  Parser.main Lexer.token |>
  runCode

let () = 
  let a = open_in filename in
    let b = Lexing.from_channel a in
      (* try *)
        let c = Parser.main Lexer.token b in
          runCode c
      (* with Parser.MenhirBasics.Error ->
        raise(Failure("Error")) *)