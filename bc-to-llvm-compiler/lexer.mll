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
    | '"'                                { read_string (Buffer.create 17) lexbuf }
    | ['\n']                             { NL }
    | eof                                { EOF }
    | _ { raise (Failure (Printf.sprintf "At offset %d: unexpected character.\n" (Lexing.lexeme_start lexbuf))) }

    and read_string buf =
    parse
    | '"'       { STRING (Buffer.contents buf) }
    | '\\' '/'  { Buffer.add_char buf '/'; read_string buf lexbuf }
    | '\\' '\\' { Buffer.add_char buf '\\'; read_string buf lexbuf }
    | '\\' 'b'  { Buffer.add_char buf '\b'; read_string buf lexbuf }
    | '\\' 'f'  { Buffer.add_char buf '\012'; read_string buf lexbuf }
    | '\\' 'n'  { Buffer.add_char buf '\n'; read_string buf lexbuf }
    | '\\' 'r'  { Buffer.add_char buf '\r'; read_string buf lexbuf }
    | '\\' 't'  { Buffer.add_char buf '\t'; read_string buf lexbuf }
    | [^ '"' '\\']+
        { Buffer.add_string buf (Lexing.lexeme lexbuf);
        read_string buf lexbuf
        }
    | _ { raise (Failure ("Illegal string character: " ^ Lexing.lexeme lexbuf)) }
    | eof { raise (Failure ("String is not terminated")) }
