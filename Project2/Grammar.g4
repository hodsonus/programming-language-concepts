grammar Grammar;

/* TODO
    Do we need to implement these?
        Statements
            { statement_list }
                This is the compound statement. It allows multiple statements to be grouped together for execution.
            string
                The string is printed to the output. Strings start with a double quote character and contain all characters until the next double quote character. All characters are taken literally, including any newline. No newline character is printed after the string.
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
    (NL|';')*(topExpr ((';'|NL)+|EOF))* {
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
    | 'quit' {
        System.exit(0);
    }
    | 'return' n=num {
        $i = new ReturnNode($n.i);
    }
    | 'return' {
        $i = new ReturnNode(new ConstNode(0.0));
    }
    | 'break' {
        $i = new BreakNode();
    }
    | 'continue' {
        $i = new ContinueNode();
    }
    | 'halt' {
        $i = new HaltNode();
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
    }
    | '{' (';'|NL)* '}' {
        $i = new ArrayList<ExprNode>();
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
        $i = new IfNode($n.i, $ifExpL.i, new ArrayList<ExprNode>());
    };

forLoop returns [ForNode i]:
      'for' '(' n1=num ';' n2=num ';' n3=num ')' NL? bExp=bothExpr {
        $i = new ForNode($n1.i, $n2.i, $n3.i, $bExp.i);
    };

defineFxn returns [CtrlNode i]:
      'define' ID '(' fAL=fxnArgList ')' NL? bExp=bothExpr {
        $i = new FxnDefNode($ID.getText(), new ArrayList($fAL.i), $bExp.i);
    }
    | 'define' ID '(' ')' NL? bExp=bothExpr {
        $i = new FxnDefNode($ID.getText(), new ArrayList<String>(), $bExp.i);
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
    | op='-' n=num {
        NumNode numeric = $n.i;
        if (numeric instanceof ConstNode) {
            ConstNode constNumeric = (ConstNode)numeric;
            $i = new ConstNode(-1*constNumeric.val);
        }
        else {
            $i = new UniNode($n.i, $op.getText());
        }
    }
    /* binary arithmetic */
    | nl=num op1='^' nm=num op2='^' nr=num {
        NumNode left = $nl.i;
        NumNode mid = $nm.i;
        NumNode right = $nr.i;
        if (left instanceof ConstNode && mid instanceof ConstNode && right instanceof ConstNode) {
            ConstNode constLeft  = (ConstNode)left;
            ConstNode constMid   = (ConstNode)mid;
            ConstNode constRight = (ConstNode)right;
            $i = new ConstNode(Math.pow(constLeft.val, Math.pow(constMid.val, constRight.val)));
        }
        else {
            $i = new BinNode($nl.i, $op1.getText(), new BinNode($nm.i, $op2.getText(), $nr.i));
        }
    }
    | nl=num op='^' nr=num {
        NumNode left = $nl.i;
        NumNode right = $nr.i;
        if (left instanceof ConstNode && right instanceof ConstNode) {
            ConstNode constLeft = (ConstNode)left;
            ConstNode constRight = (ConstNode)right;
            $i = new ConstNode(Math.pow(constLeft.val, constRight.val));
        }
        else {
            $i = new BinNode(left, $op.getText(), right);
        }
    }
    | nl=num op=('*'|'/'|'%') nr=num {
        NumNode left = $nl.i;
        NumNode right = $nr.i;
        String op = $op.getText();
        if (left instanceof ConstNode && right instanceof ConstNode) {
            ConstNode constLeft = (ConstNode)left;
            ConstNode constRight = (ConstNode)right;
            Double val;
            if (  op.equals("*")  ) {
                val = constLeft.val*constRight.val;
            }
            else if (  op.equals("/")  ) {
                val = constLeft.val/constRight.val;
            }
            else  { //op.equals("%")
                val = constLeft.val%constRight.val;
            }
            $i = new ConstNode(val);
        }
        else {
            $i = new BinNode($nl.i, op, $nr.i);
        }
    }
    | nl=num op=('+'|'-') nr=num {
        NumNode left = $nl.i;
        NumNode right = $nr.i;
        String op = $op.getText();
        if (left instanceof ConstNode && right instanceof ConstNode) {
            ConstNode constLeft = (ConstNode)left;
            ConstNode constRight = (ConstNode)right;
            Double val;
            if (  op.equals("+")  ) {
                val = constLeft.val+constRight.val;
            }
            else  { //op.equals("-")
                val = constLeft.val-constRight.val;
            }
            $i = new ConstNode(val);
        }
        else {
            $i = new BinNode($nl.i, op, $nr.i);
        }
    }
    | a=assign { $i = $a.i; }
    /* binary relations */
    | nl=num op=('<=' |'<'|'>='|'>'|'=='|'!=') nr=num {
        NumNode left = $nl.i;
        NumNode right = $nr.i;
        String op = $op.getText();
        if (left instanceof ConstNode && right instanceof ConstNode) {
            ConstNode constLeft = (ConstNode)left;
            ConstNode constRight = (ConstNode)right;
            int val;
            if (  op.equals("<=")  ) {
                val = (constLeft.val <= constRight.val) ? 1:0;
            }
            else if (  op.equals("<")  ) {
                val = (constLeft.val < constRight.val) ? 1:0;
            }
            else if (  op.equals(">=")  ) {
                val = (constLeft.val >= constRight.val) ? 1:0;
            }
            else if (  op.equals(">")  ) {
                val = (constLeft.val > constRight.val) ? 1:0;
            }
            else if (  op.equals("==")  ) {
                val = (constLeft.val == constRight.val) ? 1:0;
            }
            else  { //op.equals("!=")
                val = (constLeft.val != constRight.val) ? 1:0;
            }
            $i = new ConstNode(val);
        }
        else {
            $i = new BinNode($nl.i, op, $nr.i);
        }
    }
    | op='!' n=num {
        NumNode numeric = $n.i;
        if (numeric instanceof ConstNode) {
            ConstNode constNumeric = (ConstNode)numeric;
            $i = new ConstNode(   (constNumeric.val != 0) ? 0:1   );
        }
        else {
            $i = new UniNode($n.i, $op.getText());
        }
    }
    /* binary logic */
    | nl=num op='&&' nr=num {
        NumNode left = $nl.i;
        NumNode right = $nr.i;
        String op = $op.getText();
        if (left instanceof ConstNode && right instanceof ConstNode) {
            ConstNode constLeft = (ConstNode)left;
            ConstNode constRight = (ConstNode)right;
            
            $i = new ConstNode(   ((constLeft.val != 0) && (constRight.val != 0)) ? 1:0   );
        }
        else {
            $i = new BinNode($nl.i, op, $nr.i);
        }
    }
    | nl=num op='||' nr=num {
        NumNode left = $nl.i;
        NumNode right = $nr.i;
        String op = $op.getText();
        if (left instanceof ConstNode && right instanceof ConstNode) {
            ConstNode constLeft = (ConstNode)left;
            ConstNode constRight = (ConstNode)right;
            
            $i = new ConstNode(   ((constLeft.val != 0) || (constRight.val != 0)) ? 1:0   );
        }
        else {
            $i = new BinNode($nl.i, op, $nr.i);
        }
    }
    | ID {
        $i = new IDNode(  $ID.getText()  );
    }
    | NUM {
        $i = new ConstNode(  Double.parseDouble($NUM.getText())  );
    };

fxn returns [FxnCallNode i]:
      ID '(' ')' {
         ArrayList<NumNode> emptyArgsList = new ArrayList<NumNode>();
         $i = new FxnCallNode($ID.getText(), emptyArgsList);
    }
    | ID '(' numList=numArgList ')' {
         ArrayList<NumNode> solvedList = new ArrayList($numList.i);
         $i = new FxnCallNode($ID.getText(), solvedList);
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

uniArith returns [SelfAssNode i]:
      op=('++'|'--') ID {
        $i = new SelfAssNode($ID.getText(), $op.getText(), true);
    }
    | ID op=('++'|'--') {
        $i = new SelfAssNode($ID.getText(), $op.getText(), false);
    };

assign returns [AssNode i]:
      ID op=('='|'+='|'-='|'*='|'/=') n=num {
        $i = new AssNode($ID.getText(), $op.getText(), $n.i);
    };

BLOCK: '/*'.*?'*/' -> skip;
INLINE: '#'~[\r\n]* -> skip;

STRING: '"'.*?'"';
ID: [a-z]+[_]*[a-z]*;
NUM: ([0-9]+|[0-9]*'.'[0-9]*);

WS: [ \t]+ -> skip;
NL: [\r]?[\n];