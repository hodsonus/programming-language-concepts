package NumNodes;

public class SelfAssNode extends AssNode {

    public boolean isPrefix;

    public SelfAssNode(String id, String op, boolean isPrefix) {
        super(id, op, new IDNode(id));
        this.isPrefix = isPrefix;
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        if (isPrefix) {
            rep.append(op);
        }
        rep.append(id);
        if (!isPrefix) {
            rep.append(op);
        }
        return rep.toString();
    }
}
