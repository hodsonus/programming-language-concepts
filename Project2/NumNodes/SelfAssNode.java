package NumNodes;

public class SelfAssNode extends AssNode {

    public boolean isPrefix;

    public SelfAssNode(String id, String op, boolean isPrefix) {
        super(id, op, new IDNode(id));
        this.isPrefix = isPrefix;
    }
}
