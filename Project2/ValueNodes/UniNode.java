package ValueNodes;

import Exceptions.*;
import Core.ProgramState;

public class UniNode extends NumNode {

    public NumNode n;
    public String op;

    public UniNode(NumNode n, String op) {
        this.n = n;
        this.op = op;
    }

    @Override
    public double eval(ProgramState ps) throws CustomGrammarException {
        double retVal = n.eval(ps);
        switch(op)  {
            case "-": return -retVal;
            case "!": return !(retVal!=0)?1:0;
            default: throw new UnknownOpException(op);
        }
    }

    @Override
    public void print(ProgramState ps) throws CustomGrammarException {
        System.out.print(eval(ps));
    }

    @Override
    public String toString() {
        return (op + n.toString());
    }
}
