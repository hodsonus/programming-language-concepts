package Exceptions;

public class CustomGrammarException extends Exception {

    String msg;

    public CustomGrammarException() {
        this.msg = "";
    }

    public CustomGrammarException(String msg) {
        this.msg = msg;
    }

    @Override
    public String toString() {
        return "CustomGrammarException: " + msg;
    }

}
