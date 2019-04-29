{
    open Parser
}

rule token = parse
    | [' ' '\t']                         { token lexbuf }
    | ';'                                { SEMICOLON }
    | "print"                            { PRINT }
    | ','                                { COMMA }
    | "return"                           { RETURN }
    | "break"                            { BREAK }
    | "continue"                         { CONTINUE }
    | '{'                                { LEFT_BRACE }
    | '}'                                { RIGHT_BRACE }
    | "while"                            { WHILE }
    | "if"                               { IF }
    | "else"                             { ELSE }
    | "for"                              { FOR }
    | "define"                           { DEFINE }
    | '('                                { LEFT_PAR }
    | ')'                                { RIGHT_PAR }
    | "++"                               { PLUSPLUS }
    | '+'                                { PLUS }
    | "++"                               { MINUSMINUS }
    | '-'                                { MINUS }
    | '*'                                { TIMES }
    | '/'                                { DIV }
    | '%'                                { MOD }
    | '^'                                { POW }
    | "<="                               { LTE }
    | '<'                                { LT }
    | ">="                               { GTE }
    | '>'                                { GT }
    | "=="                               { EQEQ }
    | "!="                               { NE }
    | '!'                                { NOT }
    | "&&"                               { AND }
    | "||"                               { OR }
    | '='                                { EQ }
    | ['0'-'9']*['.']['0'-'9']* as lxm   { NUM (float_of_string lxm) }
    | ['0'-'9']+ as lxm                  { NUM (float_of_string lxm) }
    | ['a'-'z']+['_']*['a'-'z']* as lxm  { ID (lxm) }
    | '"'_*'"' as lxm               { STRING (lxm) }
    | ['\n']                             { NL }
    | eof                                { EOF }
    | _ { raise (Failure (Printf.sprintf "At offset %d: unexpected character.\n" (Lexing.lexeme_start lexbuf))) }