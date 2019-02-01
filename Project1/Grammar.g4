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
//   - Basic expressions with variables
// X - Boolean Expressions
//   - Precedence
//   - Special Expression: read and sqrt
//   - Statements: expressions (print value on the screen when executed), print expressions
//   - Math library functions: s, c, l, e (no need for a and j)

grammar Grammar;

@header {
    // parser members
    import java.util.HashMap;
}

@members {
    // lexer members
    HashMap<String, Double> glob = new HashMap<String, Double>();
}

exprList: (topExpr ((';'|NL)+|EOF))+;

varDef: VAR ID '=' topExpr;

topExpr:
    e=altExpr { System.out.println(Double.toString($e.i)); }
    | e=altExpr
    | e=altExpr { System.out.println(Double.toString($e.i)); }
    ;

altExpr returns [double i]:
    pr=preExpr {$i=pr.$i}
    | as=assignExpr {$i=as.$i}
    | po=postExpr {$i=po.$i};

preExpr returns [double i]:
    op=('++'|'--') e=altExpr {
        if($op.getText().equals("++"))
            $i=++$e.i;
        else
            $i=--$e.i;
    }
    | e=altExpr op=('++'|'--') {
        if($op.getText().equals("++"))
            $i=$e.i++;
        else
            $i=$e.i--;
    }
    | '-' e=altExpr { $i= -$e.i; }
    | el=altExpr op='^' er=altExpr { $i=Math.pow($el.i,$er.i); }
    | el=altExpr op=('*'|'/'|'%') er=altExpr {
        if ($op.getText().equals("*"))
            $i=$el.i*$er.i;
        else if ($op.getText().equals("%"))
            $i=$el.i%$er.i;
        else
            $i=$el.i/$er.i;
    }
    | el=altExpr op=('+'|'-') er=altExpr {
        if ($op.getText().equals("+"))
            $i=$el.i+$er.i;
        else
            $i=$el.i-$er.i;
    }
    ;

assignExpr returns [double i]:
    ID '=' e=altExpr {
        String key = $ID.getText();
        double val = $e.i;
        glob.put(key,val);
        $i = val;
    }
    ;

postExpr returns [double i]:
    el=altExpr op=( '<=' |'<'|'>='|'>'|'=='|'!=') er=altExpr {
        if ($op.getText().equals("<="))
            $i = ($el.i <= $er.i) ? 1:0;
        else if ($op.getText().equals("<"))
            $i = ($el.i < $er.i) ? 1:0;
        else if ($op.getText().equals(">="))
            $i = ($el.i >= $er.i) ? 1:0;
        else if ($op.getText().equals(">"))
            $i = ($el.i > $er.i) ? 1:0;
        else if ($op.getText().equals("=="))
            $i = ($el.i == $er.i) ? 1:0;
        else // $op.getText().equals("!=")
            $i = ($el.i != $er.i) ? 1:0;
    }
    | '!' e=altExpr { $i= ($e.i!=0) ? 0:1; }
    | el=altExpr op='&&' er=altExpr { $i= (($el.i != 0) && ($er.i != 0)) ? 1:0; }
    | el=altExpr op='||' er=altExpr { $i= (($el.i != 0) || ($er.i != 0)) ? 1:0; }
    | INT { $i=Integer.parseInt($INT.text); }
    | '(' e=altExpr ')'
    | ID {
        String key = $ID.getText();
        Double val = glob.get(key);
        $i = (val == null) ? 0 : val;
    }
    ;

BLOCK_COMMENT: '/*'.*?'*/' -> skip;
INLINE_COMMENT: '#'.*?~[\r\n]* -> skip;

VAR: 'var'; // keyword

ID: [_A-Za-z]+;
INT: [0-9]+;
WS: [ \t]+ -> skip;
NL: [\r]?[\n];
