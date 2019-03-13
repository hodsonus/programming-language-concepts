package CtrlNodes;

import ValueNodes.NumNode;
import Core.ProgramState;
import Exceptions.*;

public class ReturnNode extends CtrlNode {

    public NumNode val;

    public ReturnNode(NumNode val) {
        this.val = val;
    }

    @Override
    public double eval(ProgramState ps) throws CustomGrammarException {
        ps.setLast(val.eval(ps));
        return val.eval(ps);
    }

    @Override
    public String toString() {
        return "return " + val.toString();
    }
}