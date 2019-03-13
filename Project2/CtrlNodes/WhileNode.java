package CtrlNodes;

import Core.ExprNode;
import Core.ProgramState;
import Exceptions.CustomGrammarException;
import ValueNodes.NumNode;

import java.util.ArrayList;

public class WhileNode extends LoopNode {

    public WhileNode(NumNode condition, ArrayList<ExprNode> expressions) {
        this.condition = condition;
        this.expressions = expressions;
    }

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException {
        Double curVal;
        while (condition.eval(ps)!=0) {
            for (int i = 0; i < expressions.size(); i++) {
                curVal = expressions.get(i).eval(ps);
                if (curVal != null) {
                    System.out.println(curVal);
                }
            }
        }
        return null;
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        rep.append("while (");
        rep.append(condition.toString());
        rep.append(") {\n");
        for (ExprNode expr : expressions) {
            rep.append("\t");
            rep.append(expr.toString());
            rep.append("\n");
        }
        rep.append("}");
        return rep.toString();
    }
}
