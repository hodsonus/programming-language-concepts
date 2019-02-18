import java.util.HashMap;
import java.util.Scanner;

public class Grammar {

    // global containers/utilities
    public HashMap<String, Double> glob;
    public Scanner scnr;

    // global options
    private boolean opPrintEnabled;

    public Grammar() {
        this.glob = new HashMap<String, Double>();
        this.scnr = new Scanner(System.in);
        this.restoreOptionsDefault();
    }

    public void restoreOptionsDefault() {
        this.setOpPrintEnabled(true);
    }

    public void updateLastResultVar(double x) { this.glob.put("last", x); }

    public void printResultIfEnabled(double var_val) {
        if (this.opPrintEnabled) {
            System.out.println(Double.toString(var_val));
        }
    }

    public void setOpPrintEnabled(boolean op) { this.opPrintEnabled = op; }


    /* Operator Handlers -- consider pulling these functions out into a static library? */


    /* TODO: we may need to distinguish preincrement and postincrement for P2 */
    public double handleIncrementDecrement(String oper, String var_name) {
        Double var_val = this.glob.get(var_name);
        var_val = (var_val == null) ? 0 : var_val;
        if(oper.equals("++")) var_val++;
        else if (oper.equals("--")) var_val--;
        else throw new IllegalArgumentException("invalid operator string");
        this.glob.put(var_name, var_val);
        this.opPrintEnabled = true;
        return var_val;
    }

    public double handleMultiAssignment(String oper, String var_name, double modifier) {
        Double var_val = this.glob.get(var_name);
        var_val = (var_val == null) ? 0 : var_val;
        if (oper.equals("=")) var_val = modifier;
        else if (oper.equals("+=")) var_val += modifier;
        else if (oper.equals("-=")) var_val -= modifier;
        else if (oper.equals("*=")) var_val *= modifier;
        else if (oper.equals("/=")) var_val /= modifier;
        else throw new IllegalArgumentException("invalid operator string");
        this.glob.put(var_name, var_val);
        this.opPrintEnabled = false;
        return var_val;
    }

    public double handleComparator(String oper, double left, double right) {
        double res = 0;
        if (oper.equals("<=")) res = (left <= right) ? 1:0;
        else if (oper.equals("<")) res = (left < right) ? 1:0;
        else if (oper.equals(">=")) res = (left >= right) ? 1:0;
        else if (oper.equals(">")) res = (left > right) ? 1:0;
        else if (oper.equals("==")) res = (left == right) ? 1:0;
        else if (oper.equals("!=")) res = (left != right) ? 1:0;
        else throw new IllegalArgumentException("invalid operator string");
        this.opPrintEnabled = true;
        return res;
    }

}
