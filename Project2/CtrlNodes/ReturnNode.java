package CtrlNodes;

import ValueNodes.NumNode;

public class ReturnNode extends CtrlNode {

    public NumNode val;

    public ReturnNode(NumNode val) {
        this.val = val;
    }

    @Override 
    public String toString() {
        return "return " + val.toString();
    }
}