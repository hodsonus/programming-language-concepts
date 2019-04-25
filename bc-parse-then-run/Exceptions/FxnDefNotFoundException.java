package Exceptions;

public class FxnDefNotFoundException extends CustomGrammarException {

    public FxnDefNotFoundException() {
        super();
    }

    public FxnDefNotFoundException(String msg) {
        super(msg);
    }

    @Override
    public String toString() {
        return "FxnDefNotFoundException: " + msg;
    }

}
