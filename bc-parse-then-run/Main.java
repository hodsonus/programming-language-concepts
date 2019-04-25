import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

import Core.ProgramState;
import Core.RootASTNode;

public class Main {
    public static void main(String[] args) throws Exception {
        // General Features
        GrammarLexer lexer = new GrammarLexer(new ANTLRFileStream("tests.bc"));
        GrammarParser parser = new GrammarParser(new CommonTokenStream(lexer));
        RootASTNode tree = parser.allExpr().i;
        System.out.println("=========================STANDARD PROGRAM OUTPUT=========================");
        tree.eval(new ProgramState());
        System.out.println("===========================================================================\n\n");
        // Extra Credit
        lexer = new GrammarLexer(new ANTLRFileStream("const-val-prop.bc"));
        parser = new GrammarParser(new CommonTokenStream(lexer));
        tree = parser.allExpr().i;
        System.out.println("=========================CVP PARSE TREE=========================");
        System.out.println(tree);
        System.out.println("===========================================================================");
        System.out.println("=========================CVP PROGRAM OUTPUT=========================");
        tree.eval(new ProgramState());
        System.out.println("===========================================================================");
    }
}