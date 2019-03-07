package NumNodes;

public class ValNode extends NumNode {

    public double val;

    public ValNode(double val) {
        this.val = val;
    }

    @Override
    public String toString() {
        return String.valueOf(val);
    }
}
