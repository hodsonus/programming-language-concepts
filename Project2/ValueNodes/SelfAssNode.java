package ValueNodes;

import Exceptions.*;
import Core.ProgramState;

public class SelfAssNode extends AssNode {

    public boolean isPrefix;

    public SelfAssNode(String id, String op, boolean isPrefix) {
        super(id, op, new IDNode(id));
        this.isPrefix = isPrefix;
    }

    private double silentEval(ProgramState ps) throws CustomGrammarException {
        double oldVal = ps.getVar(id), retVal = 0;
        if(op.equals("+")) {
            if(isPrefix) retVal = oldVal+1;
            else retVal = oldVal;
        } else if (op.equals("-")) {
            if(isPrefix) retVal = oldVal-1;
            else retVal = oldVal;
        } else {
            throw new UnknownOpException(op);
        }
        return retVal;
    }

    @Override
    public double eval(ProgramState ps) throws CustomGrammarException {
        // redundancy bc side effect is different than return value
        double oldVal = ps.getVar(id), retVal = 0;
        if(op.equals("+")) {
            if(isPrefix) retVal = oldVal+1;
            else retVal = oldVal;
            ps.setLast(oldVal+1);
        } else if (op.equals("-")) {
            if(isPrefix) retVal = oldVal-1;
            else retVal = oldVal;
            ps.setLast(oldVal-1);
        } else {
            throw new UnknownOpException(op);
        }
        return retVal;
    }

    @Override
    public void print(ProgramState ps) throws CustomGrammarException {
        System.out.print(silentEval(ps));
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        if (isPrefix) {
            rep.append(op);
        }
        rep.append(id);
        if (!isPrefix) {
            rep.append(op);
        }
        return rep.toString();
    }
}
