grammar Grammar;

@header {
    // imports
    import java.util.Collections;
}

@members {
    RootASTNode root = new RootASTNode();
}

allExpr: NL*(topExpr ((';'|NL)+|EOF))+ {
    //TODO, uncomment the abstract method in ASTNode.java and implement evaluation logic in the ASTNode subclasses??
    //root.evaluate();
};

topExpr:
    e=expr {
        root.children.add($e.i);
    };

expr returns [ASTNode i]:
      c=ctrl {
        $i = $c.i;
    }
    | n=num {
        $i = $n.i;
    };





















































//TODO, does print belong here?
ctrl returns [CtrlNode i]:
      ifs=ifStatement {
        $i = $ifs.i;
    }
    | w=whileLoop { 
        $i = $w.i;
    }
    | f=forLoop { 
        $i = $f.i;
    }
    | d=defineFxn { 
        $i = $d.i;
    };

ifStatement returns [CtrlNode i]:
    // TODO, the spacing after the condition may not be correct ??
      'if(' n=num ')' ifExpL=exprList 'else' elseExpL=exprList {

    }
    | 'if(' n=num ')' expL=exprList {

    };

//TODO
whileLoop returns [CtrlNode i]:
    'while(' n=num ')' expL=exprList {

    };

//TODO
forLoop returns [CtrlNode i]:
    'for(' n1=num ';' n2=num ';' n3=num ')' expL=exprList {
        
    };

//TODO
defineFxn returns [CtrlNode i]:
    'define' ID'(' fAL=fxnArgList ')' expL=exprList {

    };

fxnArgList returns []:
    {};


//TODO, THIS SHOULD PEEL OFF brackets and return some kind of node that represents either one expr or a list of them. variable number of children on this node, each of which is an expression.
exprList returns [ExprListNode i]:
    e=expr {

    }
    e=expr {

    };



























































num returns [NumNode i]:
      f=fxn { $i = $f.i; }
    | p=parens { $i = $p.i; }
    | uA=uniArith { $i = $uA.i; }
    /* binary arithmetic */
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
    | a=assign { $i = $a.i; }
    /* binary relations */
    | nl=num op=('<=' |'<'|'>='|'>'|'=='|'!=') nr=num {
        $i = new BinNode($nl.i, $op.getText(), $nr.i);
    }
    | uL=uniLogic { $i = $uL.i; }
    /* binary logic */
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

assign returns [NumNode i]:
      ID op=('='|'+='|'-='|'*='|'/=') n=num {
        $i = new AssNode($ID.getText(), $op.getText(), $n.i);
    };

uniLogic returns [NumNode i]:
      op='!' n=num {
        $i = new UniNode($n.i, $op.getText());
    };

BLOCK: '/*'.*?'*/' -> skip;
INLINE: '#'~[\r\n]* -> skip;

STRING: '"'.*?'"';
ID: [a-z]+[_]*[a-z]*;
NUM: ([0-9]+|[0-9]*'.'[0-9]*);

WS: [ \t]+ -> skip;
NL: [\r]?[\n];


/* TODO, this stuff still needs to get implemented somewhere
expr returns [double i]:
    'print' epl=exprPrintList {
        System.out.println($epl.i);
        $i = 0; //don't care about return value since we print here.
        _print_enabled = false;
    }
    | 'read()' {
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
    }; */