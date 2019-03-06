package NumNodes;

public class AssNode extends NumNode {

    public String id, op;
    public NumNode n;

    public AssNode(String id, String op, NumNode n) {
        this.id = id;
        this.op = op;
        this.n = n;
    }
}
