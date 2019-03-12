package ValueNodes;

public class AssNode extends NumNode {

    public String id, op;
    public NumNode n;

    public AssNode(String id, String op, NumNode n) {
        this.id = id;
        this.op = op;
        this.n = n;
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        rep.append(id);
        rep.append(" ");
        rep.append(op);
        rep.append(" ");
        rep.append(n.toString());
        return rep.toString();
    }
}
