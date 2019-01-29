/*
X - Block/InLine Comments
X - Basic expressions with variables
X - Boolean Expressions
X - Precedence
O - Special Expression: read and sqrt
X - Statements: expressions (print value on the screen when executed), print expressions
O - Math library functions: s, c, l, e (no need for a and j)
*/

grammar Grammar;

exprList: (topExpr ';'? NL)+;

varDef: VAR ID '=' expr;

topExpr: expr { System.out.println($expr.i); } | NL ;

expr returns [double i]:
    | '++' e=expr { $i=$e.i++; }
    | '--' e=expr { $i=$e.i--; }
    | '-' e=expr { $i=-$e.i; }
    | '^' e=expr { $i=-$e.i; }
    | el=expr op=('*'|'/') er=expr {
        if ($op=='*')
            $i=$el.i*$er.i;
        else
            $i=$el.i/$er.i;
    }
    | el=expr op=('+'|'-') er=expr {
        if ($op=='+')
            $i=$el.i+$er.i;
        else
            $i=$el.i-$er.i;
    }
    | '!' e=expr { $i=($e.i!=0)?1:0; }
    | el=expr op='&&' er=expr { $i=($el.i&&$er.i; }
    | el=expr op='||' er=expr { $i=$el.i||$er.i; }
    | INT { $i=Integer.parseInt($INT.text); }
    | '(' e=expr ')'
    | ID
    ;

BlockComment: '/*' .* '*/' -> skip;
InlineComment: '#' .* NL -> skip;

VAR: 'var';  // keyword

ID: [_A-Za-z]+;
INT: [0-9]+ ;
WS: [ \t\r]+ -> skip;
NL: [\n];
