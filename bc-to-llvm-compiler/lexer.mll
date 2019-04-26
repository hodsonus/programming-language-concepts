{
    open Parser
    exception Eof
}

rule token = parse
  | [' ' '\t']                       { token lexbuf }
  | ['\n']                           { EOL }
  | ['+''+']                         { PLUSPLUS }
  | '+'                              { PLUS }
  | ['-''-']                         { MINUSMINUS }
  | '-'                              { MINUS }
  | '*'                              { TIMES }
  | '('                              { LPAR }
  | ')'                              { RPAR }
  | '^'                              { POW }
  | eof                              { raise Eof }
(*
  | [0-9]*['.'][0-9]* as lxm         { NUM (flt_of_string lxm) }
  | [a-z]+[_]*[a-z]* as lxm          { ID (lxm) }*)