package Core;

import java.util.List;
import java.util.ArrayList;
import Exceptions.*;

public class RootASTNode extends ASTNode {

    public List<ExprNode> children;

    public RootASTNode() {
        children = new ArrayList<ExprNode>();
    }

    @Override
    public double eval(ProgramState ps) throws CustomGrammarException {
        for(ExprNode c : children) c.eval(ps);
        return 0;
    }

    @Override
    public String toString() {
        if (children.size() == 0) return "";
        StringBuilder rep = new StringBuilder();
        for (ExprNode child : children) {
            rep.append(child.toString());
            rep.append("\n");
        }
        rep.delete(rep.length()-"\n".length(), rep.length());
        return rep.toString();
    }
}
