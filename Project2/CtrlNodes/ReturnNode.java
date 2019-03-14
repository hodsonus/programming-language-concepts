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
    public Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException {
        Double returnVal = val.eval(ps);
        ps.setLast(returnVal);
        throw new ReturnInProgressException(returnVal);
    }

    @Override
    public String toString() {
        return "return " + val.toString();
    }
}