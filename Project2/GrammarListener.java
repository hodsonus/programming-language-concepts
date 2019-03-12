// Generated from Grammar.g4 by ANTLR 4.7.2

    import Core.*;
    import CtrlNodes.*;
    import ValueNodes.*;
    import java.util.LinkedList;
    import java.util.ArrayList;

import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link GrammarParser}.
 */
public interface GrammarListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link GrammarParser#allExpr}.
	 * @param ctx the parse tree
	 */
	void enterAllExpr(GrammarParser.AllExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#allExpr}.
	 * @param ctx the parse tree
	 */
	void exitAllExpr(GrammarParser.AllExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#topExpr}.
	 * @param ctx the parse tree
	 */
	void enterTopExpr(GrammarParser.TopExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#topExpr}.
	 * @param ctx the parse tree
	 */
	void exitTopExpr(GrammarParser.TopExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(GrammarParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(GrammarParser.ExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#printExpr}.
	 * @param ctx the parse tree
	 */
	void enterPrintExpr(GrammarParser.PrintExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#printExpr}.
	 * @param ctx the parse tree
	 */
	void exitPrintExpr(GrammarParser.PrintExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#printList}.
	 * @param ctx the parse tree
	 */
	void enterPrintList(GrammarParser.PrintListContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#printList}.
	 * @param ctx the parse tree
	 */
	void exitPrintList(GrammarParser.PrintListContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#ctrl}.
	 * @param ctx the parse tree
	 */
	void enterCtrl(GrammarParser.CtrlContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#ctrl}.
	 * @param ctx the parse tree
	 */
	void exitCtrl(GrammarParser.CtrlContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#exprList}.
	 * @param ctx the parse tree
	 */
	void enterExprList(GrammarParser.ExprListContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#exprList}.
	 * @param ctx the parse tree
	 */
	void exitExprList(GrammarParser.ExprListContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#bracketedExprs}.
	 * @param ctx the parse tree
	 */
	void enterBracketedExprs(GrammarParser.BracketedExprsContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#bracketedExprs}.
	 * @param ctx the parse tree
	 */
	void exitBracketedExprs(GrammarParser.BracketedExprsContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#whileLoop}.
	 * @param ctx the parse tree
	 */
	void enterWhileLoop(GrammarParser.WhileLoopContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#whileLoop}.
	 * @param ctx the parse tree
	 */
	void exitWhileLoop(GrammarParser.WhileLoopContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#bothExpr}.
	 * @param ctx the parse tree
	 */
	void enterBothExpr(GrammarParser.BothExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#bothExpr}.
	 * @param ctx the parse tree
	 */
	void exitBothExpr(GrammarParser.BothExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#ifStatement}.
	 * @param ctx the parse tree
	 */
	void enterIfStatement(GrammarParser.IfStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#ifStatement}.
	 * @param ctx the parse tree
	 */
	void exitIfStatement(GrammarParser.IfStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#forLoop}.
	 * @param ctx the parse tree
	 */
	void enterForLoop(GrammarParser.ForLoopContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#forLoop}.
	 * @param ctx the parse tree
	 */
	void exitForLoop(GrammarParser.ForLoopContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#defineFxn}.
	 * @param ctx the parse tree
	 */
	void enterDefineFxn(GrammarParser.DefineFxnContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#defineFxn}.
	 * @param ctx the parse tree
	 */
	void exitDefineFxn(GrammarParser.DefineFxnContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#fxnArgList}.
	 * @param ctx the parse tree
	 */
	void enterFxnArgList(GrammarParser.FxnArgListContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#fxnArgList}.
	 * @param ctx the parse tree
	 */
	void exitFxnArgList(GrammarParser.FxnArgListContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#num}.
	 * @param ctx the parse tree
	 */
	void enterNum(GrammarParser.NumContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#num}.
	 * @param ctx the parse tree
	 */
	void exitNum(GrammarParser.NumContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#fxn}.
	 * @param ctx the parse tree
	 */
	void enterFxn(GrammarParser.FxnContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#fxn}.
	 * @param ctx the parse tree
	 */
	void exitFxn(GrammarParser.FxnContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#numArgList}.
	 * @param ctx the parse tree
	 */
	void enterNumArgList(GrammarParser.NumArgListContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#numArgList}.
	 * @param ctx the parse tree
	 */
	void exitNumArgList(GrammarParser.NumArgListContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#parens}.
	 * @param ctx the parse tree
	 */
	void enterParens(GrammarParser.ParensContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#parens}.
	 * @param ctx the parse tree
	 */
	void exitParens(GrammarParser.ParensContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#uniArith}.
	 * @param ctx the parse tree
	 */
	void enterUniArith(GrammarParser.UniArithContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#uniArith}.
	 * @param ctx the parse tree
	 */
	void exitUniArith(GrammarParser.UniArithContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#assign}.
	 * @param ctx the parse tree
	 */
	void enterAssign(GrammarParser.AssignContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#assign}.
	 * @param ctx the parse tree
	 */
	void exitAssign(GrammarParser.AssignContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#uniLogic}.
	 * @param ctx the parse tree
	 */
	void enterUniLogic(GrammarParser.UniLogicContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#uniLogic}.
	 * @param ctx the parse tree
	 */
	void exitUniLogic(GrammarParser.UniLogicContext ctx);
}