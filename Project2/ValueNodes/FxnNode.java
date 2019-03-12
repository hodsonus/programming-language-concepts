package ValueNodes;

import java.util.ArrayList;

public class FxnNode extends NumNode {

    public String fxnName;
    public ArrayList<NumNode> args;

    public FxnNode(String fxnName, ArrayList<NumNode> args) {
        this.fxnName = fxnName;
        this.args = args;
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        rep.append(fxnName);
        rep.append("(");
        for (NumNode arg : args) {
            rep.append(arg.toString());
            rep.append(", ");
        }
        rep.delete(rep.length()-2, rep.length()); //remove the last ", " from the representation
        rep.append(")");
        return rep.toString();
    }
}
