package Core;

import Exceptions.*;
import java.util.Stack;
import java.util.HashMap;
import java.util.ArrayList;
import CtrlNodes.FxnDefNode;
import java.lang.Math;
import java.util.Scanner;
import java.lang.Double;

public class ProgramState {

    private HashMap<String, Double> globalVars;
    private Stack<HashMap<String, Double>> localVars;
    private HashMap<String, FxnDefNode> globalFxns; // only global
    private final ArrayList<String> stdLib = new ArrayList<String>() {{
        add("s"); add("c"); add("l"); add("e");
        add("sqrt"); add("read");
    }};

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
        setLast(varValue);
    }

    public void setFxn(String fxnName, FxnDefNode fnxDef) {
        if(isInGlobalScope()) {
            // name collisions with variables allowed
            globalFxns.put(fxnName, fnxDef);
        } else {
            throw new NestedFxnDefException();
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

    private Double tryStdLib(String fxnName, ArrayList<Double> args) throws GrammarException {
        // throw for fxn not found first
        if(!stdLib.contains(fxnName)) {
            throw new FxnDefNotFoundException();
        }
        // then throw for invalid args
        boolean valid = (args.size() == 0 && fxnName.equals("read")) ||
            (args.size() == 1 && !fxnName.equals("read"));
        if(!valid) {
            throw new InvalidNumArgsException();
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
            default: throw new FxnDefNotFoundException();
        }
    }

    public double callFxn(String fxnName, ArrayList<Double> args) throws GrammarException {
        FxnDefNode fxnDef = globalFxns.get(fxnName);
        Double retVal = null;
        if(fxnDef == null) {
            retVal = tryStdLib(fxnName, args);
        }
        if(args.size() != fxnDef.argNames.size()) {
            throw new InvalidNumArgsException();
        }
        localVars.push(new HashMap<String, DefineFxnNode>());
        for(int i = 0; i < args.size(); i++) {
            // unpack local args
            setVar(fxnDef.argNames.get(i), args.get(i));
        }
        retVal = fxnDef.eval(this); // recursion
        localVars.pop();
        return retVal;
    }

}
