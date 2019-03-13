package ValueNodes;

import java.util.ArrayList;
import Exceptions.*;
import Core.ProgramState;

public class FxnCallNode extends NumNode {

    public String fxnName;
    public ArrayList<NumNode> args;

    public FxnCallNode(String fxnName, ArrayList<NumNode> args) {
        this.fxnName = fxnName;
        this.args = args;
    }

    @Override
    public void print(ProgramState ps) throws CustomGrammarException {
        System.out.println(eval(ps));
    }

    @Override
    public double eval(ProgramState ps) throws CustomGrammarException {
        // TODO figure out how to get last in higher level function call
        ArrayList<Double> evaluated = new ArrayList<Double>();
        for(NumNode nn : args) {
            evaluated.add(nn.eval(ps));
        }
        ps.callFxn(fxnName, evaluated);
        return 0; // TODO return function value?
    }

    @Override
    public String toString() {
        StringBuilder rep = new StringBuilder();
        rep.append(fxnName);
        rep.append("(");
        for (NumNode arg : args) {
            rep.append(arg.toString());
            rep.append(", ");
        }
        rep.delete(rep.length()-2, rep.length()); // remove trailing ", "
        rep.append(")");
        return rep.toString();
    }
}
