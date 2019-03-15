package CtrlNodes;

import Core.ExprNode;
import Core.ProgramState;
import Exceptions.BreakInProgressException;
import Exceptions.ContinueInProgressException;
import Exceptions.CustomGrammarException;
import Exceptions.ReturnInProgressException;
import ValueNodes.AssNode;
import ValueNodes.NumNode;

import java.util.ArrayList;

public class WhileNode extends LoopNode {

    public WhileNode(NumNode condition, ArrayList<ExprNode> expressions) {
        this.condition = condition;
        this.expressions = expressions;
    }

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException, ContinueInProgressException, BreakInProgressException {
        Double currVal;
        ExprNode currExpr;
        while (condition.eval(ps)!=0) {
            try {
                for (int i = 0; i < expressions.size(); i++) {
                        currExpr = expressions.get(i);
                        currVal = currExpr.eval(ps);
                        if (!(currExpr instanceof AssNode) && currVal != null) {
                            System.out.println(currVal);
                        }
                }
            }
            catch (BreakInProgressException e) {
                break;
            }
        }
        return null;
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        rep.append("while (");
        rep.append(condition.toString());
        rep.append(") {\n");
        for (ExprNode expr : expressions) {
            rep.append("\t");
            rep.append(expr.toString());
            rep.append("\n");
        }
        rep.append("}");
        return rep.toString();
    }
}
