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
}