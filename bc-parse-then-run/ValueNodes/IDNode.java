package ValueNodes;

import Core.ProgramState;
import Exceptions.*;

public class IDNode extends NumNode {

    public String id;

    public IDNode(String id) {
        this.id = id;
    }

    @Override
    public Double eval(ProgramState ps) throws CustomGrammarException {
        double retVal = ps.getVar(id);
        ps.setLast(retVal);
        return retVal;
    }

    @Override
    public void print(ProgramState ps) throws CustomGrammarException {
        System.out.print(ps.getVar(id));
    }

    @Override
    public String toString() {
        return id;
    }
}
