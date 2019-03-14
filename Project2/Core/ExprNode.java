package Core;

import Exceptions.CustomGrammarException;
import Exceptions.ReturnInProgressException;

public abstract class ExprNode extends ASTNode {

    public abstract Double eval(ProgramState ps) throws CustomGrammarException, ReturnInProgressException;

}
