package Exceptions;

public class BreakInProgressException extends Exception {

    private static final long serialVersionUID = 9117022471196403803L;
    private String msg;

    public BreakInProgressException() {
        this("");
    }

    public BreakInProgressException(String msg) {
        super(msg);
    }

    @Override
    public String toString() {
        return "BreakInProgressException: " + msg;
    }
}