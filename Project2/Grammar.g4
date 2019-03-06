grammar Grammar;

/* TODO

    At the moment, we should probably implement some toString methods or printouts in places to ensure the tree is generating correctly
    Then we need to write the evaluation of the tree

    search through the document and complete all TODO that exist

    implement the RETURN keyword ???????????
        there is some other stuff that needs to be implemented like this im sure that I cannot think of off the top of my head
        consult the docs to determine that I think
    
*/

@header {
    // imports
    import java.util.LinkedList;
    import java.util.ArrayList;
}

@members {
    RootASTNode root = new RootASTNode();
    Evaluator eval = new Evaluator();
}

allExpr: NL*(topExpr ((';'|NL)+|EOF))+ {
    //TODO, uncomment the abstract method in ASTNode.java and implement evaluation logic in the ASTNode subclasses??
    //eval.evaluate();
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

// the reason we use LinkedList is because they behave like a stack and the traversal makes intuitive sense
// for example, the following code:
    // lis = new LinkedList();
    // lis.push(b)
    // lis.push(a)
    // myArrLis = new ArrList(lis);
// produces myArrLis, an iterable arraylist that goes from a -> b
// this way we dont have to do any reverses, etc.
// the only thing we have to do once we get out of here is create the new arraylist object from the linkedlist object
// java stacks dont work
    // for whatever reason, they would produce a list that goes from b -> a
exprList returns [LinkedList<ExprNode> i]:
    e=expr DELIM eL=exprList {
        LinkedList<ExprNode> partSolvedList = $eL.i;
        partSolvedList.push($e.i);
        $i = partSolvedList;
    }
    e=expr {
        LinkedList<ExprNode> retList = new LinkedList<ExprNode>();
        retList.push($e.i);
        $i = retList;
    };

bracketedExprs returns [ArrayList<ExprNode> i]:
    '{' eL=exprList '}' {
        $i = new ArrayList($eL.i);
    };

//TODO, does print belong here?
//Our ctrl is literally the 'statement' in the BC docs. https://www.gnu.org/software/bc/manual/html_mono/bc.html#SEC15
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

whileLoop returns [WhileNode i]:
    'while(' n=num ')' expL=exprList {
        $i = new WhileNode($n.i, new ArrayList($expL.i));
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
        $i = new ValNode(  Double.parseDouble($NUM.getText())  );
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
        $i = new IncDecNode($op.getText(), $ID.getText(), true);
    }
    | ID op=('++'|'--') {
        $i = new IncDecNode($op.getText(), $ID.getText(), false);
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
INLINE: '#'~[\r\n]* -> skip;

//TODO, this should be any valid delimiter between expressions
DELIM: (';'|NL)+;

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