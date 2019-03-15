package CtrlNodes;

import Core.ProgramState;
import Exceptions.CustomGrammarException;
import Exceptions.ReturnInProgressException;
import Exceptions.BreakInProgressException;

public class BreakNode extends CtrlNode {

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException, BreakInProgressException {
        throw new BreakInProgressException();
    }
    
    @Override
    public String toString() {
        return "break";
    }
}