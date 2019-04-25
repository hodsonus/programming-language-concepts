package Exceptions;

public class UnknownOpException extends CustomGrammarException {

    public UnknownOpException() {
        super();
    }

    public UnknownOpException(String msg) {
        super(msg);
    }

    @Override
    public String toString() {
        return "UnknownOpException: " + msg;
    }

}
