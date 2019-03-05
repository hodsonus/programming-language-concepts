import java.util.List;
import java.util.ArrayList;

public class RootASTNode extends ASTNode {

    public List<ExprNode> children;

    public RootASTNode() {
        children = new ArrayList<ExprNode>();
    }
}