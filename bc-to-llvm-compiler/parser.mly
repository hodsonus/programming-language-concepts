%{
    open Bc
%}

%token SEMICOLON
%token PRINT
%token COMMA
%token QUIT
%token RETURN
%token BREAK CONTINUE
%token HALT
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
%token EQ PLUS_EQ MINUS_EQ TIMES_EQ DIV_EQ
/* NO BLOCK OR INLINE COMMENT RULES */
%token <float> NUM
%token <string> ID
%token <string> STRING
%token NL
%token EOF

%left PLUS MINUS
%left TIMES DIV
%left POW

%type <Bc.statement list> main
%start main
%%

main: statementList EOF { $1 };

delim: 
    | NL {}
    | SEMICOLON {};

statementList:
    | statement delim+ statementList { [$1]@$3 }
    | statement delim+               { [$1]      };

numArgList:
    | expr COMMA numArgList { [$1]@$3 }
    | expr                  { [$1] };

fxnArgList:
    | ID COMMA fxnArgList { [$1]@$3 }
    | ID                  { [$1] }

printList:
    | expr COMMA printList   { [PrintExpr($1)]@$3 }
    | STRING COMMA printList { [PrintString($1)]@$3 }
    | expr                   { [PrintExpr($1)] }
    | STRING                 { [PrintString($1)] }

expr:
    |   ID LEFT_PAR RIGHT_PAR            { FCall($1, []) }
    |   ID LEFT_PAR numArgList RIGHT_PAR { FCall($1, $3) }
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

statement: 
    | expr    { Expr($1) }
    | IF LEFT_PAR expr RIGHT_PAR NL? statement delim { If($3, [$6], []) } /* An if with no else, no brackets*/
    | IF LEFT_PAR expr RIGHT_PAR NL? LEFT_BRACE statementList RIGHT_BRACE { If($3, $7, []) } /* An if with no else, with brackets*/
    | IF LEFT_PAR expr RIGHT_PAR NL? statement delim ELSE NL? statement delim { If($3, [$6], [$10]) } /* An if with else, no brackets on either */
    | IF LEFT_PAR expr RIGHT_PAR NL? LEFT_BRACE statementList RIGHT_BRACE ELSE NL? LEFT_BRACE statementList RIGHT_BRACE { If($3, $7, $12) } /* An if with else, brackets on both */
    | IF LEFT_PAR expr RIGHT_PAR NL? LEFT_BRACE statementList RIGHT_BRACE ELSE NL? statement delim { If($3, $7, [$11]) } /* An if with else, brackets on if */
    | IF LEFT_PAR expr RIGHT_PAR NL? statement delim ELSE NL? LEFT_BRACE statementList RIGHT_BRACE { If($3, [$6], $11) } /* An if with else, brackets on else */
    | WHILE LEFT_PAR expr RIGHT_PAR NL? statement delim { While($3, [$6]) }
    | WHILE LEFT_PAR expr RIGHT_PAR NL? LEFT_BRACE statementList RIGHT_BRACE { While($3, $7) }
    | FOR LEFT_PAR expr SEMICOLON expr SEMICOLON expr RIGHT_PAR NL? statement delim { For($3, $5, $7, [$10]) }
    | FOR LEFT_PAR expr SEMICOLON expr SEMICOLON expr RIGHT_PAR NL? LEFT_BRACE statementList RIGHT_BRACE { For($3, $5, $7, $11) }
    | DEFINE ID LEFT_PAR fxnArgList RIGHT_PAR NL? statement delim { FDef($2, $4, [$7]) }
    | DEFINE ID LEFT_PAR fxnArgList RIGHT_PAR NL? LEFT_BRACE statementList RIGHT_BRACE { FDef($2, $4, $8) }
    | DEFINE ID LEFT_PAR RIGHT_PAR NL? statement delim { FDef($2, [], [$6]) }
    | DEFINE ID LEFT_PAR RIGHT_PAR NL? LEFT_BRACE statementList RIGHT_BRACE { FDef($2, [], $7) } 
    | RETURN expr { Return($2) }
    | RETURN { Return(None()) }
    | BREAK { Break() }
    | CONTINUE { Continue() }
    | PRINT printList { Print($2) }
    | STRING { String($1) };

/*
type expr = (* a fragment of code *)
    | Num    of float
    | Var    of string
    | Op1    of string*expr
    | Op2    of string*expr*expr
    | Assign of string*expr
    | FCall  of string*expr list
    | None   of unit
*/
/*
type printElement =
    | String of string
    | Expr   of expr
*/
/*
type statement = (* a line of code *)
    | Expr     of expr
    | If       of expr*statement list*statement list
    | While    of expr*statement list
    | For      of expr*expr*expr*statement list
    | FDef     of string*string list*statement list
    | Return   of expr
    | Break    of unit
    | Continue of unit
    | Print    of printElement list
    | String   of string
*/