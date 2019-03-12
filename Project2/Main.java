import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

import Core.RootASTNode;

public class Main {
    public static void main(String[] args) throws Exception {
        System.out.println();
        GrammarLexer lexer = new GrammarLexer(new ANTLRFileStream("test.bc"));
        GrammarParser parser = new GrammarParser(new CommonTokenStream(lexer));
        
        RootASTNode tree = parser.allExpr().i;

        System.out.println(tree);
    }
}
