package Exceptions;

public class InvalidNumArgsException extends CustomGrammarException {

    public InvalidNumArgsException() {
        super();
    }

    public InvalidNumArgsException(String msg) {
        super(msg);
    }

    @Override
    public String toString() {
        return "InvalidNumArgsException: " + msg;
    }

}
