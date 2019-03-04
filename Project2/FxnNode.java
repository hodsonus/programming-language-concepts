import java.util.ArrayList;

public class FxnNode extends NumNode {

    public String fxnName;
    public ArrayList<NumNode> args;

    public FxnNode(String fxnName, ArrayList<NumNode> args) {
        this.fxnName = fxnName;
        this.args = args;
    }
}