package ValueNodes;

import Core.ProgramState;
import Exceptions.*;
public class ConstNode extends NumNode {

    public double val;

    public ConstNode(double val) {
        this.val = val;
    }

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException {
        ps.setLast(val);
        return val;
    }

    @Override
    public void print(ProgramState ps) throws CustomGrammarException {
        System.out.print(val);
    }

    @Override
    public String toString() {
        return String.valueOf(val);
    }
}
