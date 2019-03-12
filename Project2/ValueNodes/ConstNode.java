package ValueNodes;

public class ConstNode extends NumNode {

    public double val;

    public ConstNode(double val) {
        this.val = val;
    }

    @Override
    public String toString() {
        return String.valueOf(val);
    }
}
