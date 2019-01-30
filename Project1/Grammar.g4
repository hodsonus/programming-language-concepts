// antlr4 Grammar.g4
// javac Grammar*.java
// grun Grammar expr [-tree] [-gui] input.txt


// BONUS - 
// 	Arrays - extra 10%
// 		how do you implement arrays
// 		how do you differentiate between arrays and ints
// 		tackle main part first (obvi)
// 		bonus can damage the main project, consider branching after project completion
// 	Arbitrary precision - extra 10%

// X - Block/InLine Comments
// X - Basic expressions with variables
// X - Boolean Expressions
// X - Precedence
// O - Special Expression: read and sqrt
// X - Statements: expressions (print value on the screen when executed), print expressions
// O - Math library functions: s, c, l, e (no need for a and j)

grammar Grammar;

@header {
    // parser members
    import java.util.HashMap;
}

@members {
    // lexer members
    HashMap<String, Double> glob = new HashMap<String, Double>();
}

exprList: (topExpr ';'? NL)+;

varDef: VAR ID '=' expr;

// topExpr: expr { System.out.println(Integer.toString($expr.i)); } ;
// expr returns [int i]:
//     el=expr op='*' er=expr { $i=$el.i*$er.i; }
//     | el=expr op='/' er=expr { $i=$el.i/$er.i; }
//     | el=expr op='+' er=expr { $i=$el.i+$er.i; }
//     | el=expr op='-' er=expr { $i=$el.i-$er.i; }
//     | INT { $i=Integer.parseInt($INT.text); }
//     | ID
//     | '(' e=expr ')'
//     ;

topExpr: expr { System.out.println(Double.toString($expr.i)); } ;
expr returns [double i]:
    | '++' e=expr { $i= $e.i++; }
    | '--' e=expr { $i= $e.i--; }
    | '-' e=expr { $i= -$e.i; }
    | el=expr op='^' er=expr { $i=Math.pow($el.i,$er.i); }
    | el=expr op=('*'|'/'|'%') er=expr {
        if ($op.equals("*"))
            $i=$el.i*$er.i;
        else if ($op.equals("%"))
            $i=$el.i % $er.i;
        else
            $i=$el.i/$er.i;
    }
    | el=expr op=('+'|'-') er=expr {
        if ($op.equals('+'))
            $i=$el.i+$er.i;
        else
            $i=$el.i-$er.i;
    }
    | el=expr op=( '<=' |'<'|'>='|'>'|'=='|'!=') er=expr {
        //TODO, this needs to be looked at (can't recall compiler error off the top of my head)
        // if ($op.equals("<="))
        //     $i = $el.i <= $er.i;
        // else if ($op.equals("<"))
        //     $i = $el.i < $er.i;
        // else if ($op.equals(">="))
        //     $i = $el.i >= $er.i;
        // else if ($op.equals(">"))
        //     $i = $el.i > $er.i;
        // else if ($op.equals("=="))
        //     $i = $el.i == $er.i;
        // else // $op.equals("!=")
        //     $i = $el.i != $er.i;
    }
    //TODO, this needs to cast from double -> boolean -> double to interpret
    // | '!' e=expr { $i=($e.i!=0)?1:0; }
    // | el=expr op='&&' er=expr { $i=($el.i && $er.i; }
    // | el=expr op='||' er=expr { $i=$el.i || $er.i; }
    | INT { $i=Integer.parseInt($INT.text); }
    | '(' e=expr ')'
    | ID
    ;

BlockComment: '/*' .*? '*/' -> skip;
InlineComment: '#' .*? NL -> skip;

VAR: 'var'; // keyword

ID: [_A-Za-z]+;
INT: [0-9]+;
WS: [ \t\r\n]+ -> skip;
NL: [\n];
