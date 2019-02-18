grammar Grammar;

@members { Grammar G = new Grammar(); }

exprList: NL*(topExpr ((';'|NL)+|EOF))+;

topExpr:
    e=expr {
        G.updateLastResultVar($e.i);
        G.printResultIfEnabled($e.i);
        G.restoreOptionsDefault();
    };

expr returns [double i]:
    'print' epl=exprPrintList {
        System.out.println($epl.i);
        $i = 0; //don't care about return value since we print here.
        G.setOpPrintEnabled(false);
    }
    | 'read()' {
        try { $i = G.scnr.nextDouble(); }
        catch (InputMismatchException e) {
            System.out.println("Invalid paramater provided to read(), halting program...");
            System.exit(0);
        }
        G.setOpPrintEnabled(true);
    }
    | 'sqrt(' e=expr ')' {
        $i = Math.sqrt($e.i);
        G.setOpPrintEnabled(true);
    }
    | fxn=('s('|'c('|'l('|'e(') e=expr ')' {
        if($fxn.getText().equals("s("))
            $i = Math.sin($e.i);
        else if($fxn.getText().equals("c("))
            $i = Math.cos($e.i);
        else if($fxn.getText().equals("l("))
            $i = Math.log($e.i); // log=ln in math library
        else // $fxn.getText().equals("e(")
            $i = Math.exp($e.i); // exp = e^x in math library
        G.setOpPrintEnabled(true);
    }
    | op=('++'|'--') ID { $i = G.handleIncrementDecrement($op.getText(), $ID.getText()); }
    | ID op=('++'|'--') { $i = G.handleIncrementDecrement($op.getText(), $ID.getText()); }
    | '-' e=expr {
        $i= -$e.i;
        G.setOpPrintEnabled(true);
    }
    | el=expr op1='^' em=expr op2='^' er=expr {
        $i=Math.pow($el.i, Math.pow($em.i,$er.i));
        G.setOpPrintEnabled(true);
    }
    | el=expr op='^' er=expr {
        $i=Math.pow($el.i,$er.i);
        G.setOpPrintEnabled(true);
    }
    | el=expr op=('*'|'/'|'%') er=expr {
        if ($op.getText().equals("*"))
            $i=$el.i*$er.i;
        else if ($op.getText().equals("%"))
            $i=$el.i%$er.i;
        else {
            if ($er.i == 0) {
                System.out.println("Invalid paramater provided to division, halting program...");
                System.exit(0);
            }
            $i= $el.i/$er.i;
        }
        G.setOpPrintEnabled(true);
    }
    | el=expr op=('+'|'-') er=expr {
        if ($op.getText().equals("+"))
            $i=$el.i+$er.i;
        else
            $i=$el.i-$er.i;
        G.setOpPrintEnabled(true);
    }
    | ID op=('='|'+='|'-='|'*='|'/=') e=expr { G.handleMultiAssignment($op.getText(), $ID.getText(), $e.i); }
    | el=expr op=( '<=' |'<'|'>='|'>'|'=='|'!=') er=expr { G.handleComparator($op.getText(), $el.i, $er.i); }
    | '!' e=expr {
        $i = ($e.i != 0) ? 0:1;
        G.setOpPrintEnabled(true);
    }
    | el=expr op='&&' er=expr {
        $i= (($el.i != 0) && ($er.i != 0)) ? 1:0;
        G.setOpPrintEnabled(true);
    }
    | el=expr op='||' er=expr {
        $i= (($el.i != 0) || ($er.i != 0)) ? 1:0;
        G.setOpPrintEnabled(true);
    }
    | NUM {
        $i = Double.parseDouble($NUM.text);
        G.setOpPrintEnabled(true);
    }
    | '(' e=expr ')' {
        $i = $e.i;
        G.setOpPrintEnabled(true);
    }
    | ID {
        String key = $ID.getText();
        Double val = G.glob.get(key);
        $i = (val == null) ? 0 : val;
        G.setOpPrintEnabled(true);
    };

exprPrintList returns [String i]:
    e=expr ',' epl=exprPrintList {
        $i = Double.toString($e.i) + $epl.i;
    }
    | str=STRING ',' epl=exprPrintList {
        String temp = $str.text.substring(1,$str.text.length()-1);
        // temp = temp.replace("\\n","\n").replace("\\t","\t").replace("\\r","\r");
        $i = temp + $epl.i;
    }
    | e=expr {
        $i=Double.toString($e.i);
    }
    | str=STRING {
        String temp = $str.text.substring(1,$str.text.length()-1);
        //temp = temp.replace("\\n","\n").replace("\\t","\t").replace("\\r","\r");
        $i= temp;
    };

BLOCK: '/*'.*?'*/' -> skip;
INLINE: '#'~[\r\n]* -> skip;

STRING: '"'.*?'"';
ID: [a-z]+[_]*[a-z]*;
NUM: ([0-9]+|[0-9]*'.'[0-9]*);
WS: [ \t]+ -> skip;
NL: [\r]?[\n];
