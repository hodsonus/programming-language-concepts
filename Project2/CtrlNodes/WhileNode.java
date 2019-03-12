package CtrlNodes;

import Core.ExprNode;
import ValueNodes.NumNode;

import java.util.ArrayList;

public class WhileNode extends LoopNode {

    public WhileNode(NumNode condition, ArrayList<ExprNode> expressions) {
        this.condition = condition;
        this.expressions = expressions;
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
