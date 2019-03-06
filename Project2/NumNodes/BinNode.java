package NumNodes;

public class BinNode extends NumNode {

    public NumNode nl, nr;
    public String op;

    public BinNode(NumNode nl, String op, NumNode nr) {
        this.nl = nl;
        this.nr = nr;
        this.op = op;
    }
}
