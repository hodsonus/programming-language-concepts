package ValueNodes;

import Exceptions.*;
import Core.ProgramState;

public class AssNode extends NumNode {

    public String id, op;
    public NumNode n;

    public AssNode(String id, String op, NumNode n) {
        this.id = id;
        this.op = op;
        this.n = n;
    }

    private double silentEval(ProgramState ps) throws CustomGrammarException {
        double retVal = ps.getVar(id);
        double val = n.eval(ps);
        switch(op) {
            case "+=": return retVal+val;
            case "-=": return retVal-val;
            case "*=": return retVal*val;
            case "/=": return retVal/val;
            case "%=": return retVal%val;
            case "&=": return ((retVal!=0)&&(val!=0))?1:0;
            case "|=": return ((retVal!=0)||(val!=0))?1:0;
            default: throw new UnknownOpException(op);
        }
    }

    @Override
    public double eval(ProgramState ps) throws CustomGrammarException {
        double retVal = silentEval(ps);
        ps.setLast(silentEval(ps));
        return retVal;
    }

    @Override
    public void print(ProgramState ps) throws CustomGrammarException {
        System.out.print(silentEval(ps));
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
