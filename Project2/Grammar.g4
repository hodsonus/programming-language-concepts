grammar Grammar;

/* TODO

    search through the document and complete all TODO that exist

    implement the RETURN keyword ???????????
      there is some other stuff that needs to be implemented like this im sure that I cannot think of off the top of my head
      consult the docs to determine that I think

*/

@header {
    import Core.*;
    import CtrlNodes.*;
    import ValueNodes.*;
    import java.util.LinkedList;
    import java.util.ArrayList;
}

@members {
    RootASTNode root = new RootASTNode();
}

allExpr returns [RootASTNode i]: 
    (NL|';')*(topExpr (NL|';')+)*(EOF) {
    $i = root;
};

topExpr:
    e=expr {
        root.children.add($e.i);
    };

expr returns [ExprNode i]:
      c=ctrl {
        $i = $c.i;
    }
    | n=num {
        $i = $n.i;
    };

printExpr returns [PrintNode i]:
    'print' pL=printList {
        ArrayList<ValueNode> lis = new ArrayList($pL.i);
        $i = new PrintNode(lis);
    };

printList returns [LinkedList<ValueNode> i]:
      n=num ',' pL=printList {
        LinkedList<ValueNode> partSolvedList = $pL.i;
        partSolvedList.push($n.i);
        $i = partSolvedList;
    }
    | str=STRING ',' pL=printList {
        LinkedList<ValueNode> partSolvedList = $pL.i;
        String temp = $str.text.substring(1,$str.text.length()-1);
        // temp = temp.replace("\\n","\n").replace("\\t","\t").replace("\\r","\r");
        partSolvedList.push(new StringNode(temp));
        $i = partSolvedList;
    }
    | n=num {
        LinkedList<ValueNode> retList = new LinkedList<ValueNode>();
        retList.push($n.i);
        $i = retList;
    }
    | str=STRING {
        LinkedList<ValueNode> retList = new LinkedList<ValueNode>();
        String temp = $str.text.substring(1,$str.text.length()-1);
        // temp = temp.replace("\\n","\n").replace("\\t","\t").replace("\\r","\r");
        retList.push(new StringNode(temp));
        $i = retList;
    };

































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
    }
    | p=printExpr {
        $i = $p.i;
    };








exprList returns [LinkedList<ExprNode> i]:
      e=expr (';'|NL)+ eL=exprList {
        LinkedList<ExprNode> partSolvedList = $eL.i;
        partSolvedList.push($e.i);
        $i = partSolvedList;
    }
    | e=expr { 
        LinkedList<ExprNode> retList = new LinkedList<ExprNode>();
        retList.push($e.i);
        $i = retList;
    };

bracketedExprs returns [ArrayList<ExprNode> i]:
      '{' (';'|NL)* eL=exprList (';'|NL)* '}' {
        $i = new ArrayList($eL.i);
    };

whileLoop returns [WhileNode i]:
      'while(' n=num ')' ('\r'?'\n')? brackExpr=bracketedExprs {
        $i = new WhileNode($n.i, new ArrayList($brackExpr.i));
    }
    | 'while(' n=num ')' ('\r'?'\n')? e=expr {
        ArrayList<ExprNode> lis = new ArrayList<ExprNode>();
        lis.add($e.i);
        $i = new WhileNode($n.i, lis);
    };




// TODO, the spacing after the condition may not be correct ?? I think that with how we skip whitespace it is valid to have the parentheses right next to the statements, like 'if(1)2+3;'
// This, of course, applies to the while loops, for loops, and defineFxns too
// im not sure if we even care about this corner case, it doesnt seem THAT bad and it would result in a lot of reworking delimiters I think
ifStatement returns [IfNode i]:
      'if(' n=num ')' ifExpL=exprList 'else' elseExpL=exprList {
        $i = new IfNode($n.i, new ArrayList($ifExpL.i), new ArrayList($elseExpL.i));
    }
    | 'if(' n=num ')' ifExpL=exprList {
        $i = new IfNode($n.i, new ArrayList($ifExpL.i), null);
    };

//TODO, should the below variable 'n1' be of type assign instead of num ? not really sure what to do with that
forLoop returns [ForNode i]:
      'for(' n1=num ';' n2=num ';' n3=num ')' expL=exprList {
        $i = new ForNode($n1.i, $n2.i, $n3.i, new ArrayList($expL.i));
    };

// consult the documentation above exprList to understand why we use LinkedList instead of ArrayList or Stack here
defineFxn returns [CtrlNode i]:
      'define' ID'(' fAL=fxnArgList ')' expL=exprList {
        $i = new DefineFxnNode($ID.getText(), new ArrayList($fAL.i), new ArrayList($expL.i));
    };
    
fxnArgList returns [LinkedList<String> i]:
      ID ',' fAL=fxnArgList {
        LinkedList<String> partSolvedList = $fAL.i;
        partSolvedList.push($ID.getText());
        $i = partSolvedList;
    }
    | ID {
        LinkedList<String> retList = new LinkedList<String>();
        retList.push($ID.getText());
        $i = retList;
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
        $i = new ConstNode(  Double.parseDouble($NUM.getText())  );
    };

fxn returns [FxnNode i]:
      ID '(' numList=numArgList ')' {
         ArrayList<NumNode> solvedList = new ArrayList($numList.i);
         $i = new FxnNode($ID.getText(), solvedList);
    };
numArgList returns [LinkedList<NumNode> i]:
      n=num ',' nl=numArgList {
        LinkedList<NumNode> partSolvedList = $nl.i;
        partSolvedList.push($n.i);
        $i = partSolvedList;
    }
    | n=num {
        LinkedList<NumNode> retList = new LinkedList<NumNode>();
        retList.push($n.i);
        $i = retList;
    };

parens returns [NumNode i]:
      '(' n=num ')' {
        $i = $n.i;
    };

uniArith returns [NumNode i]:
      op=('++'|'--') ID {
        $i = new SelfAssNode($ID.getText(), $op.getText(), true);
    }
    | ID op=('++'|'--') {
        $i = new SelfAssNode($ID.getText(), $op.getText(), false);
    }
    | op='-' n=num {
        $i = new UniNode($n.i, $op.getText());
    };

assign returns [AssNode i]:
      ID op=('='|'+='|'-='|'*='|'/=') n=num {
        $i = new AssNode($ID.getText(), $op.getText(), $n.i);
    };

uniLogic returns [UniNode i]:
      op='!' n=num {
        $i = new UniNode($n.i, $op.getText());
    };

BLOCK: '/*'.*?'*/' -> skip;
// INLINE: '#'.*NL -> skip;
INLINE: '#'~[\r\n]* -> skip;

STRING: '"'.*?'"';
ID: [a-z]+[_]*[a-z]*;
NUM: ([0-9]+|[0-9]*'.'[0-9]*);

WS: [ \t]+ -> skip;
NL: [\r]?[\n];

/* TODO, this stuff still needs to get implemented somewhere
expr returns [double i]:
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