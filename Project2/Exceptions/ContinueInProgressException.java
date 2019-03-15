package Exceptions;

public class ContinueInProgressException extends Exception {

    private static final long serialVersionUID = 9117022471196403803L;
    private String msg;

    public ContinueInProgressException() {
        this("");
    }

    public ContinueInProgressException(String msg) {
        super(msg);
    }

    @Override
    public String toString() {
        return "ContinueInProgressException: " + msg;
    }
}