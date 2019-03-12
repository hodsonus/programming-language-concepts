grammar Grammar;

/* TODO

    search through the document and complete all TODO that exist

    Every program MUST terminate in either a newline or a semicolon. This includes braces, they must be followed be one of these.


    Do we need to implement these?
        Statements
            { statement_list }
                This is the compound statement. It allows multiple statements to be grouped together for execution.
            string
                The string is printed to the output. Strings start with a double quote character and contain all characters until the next double quote character. All characters are taken literally, including any newline. No newline character is printed after the string.
            break
                This statement causes a forced exit of the most recent enclosing while statement or for statement.
            continue
                The continue statement (an extension) causes the most recent enclosing for statement to start the next iteration.
            halt
                The halt statement (an extension) is an executed statement that causes the bc processor to quit only when it is executed. For example, "if (0 == 1) halt" will not cause bc to terminate because the halt is not executed.
        Pseudo Statements
            quit
                When the quit statement is read, the bc processor is terminated, regardless of where the quit statement is found. For example, "if (0 == 1) quit" will cause bc to terminate.
    
    Necessary to implement:
        sqrt()
        read()
        s()
        c()
        l()
        e()
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
    }
    | 'return' n=num {
        $i = new ReturnNode($n.i);
    }
    | 'return' {
        $i = new ReturnNode(new ConstNode(0.0));
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
     'while' '(' n=num ')' NL? bExpr=bothExpr {
        $i = new WhileNode($n.i, $bExpr.i);
    };

bothExpr returns [ArrayList<ExprNode> i]: 
    brackExpr=bracketedExprs {
        $i = new ArrayList($brackExpr.i);
    }
    | e=expr {
        ArrayList<ExprNode> lis = new ArrayList<ExprNode>();
        lis.add($e.i);
        $i = lis;
    };

ifStatement returns [IfNode i]:
      'if' '(' n=num ')' NL? ifExpL=bothExpr 'else' NL? elseExpL=bothExpr {
        $i = new IfNode($n.i, $ifExpL.i, $elseExpL.i);
    }
    | 'if' '(' n=num ')' NL? ifExpL=bothExpr {
        $i = new IfNode($n.i, $ifExpL.i, null);
    };

forLoop returns [ForNode i]:
      'for' '(' n1=num ';' n2=num ';' n3=num ')' NL? bExp=bothExpr {
        $i = new ForNode($n1.i, $n2.i, $n3.i, $bExp.i);
    };

defineFxn returns [CtrlNode i]:
      'define' ID '(' fAL=fxnArgList ')' NL? bExp=bothExpr {
        $i = new DefineFxnNode($ID.getText(), new ArrayList($fAL.i), $bExp.i);
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
INLINE: '#'~[\r\n]* -> skip;

STRING: '"'.*?'"';
ID: [a-z]+[_]*[a-z]*;
NUM: ([0-9]+|[0-9]*'.'[0-9]*);

WS: [ \t]+ -> skip;
NL: [\r]?[\n];