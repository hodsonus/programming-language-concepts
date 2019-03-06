import java.util.ArrayList;

public class IfNode extends CtrlNode {

    NumNode condition;
    ArrayList<ExprNode> ifExpressions, elseExpressions;

    public IfNode(NumNode condition, ArrayList<ExprNode> ifExpressions, ArrayList<ExprNode> elseExpressions) {
        this.condition = condition;
        this.ifExpressions = ifExpressions;
        this.elseExpressions = elseExpressions;
    }
}