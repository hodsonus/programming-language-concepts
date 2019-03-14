package CtrlNodes;

import java.util.ArrayList;

import Core.ExprNode;
import Core.ProgramState;
import Exceptions.CustomGrammarException;
import Exceptions.ReturnInProgressException;
import ValueNodes.AssNode;

public class FxnRootNode extends CtrlNode {

    public ArrayList<ExprNode> exprs;
    public ArrayList<String> argNames;

    public FxnRootNode(ArrayList<ExprNode> exprs, ArrayList<String> argNames) {
        this.exprs = exprs;
        this.argNames = argNames;
    }

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException {
        Double currVal;
        ExprNode currExpr;
        for (int i = 0; i < exprs.size(); i++) {
            currExpr = exprs.get(i);
            currVal = currExpr.eval(ps);
            if (!(currExpr instanceof AssNode) && currVal != null) {
                System.out.println(currVal);
            }
        }
        return null;
    }
}
