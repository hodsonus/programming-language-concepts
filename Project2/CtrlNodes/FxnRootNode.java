package CtrlNodes;

import java.util.ArrayList;

import Core.ExprNode;
import Core.ProgramState;
import Exceptions.CustomGrammarException;
import Exceptions.ReturnInProgressException;

public class FxnRootNode extends CtrlNode {

    public ArrayList<ExprNode> exprs;
    public ArrayList<String> argNames;

    public FxnRootNode(ArrayList<ExprNode> exprs, ArrayList<String> argNames) {
        this.exprs = exprs;
        this.argNames = argNames;
    }

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException {
        Double curVal;
        for (int i = 0; i < exprs.size(); i++) {
            curVal = exprs.get(i).eval(ps);
            if (curVal != null) {
                System.out.println(curVal);
            }
        }
        return null;
    }
}
