package CtrlNodes;

import java.util.ArrayList;
import ValueNodes.ValueNode;
import ValueNodes.NumNode;
import Core.ProgramState;
import Exceptions.*;

public class PrintNode extends CtrlNode {

    public ArrayList<ValueNode> lis;

    public PrintNode(ArrayList<ValueNode> lis) {
        this.lis = lis;
    }

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException, ContinueInProgressException, BreakInProgressException {
        for(ValueNode vn : lis) {
            vn.print(ps);
        }
        if(lis.get(lis.size()-1) instanceof NumNode) {
            ps.setLast(lis.get(lis.size()-1).eval(ps));
        }
        System.out.println();
        return null;
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