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

public class IfNode extends CtrlNode {

    NumNode condition;
    ArrayList<ExprNode> ifExpressions, elseExpressions;

    public IfNode(NumNode condition, ArrayList<ExprNode> ifExpressions, ArrayList<ExprNode> elseExpressions) {
        this.condition = condition;
        this.ifExpressions = ifExpressions;
        this.elseExpressions = elseExpressions;
    }

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException, ContinueInProgressException, BreakInProgressException {
        Double currVal;
        ExprNode currExpr;
        if (condition.eval(ps)!=0) {
            for (int i = 0; i < ifExpressions.size(); i++) {
                currExpr = ifExpressions.get(i);
                currVal = currExpr.eval(ps);
                if (!(currExpr instanceof AssNode) && currVal != null) {
                    System.out.println(currVal);
                }
            }
        }
        else {
            for (int i = 0; i < elseExpressions.size(); i++) {
                currExpr = elseExpressions.get(i);
                currVal = currExpr.eval(ps);
                if (!(currExpr instanceof AssNode) && currVal != null) {
                    System.out.println(currVal);
                }
            }
        }
        return null;
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        rep.append("if (");
        rep.append(condition.toString());
        rep.append(") {\n");
        for (ExprNode expr : ifExpressions) {
            rep.append("\t");
            rep.append(expr.toString());
            rep.append("\n");
        }
        rep.append("}");
        if (elseExpressions != null) {
            rep.append("\nelse {\n");
            for (ExprNode expr : elseExpressions) {
                rep.append("\t");
                rep.append(expr.toString());
                rep.append("\n");
            }
            rep.append("}");
        }
        return rep.toString();
    }
}
