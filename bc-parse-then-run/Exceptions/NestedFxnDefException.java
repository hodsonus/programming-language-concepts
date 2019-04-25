package Exceptions;

public class NestedFxnDefException extends CustomGrammarException {

    public NestedFxnDefException() {
        super();
    }

    public NestedFxnDefException(String msg) {
        super(msg);
    }

    @Override
    public String toString() {
        return "NestedFxnException: " + msg;
    }

}
