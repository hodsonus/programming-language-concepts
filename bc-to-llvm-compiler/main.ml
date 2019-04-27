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
    printCode |>
    runCode