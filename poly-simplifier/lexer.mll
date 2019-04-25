{
    open Parser
    exception Eof
}

rule token = parse
  | [' ' '\t']          { token lexbuf }
  | ['\n']              { EOL }
  | ['0'-'9']+ as lxm   { NUM (int_of_string lxm) }
  | '+'                 { PLUS }
  | '-'                 { MINUS }
  | '*'                 { TIMES }
  | '('                 { LPAR }
  | ')'                 { RPAR }
  | '^'                 { POW }
  | ['a'-'z'] as lxm    { VAR (lxm) }
  | eof                 { raise Eof }