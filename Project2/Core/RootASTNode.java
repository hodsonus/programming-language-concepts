package Core;

import java.util.List;
import java.util.ArrayList;
import Exceptions.*;

public class RootASTNode extends ASTNode {

    public List<ExprNode> children;

    public RootASTNode() {
        children = new ArrayList<ExprNode>();
    }

    public Double eval(ProgramState ps) throws CustomGrammarException {
        Double currVal;
        for(ExprNode c : children) {
            currVal = null;
            try {
                currVal = c.eval(ps);
            }
            catch (ReturnInProgressException e) {
                System.out.println("Return from main program.");
                System.exit(0);
            }
            if (currVal != null) {
                System.out.println(currVal);
            }
        }
        return null;
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
