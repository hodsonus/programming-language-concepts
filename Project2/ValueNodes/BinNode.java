package ValueNodes;

import Exceptions.*;
import Core.ProgramState;

public class BinNode extends NumNode {

    public NumNode nl, nr;
    public String op;

    public BinNode(NumNode nl, String op, NumNode nr) {
        this.nl = nl;
        this.nr = nr;
        this.op = op;
    }

    private double silentEval(ProgramState ps) throws CustomGrammarException  {
        double vl = nl.eval(ps), vr = nr.eval(ps);
        switch(op)  {
            case "+": return vl+vr;
            case "-": return vl-vr;
            case "*": return vl*vr;
            case "/": return vl/vr;
            case "%": return vl%vr;
            case ">": return (vl>vr)?1:0;
            case "<": return (vl<vr)?1:0;
            case ">=": return (vl>=vr)?1:0;
            case "<=": return (vl<=vr)?1:0;
            case "==": return (vl==vr)?1:0;
            case "!=": return (vl!=vr)?1:0;
            case "&&": return ((vl!=0)&&(vr!=0))?1:0;
            case "||": return ((vl!=0)||(vr!=0))?1:0;
            case "^": return Math.pow(vl,vr);
            default: throw new UnknownOpException(op);
        }
    }

    @Override
    public double eval(ProgramState ps) throws CustomGrammarException {
        double retVal = silentEval(ps);
        ps.setLast(retVal);
        return retVal;
    }

    @Override
    public void print(ProgramState ps) throws CustomGrammarException {
        System.out.print(silentEval(ps));
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
