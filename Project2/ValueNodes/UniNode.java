package ValueNodes;

public class UniNode extends NumNode {

    public NumNode n;
    public String op;

    public UniNode(NumNode n, String op) {
        this.n = n;
        this.op = op;
    }

    @Override
    public String toString() {
        return (op + n.toString());
    }
}
