package CtrlNodes;

import Core.ProgramState;
import Exceptions.CustomGrammarException;
import Exceptions.ReturnInProgressException;

public class HaltNode extends CtrlNode {

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException {
        System.exit(0);
        return null; //never reached
    }
    
    @Override
    public String toString() {
        return "halt";
    }
}