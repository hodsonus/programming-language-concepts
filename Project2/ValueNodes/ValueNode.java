package ValueNodes;

import Core.ExprNode;
import Core.ProgramState;
import Exceptions.*;

public abstract class ValueNode extends ExprNode {

    public abstract void print(ProgramState ps) throws CustomGrammarException;

}