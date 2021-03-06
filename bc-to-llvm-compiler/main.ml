open Lexing
open Parser
open Lexer

open Evaluate
open Generate
open Print

let filename = Sys.argv.(1)

let () = 
    open_in filename |>
    Lexing.from_channel |>
    Parser.main Lexer.token |>
    generateCode