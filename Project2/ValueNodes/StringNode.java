package ValueNodes;

public class StringNode extends ValueNode {

    public String str;

    public StringNode(String str) {
        this.str = str;
    }

    @Override
    public String toString() {
        return "\"" + str + "\"";
    }
}