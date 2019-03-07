package NumNodes;

public class BinNode extends NumNode {

    public NumNode nl, nr;
    public String op;

    public BinNode(NumNode nl, String op, NumNode nr) {
        this.nl = nl;
        this.nr = nr;
        this.op = op;
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        rep.append(nl.toString());
        rep.append(" ");
        rep.append(op);
        rep.append(" ");
        rep.append(nr.toString());
        return rep.toString();
    }
}
