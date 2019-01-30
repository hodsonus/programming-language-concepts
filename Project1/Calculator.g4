grammar Calculator;

exprList: topExpr ( ';' topExpr)* ';'? ;

varDef: VAR ID '=' expr;

topExpr: expr
    { System.out.println("result: "+ Integer.toString($expr.i)); }
;

expr returns [int i]:
    el=expr op='*' er=expr { $i=$el.i*$er.i; }
    | el=expr op='/' er=expr { $i=$el.i/$er.i; }
    | el=expr op='+' er=expr { $i=$el.i+$er.i; }
    | el=expr op='-' er=expr { $i=$el.i-$er.i; }
    | INT { $i=Integer.parseInt($INT.text); }
    | ID
    | '(' e=expr ')'
    ;

VAR: 'var';  // keyword

ID: [_A-Za-z]+;
INT: [0-9]+;
WS: [ \t\r\n]+ -> skip ;
