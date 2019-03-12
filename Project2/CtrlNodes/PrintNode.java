package CtrlNodes;

import java.util.ArrayList;
import ValueNodes.ValueNode;

public class PrintNode extends CtrlNode {

    public ArrayList<ValueNode> lis;

    public PrintNode(ArrayList<ValueNode> lis) {
        this.lis = lis;
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        rep.append("print ");
        for (ValueNode val : lis) {
            rep.append(val.toString());
            rep.append(", ");
        }
        rep.delete(rep.length()-2, rep.length()); //remove the last ", " from the representation
        return rep.toString();
    }
}