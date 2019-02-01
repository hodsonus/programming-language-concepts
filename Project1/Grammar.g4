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
//   - Special Expression: read and sqrt
// X - Statements: expressions (print value on the screen when executed), print expressions
// X - Math library functions: s, c, l, e (no need for a and j)

grammar Grammar;

@header {
    // parser members
    import java.util.HashMap;
    import java.util.Scanner;
}

@members {
    // lexer members
    HashMap<String, Double> glob = new HashMap<String, Double>();
    Scanner sc = new Scanner(System.in);
}

exprList: (topExpr ((';'|NL)+|EOF))+;

topExpr: e=expr { if (!$e.sP) System.out.println(Double.toString($e.i)); } ;

expr returns [double i, boolean sP]:
    'read()' {
        $i = sc.nextDouble();
        $sP = false;
    }
    | 'sqrt' '(' e=expr ')' {
        $i = Math.sqrt($e.i);
        $sP = false;
    }
    | fxn=('s'|'c'|'l'|'e') '(' e=expr ')' {
        if($fxn.getText().equals("s"))
            $i = Math.sin($e.i);
        else if($fxn.getText().equals("c"))
            $i = Math.cos($e.i);
        else if($fxn.getText().equals("l"))
          $i = Math.log($e.i); //log=ln in math library
        else // $fxn.getText().equals("e")
          $i = Math.exp($e.i); //exp = e^x in math library
        $sP = false;
    }
    | op=('++'|'--') ID {
        String key = $ID.getText();
        if($op.getText().equals("++"))
            $i = glob.get(key)+1;
        else
            $i = glob.get(key)-1;
        glob.put(key, $i);
        $sP = false;
    }
    | ID op=('++'|'--') {
        String key = $ID.getText();
        $i = glob.get(key);
        if($op.getText().equals("++"))
            glob.put(key, $i+1);
        else
            glob.put(key, $i-1);
        $sP = false;
    }
    | '-' e=expr { 
        $i= -$e.i; 
        $sP = false;
    }
    | el=expr op='^' er=expr {
        $i=Math.pow($el.i,$er.i);
        $sP = false;
    }
    | el=expr op=('*'|'/'|'%') er=expr {
        if ($op.getText().equals("*"))
            $i=$el.i*$er.i;
        else if ($op.getText().equals("%"))
            $i=$el.i%$er.i;
        else
            $i=$el.i/$er.i;
        $sP = false;
    }
    | el=expr op=('+'|'-') er=expr {
        if ($op.getText().equals("+"))
            $i=$el.i+$er.i;
        else
            $i=$el.i-$er.i;
        $sP = false;
    }
    | ID '=' e=expr {
        String key = $ID.getText();
        double val = $e.i;
        glob.put(key,val);
        $i = val;
        $sP = true;
    }
    | el=expr op=( '<=' |'<'|'>='|'>'|'=='|'!=') er=expr {
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
        $sP = false;
    }
    | '!' e=expr {
        $i= ($e.i != 0) ? 0:1;
        $sP = false;
    }
    | el=expr op='&&' er=expr {
        $i= (($el.i != 0) && ($er.i != 0)) ? 1:0;
        $sP = false;
    }
    | el=expr op='||' er=expr {
        $i= (($el.i != 0) || ($er.i != 0)) ? 1:0;
        $sP = false;
    }
    | INT {
        $i=Integer.parseInt($INT.text);
        $sP = false;
    }
    | '(' e=expr ')' {
        $i = $e.i;
        $sP = false;
    }
    | ID {
        String key = $ID.getText();
        Double val = glob.get(key);
        $i = (val == null) ? 0 : val;
        $sP = false;
    }
    ;

BLOCK_COMMENT: '/*'.*?'*/' -> skip;
INLINE_COMMENT: '#'.*?~[\r\n]* -> skip; //TODO, come back to this if we have time

// TOOD, what is this stuff??
varDef: VAR ID '=' expr;
VAR: 'var'; // keyword
// END TODO

ID: [_A-Za-z]+;
INT: [0-9]+;
WS: [ \t]+ -> skip;
NL: [\r]?[\n];