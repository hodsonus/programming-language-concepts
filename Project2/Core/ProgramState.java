package Core;

import Exceptions.*;

import java.util.Stack;
import java.util.HashMap;
import java.util.ArrayList;
import CtrlNodes.FxnRootNode;
import java.lang.Math;
import java.util.Scanner;
import java.lang.Double;

public class ProgramState {

    private HashMap<String, Double> globalVars;
    private Stack<HashMap<String, Double>> localVars;
    private HashMap<String, FxnRootNode> globalFxns; // only global

    public ProgramState() {
        this.globalVars = new HashMap<String, Double>();
        this.localVars = new Stack<HashMap<String, Double>>();
        this.globalFxns = new HashMap<String, FxnRootNode>();
    }

    private boolean isInGlobalScope() {
        // size: 0 = global, 1 = fxn call, 2 = nested call, etc.
        return (localVars.size() == 0);
    }

    public void setVar(String varName, double varValue) {
        if(isInGlobalScope()) {
            // name collisions with functions allowed
            globalVars.put(varName, new Double(varValue));
        } else {
            localVars.peek().put(varName, new Double(varValue));
        }
    }

    public void setLast(double varValue) {
        setVar("last", varValue);
    }

    public void setFxn(String fxnName, FxnRootNode fxn) throws CustomGrammarException {
        if(isInGlobalScope()) {
            globalFxns.put(fxnName, fxn);
        } else {
            throw new NestedFxnDefException(fxnName);
        }
    }

    public double getVar(String varName) {
        Double retVal = null;
        if(isInGlobalScope()) {
            // try global
            retVal = globalVars.get(varName);
        } else {
            // try local then global
            retVal = localVars.peek().get(varName);
            if(retVal == null)
                retVal = globalVars.get(varName);
        }
        if(retVal == null) {
            return 0; // default to 0
        }
        return retVal;
    }

    private Double tryStdLib(String fxnName, ArrayList<Double> args) throws CustomGrammarException {
        ArrayList<String> stdLib = new ArrayList<String>() {
            private static final long serialVersionUID = 1L;
            { add("s"); add("c"); add("l"); add("e"); add("sqrt"); add("read");}};
        // throw for fxn not found first
        if(!stdLib.contains(fxnName)) {
            throw new FxnDefNotFoundException(fxnName);
        }
        // then throw for invalid args
        boolean valid = (args.size() == 0 && fxnName.equals("read")) ||
            (args.size() == 1 && !fxnName.equals("read"));
        if(!valid) {
            if(fxnName.equals("read"))
                throw new InvalidNumArgsException(fxnName + " found " + args.size() + " expected 0");
            else
                throw new InvalidNumArgsException(fxnName + " found " + args.size() + " expected 1");
        }
        switch(fxnName)  {
            case "s": return Math.sin(args.get(0));
            case "c": return Math.cos(args.get(0));
            case "l": return Math.log(args.get(0));
            case "e": return Math.exp(args.get(0));
            case "sqrt": return Math.sqrt(args.get(0));
            case "read":
                Scanner sc = new Scanner(System.in);
                double retVal = sc.nextDouble();
                sc.close();
                return retVal;
            // redundant throw not found for default
            default: throw new FxnDefNotFoundException(fxnName);
        }
    }

    public double callFxn(String fxnName, ArrayList<Double> args) throws CustomGrammarException {
        FxnRootNode fxnRoot = globalFxns.get(fxnName);
        Double retVal = null;
        if(fxnRoot == null) {
            retVal = tryStdLib(fxnName, args);
        } else {
            if(args.size() != fxnRoot.argNames.size()) {
                throw new InvalidNumArgsException(
                    fxnName + " found " + args.size() + " expected " + fxnRoot.argNames.size());
            }
            localVars.push(new HashMap<String, Double>());
            for(int i = 0; i < args.size(); i++) {
                // unpack local args
                setVar(fxnRoot.argNames.get(i), args.get(i));
            }
            try {
                fxnRoot.eval(this); // recursion support
            } catch (ReturnInProgressException e) {
                retVal = e.getRetVal();
            }
            localVars.pop();
        }
        return retVal;
    }
}
