package ValueNodes;

import Exceptions.*;
import Core.ProgramState;

public class StringNode extends ValueNode {

    public String str;

    public StringNode(String str) {
        this.str = str;
    }

    @Override
    public void print(ProgramState ps) throws CustomGrammarException {
        System.out.print(str);
    }

    @Override
    public String toString() {
        return "\"" + str + "\"";
    }
}