public class IncDecNode extends NumNode {
    
    public String op;
    public String id;
    public boolean isPrefix;

    public IncDecNode(String op, String id, boolean isPrefix) {
        this.op = op;
        this.id = id;
        this.isPrefix = isPrefix;
    }
}