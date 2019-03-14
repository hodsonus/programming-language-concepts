package CtrlNodes;

import Core.ExprNode;
import Core.ProgramState;
import Exceptions.CustomGrammarException;
import Exceptions.ReturnInProgressException;
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
    public Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException {
        Double curVal;
        for (assignment.eval(ps); condition.eval(ps)!=0; update.eval(ps)) {
            for (int i = 0; i < expressions.size(); i++) {
                curVal = expressions.get(i).eval(ps);
                if (curVal != null) { 
                    System.out.println(curVal);
                }
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
