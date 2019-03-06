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
}
