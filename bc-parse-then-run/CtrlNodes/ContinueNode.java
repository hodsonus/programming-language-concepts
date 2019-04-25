package CtrlNodes;

import Core.ProgramState;
import Exceptions.CustomGrammarException;
import Exceptions.ReturnInProgressException;
import Exceptions.ContinueInProgressException;

public class ContinueNode extends CtrlNode {

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException, ContinueInProgressException {
        throw new ContinueInProgressException();
    }
    
    @Override
    public String toString() {
        return "continue";
    }
}