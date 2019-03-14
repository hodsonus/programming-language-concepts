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
    public void print(ProgramState ps) throws CustomGrammarException, ReturnInProgressException {
        System.out.println(eval(ps));
    }

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException {
        ArrayList<Double> evaluated = new ArrayList<Double>();
        for(NumNode nn : args) {
            evaluated.add(nn.eval(ps));
        }
        Double val = ps.callFxn(fxnName, evaluated);
        return val;
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
        if (args.size() != 0) rep.delete(rep.length()-2, rep.length()); // remove trailing ", "
        rep.append(")");
        return rep.toString();
    }
}
