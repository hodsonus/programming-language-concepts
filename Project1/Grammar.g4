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
    int _output_length = 1;
    boolean _print_enabled = true;
    boolean _newline_enabled = true;
}

exprList: (topExpr ((';'|NL)+|EOF))+;

topExpr:
    e=expr {
        // store last variable in symbol table
        GLOB.put("last", $e.i);

        // print if enabled
        if (_print_enabled) {
            String out = Double.toString($e.i);
            out = out.substring(0, Math.min(out.length(), _output_length));
            if (_newline_enabled) out += "\n";
            System.out.print(out);
        }

        // restore GLOBal state
        _output_length = 1;
        _print_enabled = true;
        _newline_enabled = true;
    };

expr returns [double i, boolean sP]:
    'read()' {
        try { $i = SCNR.nextDouble(); }
        catch (InputMismatchException e) {
            System.out.println("Invalid paramater provided to read(), halting program...");
            System.exit(0);
        }
    }
    | 'sqrt' '(' e=expr ')' {
        $i = Math.sqrt($e.i);
    }
    | fxn=('s'|'c'|'l'|'e') '(' e=expr ')' {
        if($fxn.getText().equals("s"))
            $i = Math.sin($e.i);
        else if($fxn.getText().equals("c"))
            $i = Math.cos($e.i);
        else if($fxn.getText().equals("l"))
            $i = Math.log($e.i); // log=ln in math library
        else // $fxn.getText().equals("e")
            $i = Math.exp($e.i); // exp = e^x in math library
    }
    | op=('++'|'--') ID {
        String key = $ID.getText();
        if($op.getText().equals("++"))
            $i = GLOB.get(key)+1;
        else
            $i = GLOB.get(key)-1;
        GLOB.put(key, $i);
    }
    | ID op=('++'|'--') {
        String key = $ID.getText();
        $i = GLOB.get(key);
        if($op.getText().equals("++"))
            GLOB.put(key, $i+1);
        else
            GLOB.put(key, $i-1);
    }
    | '-' e=expr {
        $i= -$e.i;
    }
    | el=expr op='^' er=expr {
        $i=Math.pow($el.i,$er.i);
    }
    | el=expr op=('*'|'/'|'%') er=expr {
        if ($op.getText().equals("*"))
            $i=$el.i*$er.i;
        else if ($op.getText().equals("%"))
            $i=$el.i%$er.i;
        else
            $i=$el.i/$er.i;
    }
    | el=expr op=('+'|'-') er=expr {
        if ($op.getText().equals("+"))
            $i=$el.i+$er.i;
        else
            $i=$el.i-$er.i;
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
        _output_length = 1;
    }
    | '!' e=expr {
        $i= ($e.i != 0) ? 0:1;
        _output_length = 1;
    }
    | el=expr op='&&' er=expr {
        $i= (($el.i != 0) && ($er.i != 0)) ? 1:0;
        _output_length = 1;
    }
    | el=expr op='||' er=expr {
        $i= (($el.i != 0) || ($er.i != 0)) ? 1:0;
        _output_length = 1;
    }
    | INT {
        $i = Integer.parseInt($INT.text);
        _output_length = $INT.text.length();
        if($INT.text.contains(".")) _output_length--;
        if($INT.text.contains("-")) _output_length--;
    }
    | '(' e=expr ')' {
        $i = $e.i;
    }
    | ID {
        String key = $ID.getText();
        Double val = GLOB.get(key);
        $i = (val == null) ? 0 : val;
    }
    ;

BLOCK: '/*'.*?'*/' -> skip;
INLINE: '#'.*?~[\r\n]* -> skip;

ID: [_A-Za-z]+;
INT: [0-9]+;
WS: [ \t]+ -> skip;
NL: [\r]?[\n];
