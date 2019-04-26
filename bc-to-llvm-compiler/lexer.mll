{
    open Parser
    exception Eof
}

rule token = parse
  | [' ' '\t']                       { token lexbuf }
  | ';'                              { SEMICOLON }
  | "print"                          { PRINT }
  | ','                              { COMMA }
  | "return"                         { RETURN }
  | "break"                          { BREAK }
  | "continue"                       { CONTINUE }
  | '{'                              { LEFT_BRACE }
  | '}'                              { RIGHT_BRACE }
  | "while"                          { WHILE }
  | "if"                             { IF }
  | "else"                           { ELSE }
  | "for"                            { FOR }
  | "define"                         { DEFINE }
  | '('                              { LEFT_PAR }
  | ')'                              { RIGHT_PAR }
  | "++"                             { PLUSPLUS }
  | '+'                              { PLUS }
  | "++"                             { MINUSMINUS }
  | '-'                              { MINUS }
  | '*'                              { TIMES }
  | '/'                              { DIV }
  | '%'                              { MOD }
  | '^'                              { POW }
  | "<="                             { LTE }
  | '<'                              { LT }
  | ">="                             { GTE }
  | '>'                              { GT }
  | "=="                             { EQEQ }
  | "!="                             { NE }
  | '!'                              { NOT }
  | "&&"                             { AND }
  | "||"                             { OR }
  | '='                              { EQ }
  | ['0'-'9']*['.']['0'-'9']* as lxm { NUM (float_of_string lxm) }
  | ['a'-'z']+['_']*['a'-'z']* as lxm{ ID (lxm) }
  | ['"']_*?['"'] as lxm             { STRING (lxm) }
  | ['\n']                           { NL }
  | eof                              { EOF }

(* %token SEMICOLON
%token PRINT
%token COMMA
%token RETURN
%token BREAK CONTINUE
%token LEFT_BRACE RIGHT_BRACE
%token WHILE
%token IF ELSE
%token FOR
%token DEFINE
%token LEFT_PAR RIGHT_PAR
%token PLUS MINUS TIMES DIV MOD POW
%token LTE LT GTE GT EQEQ NE
%token NOT AND OR
%token PLUSPLUS MINUSMINUS
%token EQ
%token <float> NUM
%token <string> ID
%token <string> STRING
%token NL
%token EOF *)