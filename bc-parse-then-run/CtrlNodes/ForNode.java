package CtrlNodes;

import Core.ExprNode;
import Core.ProgramState;
import Exceptions.BreakInProgressException;
import Exceptions.ContinueInProgressException;
import Exceptions.CustomGrammarException;
import Exceptions.ReturnInProgressException;
import Exceptions.NestedFxnDefException;
import ValueNodes.AssNode;
import ValueNodes.NumNode;

import java.util.ArrayList;

public class ForNode extends LoopNode {

    NumNode assignment, update;

    public ForNode(NumNode assignment, NumNode condition, NumNode update, ArrayList<ExprNode> expressions) {
        this.assignment = assignment;
        this.condition = condition;
        this.update = update;
        this.expressions = expressions;
    }

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException, ContinueInProgressException, BreakInProgressException {
        Double currVal;
        ExprNode currExpr;
        for (assignment.eval(ps); condition.eval(ps)!=0; update.eval(ps)) {
            try {
                for (int i = 0; i < expressions.size(); i++) {
                    currExpr = expressions.get(i);
                    if(currExpr instanceof FxnDefNode) {
                        throw new NestedFxnDefException();
                    }
                    currVal = currExpr.eval(ps);
                    if (!(currExpr instanceof AssNode) && currVal != null) {
                        System.out.println(currVal);
                    }
                }
            }
            catch (ContinueInProgressException e) {
                continue;
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
        rep.append("for (");
        rep.append(assignment.toString());
        rep.append("; ");
        rep.append(condition.toString());
        rep.append("; ");
        rep.append(update.toString());
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
