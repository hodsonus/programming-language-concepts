open Lexing
open Parser
open Lexer
open Bc
open MenhirLib

let filename = Sys.argv.(1)

let () = 
  open_in filename |>
  Lexing.from_channel |>
  Parser.main Lexer.token |>
  runCode

let () = 
  let a = open_in filename in
    let b = Lexing.from_channel a in
      let c = Parser.main Lexer.token b in
        runCode c