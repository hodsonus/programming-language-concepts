grammar Grammar;

@header {
    // imports
    // import java.util.HashMap;
    // import java.util.Scanner;
    // import java.util.InputMismatchException;
    import java.util.*;
    // import AssNode.java;
    // import ASTNode.java;
    // import BinNode.java;
    // import FxnNode.java;
    // import IDNode.java;
    // import IncDecNode.java;
    // import NumNode.java;
    // import UniNode.java;
    // import ValNode.java;
}

@members {

}

/*
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
    }; */

num returns [NumNode i]:
     fxn
    | parens
    | uniArith
    | nl=num op1='^' nm=num op2='^' nr=num {
        $i = new BinNode($nl.i, $op1.getText(), new BinNode($nm.i, $op2.getText(), $nr.i));
    }
    | nl=num op='^' nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    }
    | nl=num op=('*'|'/'|'%') nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    }
    | nl=num op=('+'|'-') nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    }
    | assign
    | nl=num op=('<=' |'<'|'>='|'>'|'=='|'!=') nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    }
    | uniLogic
    | nl=num op='&&' nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    }
    | nl=num op='||' nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    }
    | ID {
        $i = new IDNode(  $ID.getText()  );
    }
    | NUM {
        $i = new ValNode(  Double.parseDouble($NUM.getText())  );
    };

fxn returns [NumNode i]:
     ID '(' numList=numArgList ')' {
         ArrayList<NumNode> solvedArr = $numList.i;
         Collections.reverse(solvedArr);
         $i = new FxnNode($ID.getText(), solvedArr);
    };
numArgList returns [ArrayList<NumNode> i]:
      n=num ',' nl=numArgList {
        ArrayList<NumNode> partSolvedArr = $nl.i;
        partSolvedArr.add($n.i);
        $i = partSolvedArr;
    }
    | n=num {
        ArrayList<NumNode> retList = new ArrayList<NumNode>();
        retList.add($n.i);
        $i = retList;
    };

parens returns [NumNode i]:
      '(' n=num ')' {
        $i = $n.i;
    };

uniArith returns [NumNode i]:
      op=('++'|'--') ID {
        $i = new IncDecNode($op.getText(), $ID.getText(), true);
    }
    | ID op=('++'|'--') {
        $i = new IncDecNode($op.getText(), $ID.getText(), false);
    }
    | op='-' n=num {
        $i = new UniNode($n.i, $op.getText());
    };

binArith returns [NumNode i]:
    nl=num op1='^' nm=num op2='^' nr=num {
        $i = new BinNode($nl.i, $op1.getText(), new BinNode($nm.i, $op2.getText(), $nr.i));
    }
    | nl=num op='^' nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    }
    | nl=num op=('*'|'/'|'%') nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    }
    | nl=num op=('+'|'-') nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    };

assign returns [NumNode i]:
    ID op=('='|'+='|'-='|'*='|'/=') n=num {
        $i = new AssNode($ID.getText(), $op.getText(), $n.i);
    };

binRelat returns [NumNode i]:
    nl=num op=('<=' |'<'|'>='|'>'|'=='|'!=') nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    };

uniLogic returns [NumNode i]:
      op='!' n=num {
        $i = new UniNode($n.i, $op.getText());
    };

binLogic returns [NumNode i]:
      nl=num op='&&' nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    }
    | nl=num op='||' nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    };


BLOCK: '/*'.*?'*/' -> skip;
INLINE: '#'~[\r\n]* -> skip;

STRING: '"'.*?'"';
ID: [a-z]+[_]*[a-z]*;
NUM: ([0-9]+|[0-9]*'.'[0-9]*);
WS: [ \t]+ -> skip;
NL: [\r]?[\n];


/*
expr returns [double i]:
    'read()' {
        //implement the print statement above
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
    | NUM {
        $i = Double.parseDouble($NUM.text);
        _print_enabled = true;
    }
    | ID {
        String key = $ID.getText();
        Double val = GLOB.get(key);
        $i = (val == null) ? 0 : val;
        _print_enabled = true;
    }; */