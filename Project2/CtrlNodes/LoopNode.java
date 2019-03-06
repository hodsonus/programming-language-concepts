package CtrlNodes;

import Core.ExprNode;
import NumNodes.NumNode;

import java.util.ArrayList;

public abstract class LoopNode extends CtrlNode {
    NumNode condition;
    ArrayList<ExprNode> expressions;
}
