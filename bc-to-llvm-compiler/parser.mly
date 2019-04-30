%{
    open Types
%}

%token SEMICOLON
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
%token EOF
/* %token HALT QUIT */
/* %token PLUS_EQ MINUS_EQ TIMES_EQ DIV_EQ */
/* NO BLOCK OR INLINE COMMENT RULES */

%left PLUS MINUS MOD
%left TIMES DIV
%right POW
%left LTE LT GTE GT EQEQ NE
%right NOT
%left AND OR
%right EQ

%type <Types.statement list> main
%start main
%%

main: statementList EOF { $1 };

delim: 
| NL        {}
| SEMICOLON {};

/* TODO, shift reduce conflicts are generated here */
statementList:
| statement delim+ statementList { [$1]@$3 }
| statement delim*               { [$1] } 
| delim* statementList           { $2 }

numArgList:
| expr COMMA numArgList { [$1]@$3 }
| expr                  { [$1] };

fxnArgList:
| ID COMMA fxnArgList { [$1]@$3 }
| ID                  { [$1] };

printList:
| expr COMMA printList   { [PrintExpr($1)]@$3 }
| STRING COMMA printList { [PrintString($1)]@$3 }
| expr                   { [PrintExpr($1)] }
| STRING                 { [PrintString($1)] };

fCallArgs:
| LEFT_PAR RIGHT_PAR            { [] }
| LEFT_PAR numArgList RIGHT_PAR { $2 }

expr:
|   ID fCallArgs                     { FCall($1, $2) }
|   LEFT_PAR expr RIGHT_PAR          { $2 }
|   ID PLUSPLUS                      { Op1("a++", Var($1)) }
|   PLUSPLUS ID                      { Op1("++a", Var($2)) }
|   ID MINUSMINUS                    { Op1("a--", Var($1)) }
|   MINUSMINUS ID                    { Op1("--a", Var($2)) }
|   MINUS expr                       { Op1("-",   $2) }
|   expr POW expr                    { Op2("^",  $1, $3) }
|   expr TIMES expr                  { Op2("*",  $1, $3) }
|   expr DIV expr                    { Op2("/",  $1, $3) }
|   expr MOD expr                    { Op2("%",  $1, $3) }
|   expr PLUS expr                   { Op2("+",  $1, $3) }
|   expr MINUS expr                  { Op2("-",  $1, $3) }
|   ID EQ expr                       { Assign($1, $3) }
|   expr LTE expr                    { Op2("<=", $1, $3) }
|   expr LT expr                     { Op2("<",  $1, $3) }
|   expr GTE expr                    { Op2(">=", $1, $3) }
|   expr GT expr                     { Op2(">",  $1, $3) }
|   expr EQEQ expr                   { Op2("==", $1, $3) }
|   expr NE expr                     { Op2("!=", $1, $3) }
|   NOT expr                         { Op1("!",   $2) }
|   expr AND expr                    { Op2("&&", $1, $3) }
|   expr OR expr                     { Op2("||", $1, $3) }
|   ID                               { Var($1) }
|   NUM                              { Num($1) };

block:
| statement delim                      { [$1] }
| LEFT_BRACE statementList RIGHT_BRACE { $2 }
| LEFT_BRACE RIGHT_BRACE { [] };

fxnArgs:
| LEFT_PAR fxnArgList RIGHT_PAR { $2 }
| LEFT_PAR RIGHT_PAR            { [] };

ifStatement:
| IF LEFT_PAR expr RIGHT_PAR NL? block                    { If($3, $6, []) }
| IF LEFT_PAR expr RIGHT_PAR NL? block NL? ELSE NL? block { If($3, $6, $10) };

statement: 
| expr                                                                { Expr($1) }
| ifStatement                                                         { $1 }
| WHILE LEFT_PAR expr RIGHT_PAR NL? block                             { While($3, $6) }
| FOR LEFT_PAR expr SEMICOLON expr SEMICOLON expr RIGHT_PAR NL? block { For($3, $5, $7, $10) }
| DEFINE ID fxnArgs NL? block                                         { FDef($2, $3, $5) }
| RETURN expr                                                         { Return($2) }
| RETURN                                                              { Return(ExprNone()) }
| BREAK                                                               { Break() }
| CONTINUE                                                            { Continue() }
| PRINT printList                                                     { Print($2) }
| STRING                                                              { String($1) };