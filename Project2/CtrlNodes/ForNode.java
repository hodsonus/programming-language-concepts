package CtrlNodes;

import Core.ExprNode;
import NumNodes.NumNode;

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
