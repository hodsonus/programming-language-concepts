package Core;

import java.util.List;
import java.util.ArrayList;

public class RootASTNode extends ASTNode {

    public List<ExprNode> children;

    public RootASTNode() {
        children = new ArrayList<ExprNode>();
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        for (ExprNode child : children) {
            rep.append(child.toString());
            rep.append("\n");
        }
        rep.delete(rep.length()-"\n".length(), rep.length());
        return rep.toString();
    }
}
