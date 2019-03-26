%{
    open Expr
%}

%token <int> NUM
%token <char> VAR
%token PLUS MINUS TIMES POW
%token LPAR RPAR
%token EOL
%left PLUS MINUS
%left TIMES
%left POW
%type <Expr.expr> main
%start main
%%

main:
expr EOL                    { $1 }
;

v_expr:
    |   NUM                         { Num($1) }
    |   VAR                         { Var($1) }
    |   NUM VAR                     { Mul( Num($1), Var($2)) }
    |   VAR POW NUM                 { Pow( Var($1), $3) }
    |   NUM VAR POW NUM             { Mul( Num($1), Pow( Var($2), $4))}

expr:
|   v_expr                      { $1 }
|   LPAR expr RPAR              { $2 }
|   expr TIMES expr             { Mul($1,$3) }
|   expr PLUS expr              { Add($1, $3) }
|   expr MINUS expr             { Sub($1, $3) }
|   expr POW NUM                { Pow($1, $3) }
|   PLUS expr                   { Pos($2) }
|   MINUS expr                  { Neg($2) }
;