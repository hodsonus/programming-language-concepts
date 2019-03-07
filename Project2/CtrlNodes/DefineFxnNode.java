package CtrlNodes;

import Core.ExprNode;

import java.util.ArrayList;

public class DefineFxnNode extends CtrlNode {

    public String name;
    public ArrayList<String> args;
    public ArrayList<ExprNode> expressions;

    public DefineFxnNode(String name, ArrayList<String> args, ArrayList<ExprNode> expressions) {
        this.name = name;
        this.args = args;
        this.expressions = expressions;
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        rep.append("define ");
        rep.append(name);
        rep.append("(");
        for (String arg : args) {
            rep.append(arg);
            rep.append(", ");
        }
        rep.delete(rep.length()-2, rep.length()); //remove the last ", " from the representation
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
