package CtrlNodes;

import Core.ExprNode;
import Core.ProgramState;
import Exceptions.CustomGrammarException;
import Exceptions.ReturnInProgressException;

import java.util.ArrayList;

public class FxnDefNode extends CtrlNode {

    public String name;
    public ArrayList<String> argNames;
    public ArrayList<ExprNode> exprs;

    public FxnDefNode(String name, ArrayList<String> argNames, ArrayList<ExprNode> exprs) {
        this.name = name;
        this.argNames = argNames;
        this.exprs = exprs;
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
        throw new ReturnInProgressException(new Double(0));
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        rep.append("define ");
        rep.append(name);
        rep.append("(");
        for (String arg : argNames) {
            rep.append(arg);
            rep.append(", ");
        }
        rep.delete(rep.length()-2, rep.length()); //remove the last ", " from the representation
        rep.append(") {\n");
        for (ExprNode expr : exprs) {
            rep.append("\t");
            rep.append(expr.toString());
            rep.append("\n");
        }
        rep.append("}");
        return rep.toString();
    }
}
