package Exceptions;

public class ReturnInProgressException extends Exception {

    private static final long serialVersionUID = 8828697654908369921L;
    private Double returnVal;

    public ReturnInProgressException (Double returnVal) {
        this.returnVal = returnVal;
    }

    public Double getRetVal() {
        return returnVal;
    }
}