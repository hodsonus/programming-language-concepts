grammar Grammar;

@header {
    // imports
    import java.util.HashMap;
    import java.util.Scanner;
    import java.util.InputMismatchException;
}

@members {
    // global containers/utils
    HashMap<String, Double> GLOB = new HashMap<String, Double>();
    Scanner SCNR = new Scanner(System.in);
    // global options
    boolean _print_enabled = true;
}

exprList: NL*(topExpr ((';'|NL)+|EOF))+;

topExpr:
    e=expr {
        // store last variable in symbol table
        GLOB.put("last", $e.i);

        // print if enabled
        if (_print_enabled) {
            String out = Double.toString($e.i);
            System.out.println(out);
        }

        // restore global state
        _print_enabled = true;
    };

expr returns [double i]:
    'print' epl=exprPrintList {
        System.out.println($epl.i);
        $i = 0; //don't care about return value since we print here.
        _print_enabled = false;
    }
    | 'read()' {
        try { $i = SCNR.nextDouble(); }
        catch (InputMismatchException e) {
            System.out.println("Invalid paramater provided to read(), halting program...");
            System.exit(0);
        }
        _print_enabled = true;
    }
    | 'sqrt(' e=expr ')' {
        $i = Math.sqrt($e.i);
        _print_enabled = true;
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
        _print_enabled = true;
    }
    | op=('++'|'--') ID {
        String key = $ID.getText();
        Double val = GLOB.get(key);
        if($op.getText().equals("++"))
            $i = ((val == null) ? 0 : val)+1;
        else
            $i = ((val == null) ? 0 : val)-1;
        GLOB.put(key, $i);
        _print_enabled = true;
    }
    | ID op=('++'|'--') {
        String key = $ID.getText();
        Double val = GLOB.get(key);
        $i = ((val == null) ? 0 : val);
        if($op.getText().equals("++"))
            GLOB.put(key, $i+1);
        else
            GLOB.put(key, $i-1);
        _print_enabled = true;
    }
    | '-' e=expr {
        $i= -$e.i;
        _print_enabled = true;
    }
    | el=expr op='^' er=expr {
        $i=Math.pow($el.i,$er.i);
        _print_enabled = true;
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
        _print_enabled = true;
    }
    | el=expr op=('+'|'-') er=expr {
        if ($op.getText().equals("+"))
            $i=$el.i+$er.i;
        else
            $i=$el.i-$er.i;
        _print_enabled = true;
    }
    | ID '=' e=expr {
        String key = $ID.getText();
        double val = $e.i;
        GLOB.put(key,val);
        $i = val;
        _print_enabled = false;
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
        _print_enabled = true;
    }
    | '!' e=expr {
        $i= ($e.i != 0) ? 0:1;
        _print_enabled = true;
    }
    | el=expr op='&&' er=expr {
        $i= (($el.i != 0) && ($er.i != 0)) ? 1:0;
        _print_enabled = true;
    }
    | el=expr op='||' er=expr {
        $i= (($el.i != 0) || ($er.i != 0)) ? 1:0;
        _print_enabled = true;
    }
    | NUM {
        $i = Double.parseDouble($NUM.text);
        _print_enabled = true;
    }
    | '(' e=expr ')' {
        $i = $e.i;
        _print_enabled = true;
    }
    | ID {
        String key = $ID.getText();
        Double val = GLOB.get(key);
        $i = (val == null) ? 0 : val;
        _print_enabled = true;
    };
    
exprPrintList returns [String i]:
    e=expr {
        $i=Double.toString($e.i);
    }
    | e=expr ',' epl=exprPrintList {
        $i = Double.toString($e.i) + $epl.i;
    }
    | str=STRING ',' epl=exprPrintList {
        $i = $str.text.substring(1,$str.text.length()-1) + $epl.i;
    };

BLOCK: '/*'.*?'*/' -> skip;
INLINE: '#'~[\r\n]* -> skip;

STRING: '"'.*?'"';
ID: [a-z]+[_]*[a-z]*;
NUM: ([0-9]+|[0-9]*'.'[0-9]*);
WS: [ \t]+ -> skip;
NL: [\r]?[\n];
