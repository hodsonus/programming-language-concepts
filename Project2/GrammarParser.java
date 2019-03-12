// Generated from Grammar.g4 by ANTLR 4.7.2

    import Core.*;
    import CtrlNodes.*;
    import ValueNodes.*;
    import java.util.LinkedList;
    import java.util.ArrayList;

import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class GrammarParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.7.2", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, T__15=16, T__16=17, 
		T__17=18, T__18=19, T__19=20, T__20=21, T__21=22, T__22=23, T__23=24, 
		T__24=25, T__25=26, T__26=27, T__27=28, T__28=29, T__29=30, T__30=31, 
		T__31=32, T__32=33, T__33=34, T__34=35, BLOCK=36, INLINE=37, STRING=38, 
		ID=39, NUM=40, WS=41, NL=42;
	public static final int
		RULE_allExpr = 0, RULE_topExpr = 1, RULE_expr = 2, RULE_printExpr = 3, 
		RULE_printList = 4, RULE_ctrl = 5, RULE_exprList = 6, RULE_bracketedExprs = 7, 
		RULE_whileLoop = 8, RULE_bothExpr = 9, RULE_ifStatement = 10, RULE_forLoop = 11, 
		RULE_defineFxn = 12, RULE_fxnArgList = 13, RULE_num = 14, RULE_fxn = 15, 
		RULE_numArgList = 16, RULE_parens = 17, RULE_uniArith = 18, RULE_assign = 19, 
		RULE_uniLogic = 20;
	private static String[] makeRuleNames() {
		return new String[] {
			"allExpr", "topExpr", "expr", "printExpr", "printList", "ctrl", "exprList", 
			"bracketedExprs", "whileLoop", "bothExpr", "ifStatement", "forLoop", 
			"defineFxn", "fxnArgList", "num", "fxn", "numArgList", "parens", "uniArith", 
			"assign", "uniLogic"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "';'", "'print'", "','", "'return'", "'{'", "'}'", "'while'", "'('", 
			"')'", "'if'", "'else'", "'for'", "'define'", "'^'", "'*'", "'/'", "'%'", 
			"'+'", "'-'", "'<='", "'<'", "'>='", "'>'", "'=='", "'!='", "'&&'", "'||'", 
			"'++'", "'--'", "'='", "'+='", "'-='", "'*='", "'/='", "'!'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			"BLOCK", "INLINE", "STRING", "ID", "NUM", "WS", "NL"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "Grammar.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }


	    RootASTNode root = new RootASTNode();

	public GrammarParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class AllExprContext extends ParserRuleContext {
		public RootASTNode i;
		public TerminalNode EOF() { return getToken(GrammarParser.EOF, 0); }
		public List<TopExprContext> topExpr() {
			return getRuleContexts(TopExprContext.class);
		}
		public TopExprContext topExpr(int i) {
			return getRuleContext(TopExprContext.class,i);
		}
		public List<TerminalNode> NL() { return getTokens(GrammarParser.NL); }
		public TerminalNode NL(int i) {
			return getToken(GrammarParser.NL, i);
		}
		public AllExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_allExpr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterAllExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitAllExpr(this);
		}
	}

	public final AllExprContext allExpr() throws RecognitionException {
		AllExprContext _localctx = new AllExprContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_allExpr);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(45);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__0 || _la==NL) {
				{
				{
				setState(42);
				_la = _input.LA(1);
				if ( !(_la==T__0 || _la==NL) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				}
				}
				setState(47);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(56);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__1) | (1L << T__3) | (1L << T__6) | (1L << T__7) | (1L << T__9) | (1L << T__11) | (1L << T__12) | (1L << T__18) | (1L << T__27) | (1L << T__28) | (1L << T__34) | (1L << ID) | (1L << NUM))) != 0)) {
				{
				{
				setState(48);
				topExpr();
				setState(50); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(49);
					_la = _input.LA(1);
					if ( !(_la==T__0 || _la==NL) ) {
					_errHandler.recoverInline(this);
					}
					else {
						if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
						_errHandler.reportMatch(this);
						consume();
					}
					}
					}
					setState(52); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( _la==T__0 || _la==NL );
				}
				}
				setState(58);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			{
			setState(59);
			match(EOF);
			}

			    ((AllExprContext)_localctx).i =  root;

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TopExprContext extends ParserRuleContext {
		public ExprContext e;
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public TopExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_topExpr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterTopExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitTopExpr(this);
		}
	}

	public final TopExprContext topExpr() throws RecognitionException {
		TopExprContext _localctx = new TopExprContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_topExpr);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(62);
			((TopExprContext)_localctx).e = expr();

			        root.children.add(((TopExprContext)_localctx).e.i);
			    
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExprContext extends ParserRuleContext {
		public ExprNode i;
		public CtrlContext c;
		public NumContext n;
		public CtrlContext ctrl() {
			return getRuleContext(CtrlContext.class,0);
		}
		public NumContext num() {
			return getRuleContext(NumContext.class,0);
		}
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitExpr(this);
		}
	}

	public final ExprContext expr() throws RecognitionException {
		ExprContext _localctx = new ExprContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_expr);
		try {
			setState(71);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__1:
			case T__3:
			case T__6:
			case T__9:
			case T__11:
			case T__12:
				enterOuterAlt(_localctx, 1);
				{
				setState(65);
				((ExprContext)_localctx).c = ctrl();

				        ((ExprContext)_localctx).i =  ((ExprContext)_localctx).c.i;
				    
				}
				break;
			case T__7:
			case T__18:
			case T__27:
			case T__28:
			case T__34:
			case ID:
			case NUM:
				enterOuterAlt(_localctx, 2);
				{
				setState(68);
				((ExprContext)_localctx).n = num(0);

				        ((ExprContext)_localctx).i =  ((ExprContext)_localctx).n.i;
				    
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PrintExprContext extends ParserRuleContext {
		public PrintNode i;
		public PrintListContext pL;
		public PrintListContext printList() {
			return getRuleContext(PrintListContext.class,0);
		}
		public PrintExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_printExpr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterPrintExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitPrintExpr(this);
		}
	}

	public final PrintExprContext printExpr() throws RecognitionException {
		PrintExprContext _localctx = new PrintExprContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_printExpr);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(73);
			match(T__1);
			setState(74);
			((PrintExprContext)_localctx).pL = printList();

			        ArrayList<ValueNode> lis = new ArrayList(((PrintExprContext)_localctx).pL.i);
			        ((PrintExprContext)_localctx).i =  new PrintNode(lis);
			    
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PrintListContext extends ParserRuleContext {
		public LinkedList<ValueNode> i;
		public NumContext n;
		public PrintListContext pL;
		public Token str;
		public NumContext num() {
			return getRuleContext(NumContext.class,0);
		}
		public PrintListContext printList() {
			return getRuleContext(PrintListContext.class,0);
		}
		public TerminalNode STRING() { return getToken(GrammarParser.STRING, 0); }
		public PrintListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_printList; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterPrintList(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitPrintList(this);
		}
	}

	public final PrintListContext printList() throws RecognitionException {
		PrintListContext _localctx = new PrintListContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_printList);
		try {
			setState(92);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,4,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(77);
				((PrintListContext)_localctx).n = num(0);
				setState(78);
				match(T__2);
				setState(79);
				((PrintListContext)_localctx).pL = printList();

				        LinkedList<ValueNode> partSolvedList = ((PrintListContext)_localctx).pL.i;
				        partSolvedList.push(((PrintListContext)_localctx).n.i);
				        ((PrintListContext)_localctx).i =  partSolvedList;
				    
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(82);
				((PrintListContext)_localctx).str = match(STRING);
				setState(83);
				match(T__2);
				setState(84);
				((PrintListContext)_localctx).pL = printList();

				        LinkedList<ValueNode> partSolvedList = ((PrintListContext)_localctx).pL.i;
				        String temp = (((PrintListContext)_localctx).str!=null?((PrintListContext)_localctx).str.getText():null).substring(1,(((PrintListContext)_localctx).str!=null?((PrintListContext)_localctx).str.getText():null).length()-1);
				        // temp = temp.replace("\\n","\n").replace("\\t","\t").replace("\\r","\r");
				        partSolvedList.push(new StringNode(temp));
				        ((PrintListContext)_localctx).i =  partSolvedList;
				    
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(87);
				((PrintListContext)_localctx).n = num(0);

				        LinkedList<ValueNode> retList = new LinkedList<ValueNode>();
				        retList.push(((PrintListContext)_localctx).n.i);
				        ((PrintListContext)_localctx).i =  retList;
				    
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(90);
				((PrintListContext)_localctx).str = match(STRING);

				        LinkedList<ValueNode> retList = new LinkedList<ValueNode>();
				        String temp = (((PrintListContext)_localctx).str!=null?((PrintListContext)_localctx).str.getText():null).substring(1,(((PrintListContext)_localctx).str!=null?((PrintListContext)_localctx).str.getText():null).length()-1);
				        // temp = temp.replace("\\n","\n").replace("\\t","\t").replace("\\r","\r");
				        retList.push(new StringNode(temp));
				        ((PrintListContext)_localctx).i =  retList;
				    
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class CtrlContext extends ParserRuleContext {
		public CtrlNode i;
		public IfStatementContext ifs;
		public WhileLoopContext w;
		public ForLoopContext f;
		public DefineFxnContext d;
		public PrintExprContext p;
		public NumContext n;
		public IfStatementContext ifStatement() {
			return getRuleContext(IfStatementContext.class,0);
		}
		public WhileLoopContext whileLoop() {
			return getRuleContext(WhileLoopContext.class,0);
		}
		public ForLoopContext forLoop() {
			return getRuleContext(ForLoopContext.class,0);
		}
		public DefineFxnContext defineFxn() {
			return getRuleContext(DefineFxnContext.class,0);
		}
		public PrintExprContext printExpr() {
			return getRuleContext(PrintExprContext.class,0);
		}
		public NumContext num() {
			return getRuleContext(NumContext.class,0);
		}
		public CtrlContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ctrl; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterCtrl(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitCtrl(this);
		}
	}

	public final CtrlContext ctrl() throws RecognitionException {
		CtrlContext _localctx = new CtrlContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_ctrl);
		try {
			setState(115);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,5,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(94);
				((CtrlContext)_localctx).ifs = ifStatement();

				        ((CtrlContext)_localctx).i =  ((CtrlContext)_localctx).ifs.i;
				    
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(97);
				((CtrlContext)_localctx).w = whileLoop();

				        ((CtrlContext)_localctx).i =  ((CtrlContext)_localctx).w.i;
				    
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(100);
				((CtrlContext)_localctx).f = forLoop();

				        ((CtrlContext)_localctx).i =  ((CtrlContext)_localctx).f.i;
				    
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(103);
				((CtrlContext)_localctx).d = defineFxn();

				        ((CtrlContext)_localctx).i =  ((CtrlContext)_localctx).d.i;
				    
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(106);
				((CtrlContext)_localctx).p = printExpr();

				        ((CtrlContext)_localctx).i =  ((CtrlContext)_localctx).p.i;
				    
				}
				break;
			case 6:
				enterOuterAlt(_localctx, 6);
				{
				setState(109);
				match(T__3);
				setState(110);
				((CtrlContext)_localctx).n = num(0);

				        ((CtrlContext)_localctx).i =  new ReturnNode(((CtrlContext)_localctx).n.i);
				    
				}
				break;
			case 7:
				enterOuterAlt(_localctx, 7);
				{
				setState(113);
				match(T__3);

				        ((CtrlContext)_localctx).i =  new ReturnNode(new ConstNode(0.0));
				    
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExprListContext extends ParserRuleContext {
		public LinkedList<ExprNode> i;
		public ExprContext e;
		public ExprListContext eL;
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public ExprListContext exprList() {
			return getRuleContext(ExprListContext.class,0);
		}
		public List<TerminalNode> NL() { return getTokens(GrammarParser.NL); }
		public TerminalNode NL(int i) {
			return getToken(GrammarParser.NL, i);
		}
		public ExprListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_exprList; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterExprList(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitExprList(this);
		}
	}

	public final ExprListContext exprList() throws RecognitionException {
		ExprListContext _localctx = new ExprListContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_exprList);
		int _la;
		try {
			setState(129);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,7,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(117);
				((ExprListContext)_localctx).e = expr();
				setState(119); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(118);
					_la = _input.LA(1);
					if ( !(_la==T__0 || _la==NL) ) {
					_errHandler.recoverInline(this);
					}
					else {
						if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
						_errHandler.reportMatch(this);
						consume();
					}
					}
					}
					setState(121); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( _la==T__0 || _la==NL );
				setState(123);
				((ExprListContext)_localctx).eL = exprList();

				        LinkedList<ExprNode> partSolvedList = ((ExprListContext)_localctx).eL.i;
				        partSolvedList.push(((ExprListContext)_localctx).e.i);
				        ((ExprListContext)_localctx).i =  partSolvedList;
				    
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(126);
				((ExprListContext)_localctx).e = expr();
				 
				        LinkedList<ExprNode> retList = new LinkedList<ExprNode>();
				        retList.push(((ExprListContext)_localctx).e.i);
				        ((ExprListContext)_localctx).i =  retList;
				    
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BracketedExprsContext extends ParserRuleContext {
		public ArrayList<ExprNode> i;
		public ExprListContext eL;
		public ExprListContext exprList() {
			return getRuleContext(ExprListContext.class,0);
		}
		public List<TerminalNode> NL() { return getTokens(GrammarParser.NL); }
		public TerminalNode NL(int i) {
			return getToken(GrammarParser.NL, i);
		}
		public BracketedExprsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_bracketedExprs; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterBracketedExprs(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitBracketedExprs(this);
		}
	}

	public final BracketedExprsContext bracketedExprs() throws RecognitionException {
		BracketedExprsContext _localctx = new BracketedExprsContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_bracketedExprs);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(131);
			match(T__4);
			setState(135);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__0 || _la==NL) {
				{
				{
				setState(132);
				_la = _input.LA(1);
				if ( !(_la==T__0 || _la==NL) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				}
				}
				setState(137);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(138);
			((BracketedExprsContext)_localctx).eL = exprList();
			setState(142);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__0 || _la==NL) {
				{
				{
				setState(139);
				_la = _input.LA(1);
				if ( !(_la==T__0 || _la==NL) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				}
				}
				setState(144);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(145);
			match(T__5);

			        ((BracketedExprsContext)_localctx).i =  new ArrayList(((BracketedExprsContext)_localctx).eL.i);
			    
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class WhileLoopContext extends ParserRuleContext {
		public WhileNode i;
		public NumContext n;
		public BothExprContext bExpr;
		public NumContext num() {
			return getRuleContext(NumContext.class,0);
		}
		public BothExprContext bothExpr() {
			return getRuleContext(BothExprContext.class,0);
		}
		public TerminalNode NL() { return getToken(GrammarParser.NL, 0); }
		public WhileLoopContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_whileLoop; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterWhileLoop(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitWhileLoop(this);
		}
	}

	public final WhileLoopContext whileLoop() throws RecognitionException {
		WhileLoopContext _localctx = new WhileLoopContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_whileLoop);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(148);
			match(T__6);
			setState(149);
			match(T__7);
			setState(150);
			((WhileLoopContext)_localctx).n = num(0);
			setState(151);
			match(T__8);
			setState(153);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==NL) {
				{
				setState(152);
				match(NL);
				}
			}

			setState(155);
			((WhileLoopContext)_localctx).bExpr = bothExpr();

			        ((WhileLoopContext)_localctx).i =  new WhileNode(((WhileLoopContext)_localctx).n.i, ((WhileLoopContext)_localctx).bExpr.i);
			    
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BothExprContext extends ParserRuleContext {
		public ArrayList<ExprNode> i;
		public BracketedExprsContext brackExpr;
		public ExprContext e;
		public BracketedExprsContext bracketedExprs() {
			return getRuleContext(BracketedExprsContext.class,0);
		}
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public BothExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_bothExpr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterBothExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitBothExpr(this);
		}
	}

	public final BothExprContext bothExpr() throws RecognitionException {
		BothExprContext _localctx = new BothExprContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_bothExpr);
		try {
			setState(164);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__4:
				enterOuterAlt(_localctx, 1);
				{
				setState(158);
				((BothExprContext)_localctx).brackExpr = bracketedExprs();

				        ((BothExprContext)_localctx).i =  new ArrayList(((BothExprContext)_localctx).brackExpr.i);
				    
				}
				break;
			case T__1:
			case T__3:
			case T__6:
			case T__7:
			case T__9:
			case T__11:
			case T__12:
			case T__18:
			case T__27:
			case T__28:
			case T__34:
			case ID:
			case NUM:
				enterOuterAlt(_localctx, 2);
				{
				setState(161);
				((BothExprContext)_localctx).e = expr();

				        ArrayList<ExprNode> lis = new ArrayList<ExprNode>();
				        lis.add(((BothExprContext)_localctx).e.i);
				        ((BothExprContext)_localctx).i =  lis;
				    
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class IfStatementContext extends ParserRuleContext {
		public IfNode i;
		public NumContext n;
		public BothExprContext ifExpL;
		public BothExprContext elseExpL;
		public NumContext num() {
			return getRuleContext(NumContext.class,0);
		}
		public List<BothExprContext> bothExpr() {
			return getRuleContexts(BothExprContext.class);
		}
		public BothExprContext bothExpr(int i) {
			return getRuleContext(BothExprContext.class,i);
		}
		public List<TerminalNode> NL() { return getTokens(GrammarParser.NL); }
		public TerminalNode NL(int i) {
			return getToken(GrammarParser.NL, i);
		}
		public IfStatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ifStatement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterIfStatement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitIfStatement(this);
		}
	}

	public final IfStatementContext ifStatement() throws RecognitionException {
		IfStatementContext _localctx = new IfStatementContext(_ctx, getState());
		enterRule(_localctx, 20, RULE_ifStatement);
		int _la;
		try {
			setState(191);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,15,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(166);
				match(T__9);
				setState(167);
				match(T__7);
				setState(168);
				((IfStatementContext)_localctx).n = num(0);
				setState(169);
				match(T__8);
				setState(171);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==NL) {
					{
					setState(170);
					match(NL);
					}
				}

				setState(173);
				((IfStatementContext)_localctx).ifExpL = bothExpr();
				setState(174);
				match(T__10);
				setState(176);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==NL) {
					{
					setState(175);
					match(NL);
					}
				}

				setState(178);
				((IfStatementContext)_localctx).elseExpL = bothExpr();

				        ((IfStatementContext)_localctx).i =  new IfNode(((IfStatementContext)_localctx).n.i, ((IfStatementContext)_localctx).ifExpL.i, ((IfStatementContext)_localctx).elseExpL.i);
				    
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(181);
				match(T__9);
				setState(182);
				match(T__7);
				setState(183);
				((IfStatementContext)_localctx).n = num(0);
				setState(184);
				match(T__8);
				setState(186);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==NL) {
					{
					setState(185);
					match(NL);
					}
				}

				setState(188);
				((IfStatementContext)_localctx).ifExpL = bothExpr();

				        ((IfStatementContext)_localctx).i =  new IfNode(((IfStatementContext)_localctx).n.i, ((IfStatementContext)_localctx).ifExpL.i, null);
				    
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ForLoopContext extends ParserRuleContext {
		public ForNode i;
		public NumContext n1;
		public NumContext n2;
		public NumContext n3;
		public BothExprContext bExp;
		public List<NumContext> num() {
			return getRuleContexts(NumContext.class);
		}
		public NumContext num(int i) {
			return getRuleContext(NumContext.class,i);
		}
		public BothExprContext bothExpr() {
			return getRuleContext(BothExprContext.class,0);
		}
		public TerminalNode NL() { return getToken(GrammarParser.NL, 0); }
		public ForLoopContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_forLoop; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterForLoop(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitForLoop(this);
		}
	}

	public final ForLoopContext forLoop() throws RecognitionException {
		ForLoopContext _localctx = new ForLoopContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_forLoop);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(193);
			match(T__11);
			setState(194);
			match(T__7);
			setState(195);
			((ForLoopContext)_localctx).n1 = num(0);
			setState(196);
			match(T__0);
			setState(197);
			((ForLoopContext)_localctx).n2 = num(0);
			setState(198);
			match(T__0);
			setState(199);
			((ForLoopContext)_localctx).n3 = num(0);
			setState(200);
			match(T__8);
			setState(202);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==NL) {
				{
				setState(201);
				match(NL);
				}
			}

			setState(204);
			((ForLoopContext)_localctx).bExp = bothExpr();

			        ((ForLoopContext)_localctx).i =  new ForNode(((ForLoopContext)_localctx).n1.i, ((ForLoopContext)_localctx).n2.i, ((ForLoopContext)_localctx).n3.i, ((ForLoopContext)_localctx).bExp.i);
			    
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class DefineFxnContext extends ParserRuleContext {
		public CtrlNode i;
		public Token ID;
		public FxnArgListContext fAL;
		public BothExprContext bExp;
		public TerminalNode ID() { return getToken(GrammarParser.ID, 0); }
		public FxnArgListContext fxnArgList() {
			return getRuleContext(FxnArgListContext.class,0);
		}
		public BothExprContext bothExpr() {
			return getRuleContext(BothExprContext.class,0);
		}
		public TerminalNode NL() { return getToken(GrammarParser.NL, 0); }
		public DefineFxnContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_defineFxn; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterDefineFxn(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitDefineFxn(this);
		}
	}

	public final DefineFxnContext defineFxn() throws RecognitionException {
		DefineFxnContext _localctx = new DefineFxnContext(_ctx, getState());
		enterRule(_localctx, 24, RULE_defineFxn);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(207);
			match(T__12);
			setState(208);
			((DefineFxnContext)_localctx).ID = match(ID);
			setState(209);
			match(T__7);
			setState(210);
			((DefineFxnContext)_localctx).fAL = fxnArgList();
			setState(211);
			match(T__8);
			setState(213);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==NL) {
				{
				setState(212);
				match(NL);
				}
			}

			setState(215);
			((DefineFxnContext)_localctx).bExp = bothExpr();

			        ((DefineFxnContext)_localctx).i =  new DefineFxnNode(((DefineFxnContext)_localctx).ID.getText(), new ArrayList(((DefineFxnContext)_localctx).fAL.i), ((DefineFxnContext)_localctx).bExp.i);
			    
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FxnArgListContext extends ParserRuleContext {
		public LinkedList<String> i;
		public Token ID;
		public FxnArgListContext fAL;
		public TerminalNode ID() { return getToken(GrammarParser.ID, 0); }
		public FxnArgListContext fxnArgList() {
			return getRuleContext(FxnArgListContext.class,0);
		}
		public FxnArgListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_fxnArgList; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterFxnArgList(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitFxnArgList(this);
		}
	}

	public final FxnArgListContext fxnArgList() throws RecognitionException {
		FxnArgListContext _localctx = new FxnArgListContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_fxnArgList);
		try {
			setState(225);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,18,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(218);
				((FxnArgListContext)_localctx).ID = match(ID);
				setState(219);
				match(T__2);
				setState(220);
				((FxnArgListContext)_localctx).fAL = fxnArgList();

				        LinkedList<String> partSolvedList = ((FxnArgListContext)_localctx).fAL.i;
				        partSolvedList.push(((FxnArgListContext)_localctx).ID.getText());
				        ((FxnArgListContext)_localctx).i =  partSolvedList;
				    
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(223);
				((FxnArgListContext)_localctx).ID = match(ID);

				        LinkedList<String> retList = new LinkedList<String>();
				        retList.push(((FxnArgListContext)_localctx).ID.getText());
				        ((FxnArgListContext)_localctx).i =  retList;
				    
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class NumContext extends ParserRuleContext {
		public NumNode i;
		public NumContext nl;
		public FxnContext f;
		public ParensContext p;
		public UniArithContext uA;
		public AssignContext a;
		public UniLogicContext uL;
		public Token ID;
		public Token NUM;
		public Token op1;
		public NumContext nm;
		public Token op2;
		public NumContext nr;
		public Token op;
		public FxnContext fxn() {
			return getRuleContext(FxnContext.class,0);
		}
		public ParensContext parens() {
			return getRuleContext(ParensContext.class,0);
		}
		public UniArithContext uniArith() {
			return getRuleContext(UniArithContext.class,0);
		}
		public AssignContext assign() {
			return getRuleContext(AssignContext.class,0);
		}
		public UniLogicContext uniLogic() {
			return getRuleContext(UniLogicContext.class,0);
		}
		public TerminalNode ID() { return getToken(GrammarParser.ID, 0); }
		public TerminalNode NUM() { return getToken(GrammarParser.NUM, 0); }
		public List<NumContext> num() {
			return getRuleContexts(NumContext.class);
		}
		public NumContext num(int i) {
			return getRuleContext(NumContext.class,i);
		}
		public NumContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_num; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterNum(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitNum(this);
		}
	}

	public final NumContext num() throws RecognitionException {
		return num(0);
	}

	private NumContext num(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		NumContext _localctx = new NumContext(_ctx, _parentState);
		NumContext _prevctx = _localctx;
		int _startState = 28;
		enterRecursionRule(_localctx, 28, RULE_num, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(247);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,19,_ctx) ) {
			case 1:
				{
				setState(228);
				((NumContext)_localctx).f = fxn();
				 ((NumContext)_localctx).i =  ((NumContext)_localctx).f.i; 
				}
				break;
			case 2:
				{
				setState(231);
				((NumContext)_localctx).p = parens();
				 ((NumContext)_localctx).i =  ((NumContext)_localctx).p.i; 
				}
				break;
			case 3:
				{
				setState(234);
				((NumContext)_localctx).uA = uniArith();
				 ((NumContext)_localctx).i =  ((NumContext)_localctx).uA.i; 
				}
				break;
			case 4:
				{
				setState(237);
				((NumContext)_localctx).a = assign();
				 ((NumContext)_localctx).i =  ((NumContext)_localctx).a.i; 
				}
				break;
			case 5:
				{
				setState(240);
				((NumContext)_localctx).uL = uniLogic();
				 ((NumContext)_localctx).i =  ((NumContext)_localctx).uL.i; 
				}
				break;
			case 6:
				{
				setState(243);
				((NumContext)_localctx).ID = match(ID);

				        ((NumContext)_localctx).i =  new IDNode(  ((NumContext)_localctx).ID.getText()  );
				    
				}
				break;
			case 7:
				{
				setState(245);
				((NumContext)_localctx).NUM = match(NUM);

				        ((NumContext)_localctx).i =  new ConstNode(  Double.parseDouble(((NumContext)_localctx).NUM.getText())  );
				    
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(288);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,21,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(286);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,20,_ctx) ) {
					case 1:
						{
						_localctx = new NumContext(_parentctx, _parentState);
						_localctx.nl = _prevctx;
						_localctx.nl = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_num);
						setState(249);
						if (!(precpred(_ctx, 11))) throw new FailedPredicateException(this, "precpred(_ctx, 11)");
						setState(250);
						((NumContext)_localctx).op1 = match(T__13);
						setState(251);
						((NumContext)_localctx).nm = num(0);
						setState(252);
						((NumContext)_localctx).op2 = match(T__13);
						setState(253);
						((NumContext)_localctx).nr = num(12);

						                  ((NumContext)_localctx).i =  new BinNode(((NumContext)_localctx).nl.i, ((NumContext)_localctx).op1.getText(), new BinNode(((NumContext)_localctx).nm.i, ((NumContext)_localctx).op2.getText(), ((NumContext)_localctx).nr.i));
						              
						}
						break;
					case 2:
						{
						_localctx = new NumContext(_parentctx, _parentState);
						_localctx.nl = _prevctx;
						_localctx.nl = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_num);
						setState(256);
						if (!(precpred(_ctx, 10))) throw new FailedPredicateException(this, "precpred(_ctx, 10)");
						setState(257);
						((NumContext)_localctx).op = match(T__13);
						setState(258);
						((NumContext)_localctx).nr = num(11);

						                  ((NumContext)_localctx).i =  new BinNode(((NumContext)_localctx).nl.i, ((NumContext)_localctx).op.getText(), ((NumContext)_localctx).nr.i);
						              
						}
						break;
					case 3:
						{
						_localctx = new NumContext(_parentctx, _parentState);
						_localctx.nl = _prevctx;
						_localctx.nl = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_num);
						setState(261);
						if (!(precpred(_ctx, 9))) throw new FailedPredicateException(this, "precpred(_ctx, 9)");
						setState(262);
						((NumContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__14) | (1L << T__15) | (1L << T__16))) != 0)) ) {
							((NumContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(263);
						((NumContext)_localctx).nr = num(10);

						                  ((NumContext)_localctx).i =  new BinNode(((NumContext)_localctx).nl.i, ((NumContext)_localctx).op.getText(), ((NumContext)_localctx).nr.i);
						              
						}
						break;
					case 4:
						{
						_localctx = new NumContext(_parentctx, _parentState);
						_localctx.nl = _prevctx;
						_localctx.nl = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_num);
						setState(266);
						if (!(precpred(_ctx, 8))) throw new FailedPredicateException(this, "precpred(_ctx, 8)");
						setState(267);
						((NumContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !(_la==T__17 || _la==T__18) ) {
							((NumContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(268);
						((NumContext)_localctx).nr = num(9);

						                  ((NumContext)_localctx).i =  new BinNode(((NumContext)_localctx).nl.i, ((NumContext)_localctx).op.getText(), ((NumContext)_localctx).nr.i);
						              
						}
						break;
					case 5:
						{
						_localctx = new NumContext(_parentctx, _parentState);
						_localctx.nl = _prevctx;
						_localctx.nl = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_num);
						setState(271);
						if (!(precpred(_ctx, 6))) throw new FailedPredicateException(this, "precpred(_ctx, 6)");
						setState(272);
						((NumContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__19) | (1L << T__20) | (1L << T__21) | (1L << T__22) | (1L << T__23) | (1L << T__24))) != 0)) ) {
							((NumContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(273);
						((NumContext)_localctx).nr = num(7);

						                  ((NumContext)_localctx).i =  new BinNode(((NumContext)_localctx).nl.i, ((NumContext)_localctx).op.getText(), ((NumContext)_localctx).nr.i);
						              
						}
						break;
					case 6:
						{
						_localctx = new NumContext(_parentctx, _parentState);
						_localctx.nl = _prevctx;
						_localctx.nl = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_num);
						setState(276);
						if (!(precpred(_ctx, 4))) throw new FailedPredicateException(this, "precpred(_ctx, 4)");
						setState(277);
						((NumContext)_localctx).op = match(T__25);
						setState(278);
						((NumContext)_localctx).nr = num(5);

						                  ((NumContext)_localctx).i =  new BinNode(((NumContext)_localctx).nl.i, ((NumContext)_localctx).op.getText(), ((NumContext)_localctx).nr.i);
						              
						}
						break;
					case 7:
						{
						_localctx = new NumContext(_parentctx, _parentState);
						_localctx.nl = _prevctx;
						_localctx.nl = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_num);
						setState(281);
						if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
						setState(282);
						((NumContext)_localctx).op = match(T__26);
						setState(283);
						((NumContext)_localctx).nr = num(4);

						                  ((NumContext)_localctx).i =  new BinNode(((NumContext)_localctx).nl.i, ((NumContext)_localctx).op.getText(), ((NumContext)_localctx).nr.i);
						              
						}
						break;
					}
					} 
				}
				setState(290);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,21,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class FxnContext extends ParserRuleContext {
		public FxnNode i;
		public Token ID;
		public NumArgListContext numList;
		public TerminalNode ID() { return getToken(GrammarParser.ID, 0); }
		public NumArgListContext numArgList() {
			return getRuleContext(NumArgListContext.class,0);
		}
		public FxnContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_fxn; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterFxn(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitFxn(this);
		}
	}

	public final FxnContext fxn() throws RecognitionException {
		FxnContext _localctx = new FxnContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_fxn);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(291);
			((FxnContext)_localctx).ID = match(ID);
			setState(292);
			match(T__7);
			setState(293);
			((FxnContext)_localctx).numList = numArgList();
			setState(294);
			match(T__8);

			         ArrayList<NumNode> solvedList = new ArrayList(((FxnContext)_localctx).numList.i);
			         ((FxnContext)_localctx).i =  new FxnNode(((FxnContext)_localctx).ID.getText(), solvedList);
			    
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class NumArgListContext extends ParserRuleContext {
		public LinkedList<NumNode> i;
		public NumContext n;
		public NumArgListContext nl;
		public NumContext num() {
			return getRuleContext(NumContext.class,0);
		}
		public NumArgListContext numArgList() {
			return getRuleContext(NumArgListContext.class,0);
		}
		public NumArgListContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_numArgList; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterNumArgList(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitNumArgList(this);
		}
	}

	public final NumArgListContext numArgList() throws RecognitionException {
		NumArgListContext _localctx = new NumArgListContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_numArgList);
		try {
			setState(305);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,22,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(297);
				((NumArgListContext)_localctx).n = num(0);
				setState(298);
				match(T__2);
				setState(299);
				((NumArgListContext)_localctx).nl = numArgList();

				        LinkedList<NumNode> partSolvedList = ((NumArgListContext)_localctx).nl.i;
				        partSolvedList.push(((NumArgListContext)_localctx).n.i);
				        ((NumArgListContext)_localctx).i =  partSolvedList;
				    
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(302);
				((NumArgListContext)_localctx).n = num(0);

				        LinkedList<NumNode> retList = new LinkedList<NumNode>();
				        retList.push(((NumArgListContext)_localctx).n.i);
				        ((NumArgListContext)_localctx).i =  retList;
				    
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ParensContext extends ParserRuleContext {
		public NumNode i;
		public NumContext n;
		public NumContext num() {
			return getRuleContext(NumContext.class,0);
		}
		public ParensContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_parens; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterParens(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitParens(this);
		}
	}

	public final ParensContext parens() throws RecognitionException {
		ParensContext _localctx = new ParensContext(_ctx, getState());
		enterRule(_localctx, 34, RULE_parens);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(307);
			match(T__7);
			setState(308);
			((ParensContext)_localctx).n = num(0);
			setState(309);
			match(T__8);

			        ((ParensContext)_localctx).i =  ((ParensContext)_localctx).n.i;
			    
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class UniArithContext extends ParserRuleContext {
		public NumNode i;
		public Token op;
		public Token ID;
		public NumContext n;
		public TerminalNode ID() { return getToken(GrammarParser.ID, 0); }
		public NumContext num() {
			return getRuleContext(NumContext.class,0);
		}
		public UniArithContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_uniArith; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterUniArith(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitUniArith(this);
		}
	}

	public final UniArithContext uniArith() throws RecognitionException {
		UniArithContext _localctx = new UniArithContext(_ctx, getState());
		enterRule(_localctx, 36, RULE_uniArith);
		int _la;
		try {
			setState(322);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__27:
			case T__28:
				enterOuterAlt(_localctx, 1);
				{
				setState(312);
				((UniArithContext)_localctx).op = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==T__27 || _la==T__28) ) {
					((UniArithContext)_localctx).op = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(313);
				((UniArithContext)_localctx).ID = match(ID);

				        ((UniArithContext)_localctx).i =  new SelfAssNode(((UniArithContext)_localctx).ID.getText(), ((UniArithContext)_localctx).op.getText(), true);
				    
				}
				break;
			case ID:
				enterOuterAlt(_localctx, 2);
				{
				setState(315);
				((UniArithContext)_localctx).ID = match(ID);
				setState(316);
				((UniArithContext)_localctx).op = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==T__27 || _la==T__28) ) {
					((UniArithContext)_localctx).op = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}

				        ((UniArithContext)_localctx).i =  new SelfAssNode(((UniArithContext)_localctx).ID.getText(), ((UniArithContext)_localctx).op.getText(), false);
				    
				}
				break;
			case T__18:
				enterOuterAlt(_localctx, 3);
				{
				setState(318);
				((UniArithContext)_localctx).op = match(T__18);
				setState(319);
				((UniArithContext)_localctx).n = num(0);

				        ((UniArithContext)_localctx).i =  new UniNode(((UniArithContext)_localctx).n.i, ((UniArithContext)_localctx).op.getText());
				    
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssignContext extends ParserRuleContext {
		public AssNode i;
		public Token ID;
		public Token op;
		public NumContext n;
		public TerminalNode ID() { return getToken(GrammarParser.ID, 0); }
		public NumContext num() {
			return getRuleContext(NumContext.class,0);
		}
		public AssignContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assign; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterAssign(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitAssign(this);
		}
	}

	public final AssignContext assign() throws RecognitionException {
		AssignContext _localctx = new AssignContext(_ctx, getState());
		enterRule(_localctx, 38, RULE_assign);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(324);
			((AssignContext)_localctx).ID = match(ID);
			setState(325);
			((AssignContext)_localctx).op = _input.LT(1);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__29) | (1L << T__30) | (1L << T__31) | (1L << T__32) | (1L << T__33))) != 0)) ) {
				((AssignContext)_localctx).op = (Token)_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(326);
			((AssignContext)_localctx).n = num(0);

			        ((AssignContext)_localctx).i =  new AssNode(((AssignContext)_localctx).ID.getText(), ((AssignContext)_localctx).op.getText(), ((AssignContext)_localctx).n.i);
			    
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class UniLogicContext extends ParserRuleContext {
		public UniNode i;
		public Token op;
		public NumContext n;
		public NumContext num() {
			return getRuleContext(NumContext.class,0);
		}
		public UniLogicContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_uniLogic; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).enterUniLogic(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof GrammarListener ) ((GrammarListener)listener).exitUniLogic(this);
		}
	}

	public final UniLogicContext uniLogic() throws RecognitionException {
		UniLogicContext _localctx = new UniLogicContext(_ctx, getState());
		enterRule(_localctx, 40, RULE_uniLogic);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(329);
			((UniLogicContext)_localctx).op = match(T__34);
			setState(330);
			((UniLogicContext)_localctx).n = num(0);

			        ((UniLogicContext)_localctx).i =  new UniNode(((UniLogicContext)_localctx).n.i, ((UniLogicContext)_localctx).op.getText());
			    
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 14:
			return num_sempred((NumContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean num_sempred(NumContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 11);
		case 1:
			return precpred(_ctx, 10);
		case 2:
			return precpred(_ctx, 9);
		case 3:
			return precpred(_ctx, 8);
		case 4:
			return precpred(_ctx, 6);
		case 5:
			return precpred(_ctx, 4);
		case 6:
			return precpred(_ctx, 3);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3,\u0150\4\2\t\2\4"+
		"\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t"+
		"\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\3\2\7\2.\n\2\f\2\16\2\61\13\2"+
		"\3\2\3\2\6\2\65\n\2\r\2\16\2\66\7\29\n\2\f\2\16\2<\13\2\3\2\3\2\3\2\3"+
		"\3\3\3\3\3\3\4\3\4\3\4\3\4\3\4\3\4\5\4J\n\4\3\5\3\5\3\5\3\5\3\6\3\6\3"+
		"\6\3\6\3\6\3\6\3\6\3\6\3\6\3\6\3\6\3\6\3\6\3\6\3\6\5\6_\n\6\3\7\3\7\3"+
		"\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7"+
		"\3\7\5\7v\n\7\3\b\3\b\6\bz\n\b\r\b\16\b{\3\b\3\b\3\b\3\b\3\b\3\b\5\b\u0084"+
		"\n\b\3\t\3\t\7\t\u0088\n\t\f\t\16\t\u008b\13\t\3\t\3\t\7\t\u008f\n\t\f"+
		"\t\16\t\u0092\13\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n\3\n\5\n\u009c\n\n\3\n\3"+
		"\n\3\n\3\13\3\13\3\13\3\13\3\13\3\13\5\13\u00a7\n\13\3\f\3\f\3\f\3\f\3"+
		"\f\5\f\u00ae\n\f\3\f\3\f\3\f\5\f\u00b3\n\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f"+
		"\3\f\5\f\u00bd\n\f\3\f\3\f\3\f\5\f\u00c2\n\f\3\r\3\r\3\r\3\r\3\r\3\r\3"+
		"\r\3\r\3\r\5\r\u00cd\n\r\3\r\3\r\3\r\3\16\3\16\3\16\3\16\3\16\3\16\5\16"+
		"\u00d8\n\16\3\16\3\16\3\16\3\17\3\17\3\17\3\17\3\17\3\17\3\17\5\17\u00e4"+
		"\n\17\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20"+
		"\3\20\3\20\3\20\3\20\3\20\3\20\3\20\5\20\u00fa\n\20\3\20\3\20\3\20\3\20"+
		"\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20"+
		"\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20\3\20"+
		"\3\20\3\20\3\20\3\20\3\20\7\20\u0121\n\20\f\20\16\20\u0124\13\20\3\21"+
		"\3\21\3\21\3\21\3\21\3\21\3\22\3\22\3\22\3\22\3\22\3\22\3\22\3\22\5\22"+
		"\u0134\n\22\3\23\3\23\3\23\3\23\3\23\3\24\3\24\3\24\3\24\3\24\3\24\3\24"+
		"\3\24\3\24\3\24\5\24\u0145\n\24\3\25\3\25\3\25\3\25\3\25\3\26\3\26\3\26"+
		"\3\26\3\26\2\3\36\27\2\4\6\b\n\f\16\20\22\24\26\30\32\34\36 \"$&(*\2\b"+
		"\4\2\3\3,,\3\2\21\23\3\2\24\25\3\2\26\33\3\2\36\37\3\2 $\2\u0164\2/\3"+
		"\2\2\2\4@\3\2\2\2\6I\3\2\2\2\bK\3\2\2\2\n^\3\2\2\2\fu\3\2\2\2\16\u0083"+
		"\3\2\2\2\20\u0085\3\2\2\2\22\u0096\3\2\2\2\24\u00a6\3\2\2\2\26\u00c1\3"+
		"\2\2\2\30\u00c3\3\2\2\2\32\u00d1\3\2\2\2\34\u00e3\3\2\2\2\36\u00f9\3\2"+
		"\2\2 \u0125\3\2\2\2\"\u0133\3\2\2\2$\u0135\3\2\2\2&\u0144\3\2\2\2(\u0146"+
		"\3\2\2\2*\u014b\3\2\2\2,.\t\2\2\2-,\3\2\2\2.\61\3\2\2\2/-\3\2\2\2/\60"+
		"\3\2\2\2\60:\3\2\2\2\61/\3\2\2\2\62\64\5\4\3\2\63\65\t\2\2\2\64\63\3\2"+
		"\2\2\65\66\3\2\2\2\66\64\3\2\2\2\66\67\3\2\2\2\679\3\2\2\28\62\3\2\2\2"+
		"9<\3\2\2\2:8\3\2\2\2:;\3\2\2\2;=\3\2\2\2<:\3\2\2\2=>\7\2\2\3>?\b\2\1\2"+
		"?\3\3\2\2\2@A\5\6\4\2AB\b\3\1\2B\5\3\2\2\2CD\5\f\7\2DE\b\4\1\2EJ\3\2\2"+
		"\2FG\5\36\20\2GH\b\4\1\2HJ\3\2\2\2IC\3\2\2\2IF\3\2\2\2J\7\3\2\2\2KL\7"+
		"\4\2\2LM\5\n\6\2MN\b\5\1\2N\t\3\2\2\2OP\5\36\20\2PQ\7\5\2\2QR\5\n\6\2"+
		"RS\b\6\1\2S_\3\2\2\2TU\7(\2\2UV\7\5\2\2VW\5\n\6\2WX\b\6\1\2X_\3\2\2\2"+
		"YZ\5\36\20\2Z[\b\6\1\2[_\3\2\2\2\\]\7(\2\2]_\b\6\1\2^O\3\2\2\2^T\3\2\2"+
		"\2^Y\3\2\2\2^\\\3\2\2\2_\13\3\2\2\2`a\5\26\f\2ab\b\7\1\2bv\3\2\2\2cd\5"+
		"\22\n\2de\b\7\1\2ev\3\2\2\2fg\5\30\r\2gh\b\7\1\2hv\3\2\2\2ij\5\32\16\2"+
		"jk\b\7\1\2kv\3\2\2\2lm\5\b\5\2mn\b\7\1\2nv\3\2\2\2op\7\6\2\2pq\5\36\20"+
		"\2qr\b\7\1\2rv\3\2\2\2st\7\6\2\2tv\b\7\1\2u`\3\2\2\2uc\3\2\2\2uf\3\2\2"+
		"\2ui\3\2\2\2ul\3\2\2\2uo\3\2\2\2us\3\2\2\2v\r\3\2\2\2wy\5\6\4\2xz\t\2"+
		"\2\2yx\3\2\2\2z{\3\2\2\2{y\3\2\2\2{|\3\2\2\2|}\3\2\2\2}~\5\16\b\2~\177"+
		"\b\b\1\2\177\u0084\3\2\2\2\u0080\u0081\5\6\4\2\u0081\u0082\b\b\1\2\u0082"+
		"\u0084\3\2\2\2\u0083w\3\2\2\2\u0083\u0080\3\2\2\2\u0084\17\3\2\2\2\u0085"+
		"\u0089\7\7\2\2\u0086\u0088\t\2\2\2\u0087\u0086\3\2\2\2\u0088\u008b\3\2"+
		"\2\2\u0089\u0087\3\2\2\2\u0089\u008a\3\2\2\2\u008a\u008c\3\2\2\2\u008b"+
		"\u0089\3\2\2\2\u008c\u0090\5\16\b\2\u008d\u008f\t\2\2\2\u008e\u008d\3"+
		"\2\2\2\u008f\u0092\3\2\2\2\u0090\u008e\3\2\2\2\u0090\u0091\3\2\2\2\u0091"+
		"\u0093\3\2\2\2\u0092\u0090\3\2\2\2\u0093\u0094\7\b\2\2\u0094\u0095\b\t"+
		"\1\2\u0095\21\3\2\2\2\u0096\u0097\7\t\2\2\u0097\u0098\7\n\2\2\u0098\u0099"+
		"\5\36\20\2\u0099\u009b\7\13\2\2\u009a\u009c\7,\2\2\u009b\u009a\3\2\2\2"+
		"\u009b\u009c\3\2\2\2\u009c\u009d\3\2\2\2\u009d\u009e\5\24\13\2\u009e\u009f"+
		"\b\n\1\2\u009f\23\3\2\2\2\u00a0\u00a1\5\20\t\2\u00a1\u00a2\b\13\1\2\u00a2"+
		"\u00a7\3\2\2\2\u00a3\u00a4\5\6\4\2\u00a4\u00a5\b\13\1\2\u00a5\u00a7\3"+
		"\2\2\2\u00a6\u00a0\3\2\2\2\u00a6\u00a3\3\2\2\2\u00a7\25\3\2\2\2\u00a8"+
		"\u00a9\7\f\2\2\u00a9\u00aa\7\n\2\2\u00aa\u00ab\5\36\20\2\u00ab\u00ad\7"+
		"\13\2\2\u00ac\u00ae\7,\2\2\u00ad\u00ac\3\2\2\2\u00ad\u00ae\3\2\2\2\u00ae"+
		"\u00af\3\2\2\2\u00af\u00b0\5\24\13\2\u00b0\u00b2\7\r\2\2\u00b1\u00b3\7"+
		",\2\2\u00b2\u00b1\3\2\2\2\u00b2\u00b3\3\2\2\2\u00b3\u00b4\3\2\2\2\u00b4"+
		"\u00b5\5\24\13\2\u00b5\u00b6\b\f\1\2\u00b6\u00c2\3\2\2\2\u00b7\u00b8\7"+
		"\f\2\2\u00b8\u00b9\7\n\2\2\u00b9\u00ba\5\36\20\2\u00ba\u00bc\7\13\2\2"+
		"\u00bb\u00bd\7,\2\2\u00bc\u00bb\3\2\2\2\u00bc\u00bd\3\2\2\2\u00bd\u00be"+
		"\3\2\2\2\u00be\u00bf\5\24\13\2\u00bf\u00c0\b\f\1\2\u00c0\u00c2\3\2\2\2"+
		"\u00c1\u00a8\3\2\2\2\u00c1\u00b7\3\2\2\2\u00c2\27\3\2\2\2\u00c3\u00c4"+
		"\7\16\2\2\u00c4\u00c5\7\n\2\2\u00c5\u00c6\5\36\20\2\u00c6\u00c7\7\3\2"+
		"\2\u00c7\u00c8\5\36\20\2\u00c8\u00c9\7\3\2\2\u00c9\u00ca\5\36\20\2\u00ca"+
		"\u00cc\7\13\2\2\u00cb\u00cd\7,\2\2\u00cc\u00cb\3\2\2\2\u00cc\u00cd\3\2"+
		"\2\2\u00cd\u00ce\3\2\2\2\u00ce\u00cf\5\24\13\2\u00cf\u00d0\b\r\1\2\u00d0"+
		"\31\3\2\2\2\u00d1\u00d2\7\17\2\2\u00d2\u00d3\7)\2\2\u00d3\u00d4\7\n\2"+
		"\2\u00d4\u00d5\5\34\17\2\u00d5\u00d7\7\13\2\2\u00d6\u00d8\7,\2\2\u00d7"+
		"\u00d6\3\2\2\2\u00d7\u00d8\3\2\2\2\u00d8\u00d9\3\2\2\2\u00d9\u00da\5\24"+
		"\13\2\u00da\u00db\b\16\1\2\u00db\33\3\2\2\2\u00dc\u00dd\7)\2\2\u00dd\u00de"+
		"\7\5\2\2\u00de\u00df\5\34\17\2\u00df\u00e0\b\17\1\2\u00e0\u00e4\3\2\2"+
		"\2\u00e1\u00e2\7)\2\2\u00e2\u00e4\b\17\1\2\u00e3\u00dc\3\2\2\2\u00e3\u00e1"+
		"\3\2\2\2\u00e4\35\3\2\2\2\u00e5\u00e6\b\20\1\2\u00e6\u00e7\5 \21\2\u00e7"+
		"\u00e8\b\20\1\2\u00e8\u00fa\3\2\2\2\u00e9\u00ea\5$\23\2\u00ea\u00eb\b"+
		"\20\1\2\u00eb\u00fa\3\2\2\2\u00ec\u00ed\5&\24\2\u00ed\u00ee\b\20\1\2\u00ee"+
		"\u00fa\3\2\2\2\u00ef\u00f0\5(\25\2\u00f0\u00f1\b\20\1\2\u00f1\u00fa\3"+
		"\2\2\2\u00f2\u00f3\5*\26\2\u00f3\u00f4\b\20\1\2\u00f4\u00fa\3\2\2\2\u00f5"+
		"\u00f6\7)\2\2\u00f6\u00fa\b\20\1\2\u00f7\u00f8\7*\2\2\u00f8\u00fa\b\20"+
		"\1\2\u00f9\u00e5\3\2\2\2\u00f9\u00e9\3\2\2\2\u00f9\u00ec\3\2\2\2\u00f9"+
		"\u00ef\3\2\2\2\u00f9\u00f2\3\2\2\2\u00f9\u00f5\3\2\2\2\u00f9\u00f7\3\2"+
		"\2\2\u00fa\u0122\3\2\2\2\u00fb\u00fc\f\r\2\2\u00fc\u00fd\7\20\2\2\u00fd"+
		"\u00fe\5\36\20\2\u00fe\u00ff\7\20\2\2\u00ff\u0100\5\36\20\16\u0100\u0101"+
		"\b\20\1\2\u0101\u0121\3\2\2\2\u0102\u0103\f\f\2\2\u0103\u0104\7\20\2\2"+
		"\u0104\u0105\5\36\20\r\u0105\u0106\b\20\1\2\u0106\u0121\3\2\2\2\u0107"+
		"\u0108\f\13\2\2\u0108\u0109\t\3\2\2\u0109\u010a\5\36\20\f\u010a\u010b"+
		"\b\20\1\2\u010b\u0121\3\2\2\2\u010c\u010d\f\n\2\2\u010d\u010e\t\4\2\2"+
		"\u010e\u010f\5\36\20\13\u010f\u0110\b\20\1\2\u0110\u0121\3\2\2\2\u0111"+
		"\u0112\f\b\2\2\u0112\u0113\t\5\2\2\u0113\u0114\5\36\20\t\u0114\u0115\b"+
		"\20\1\2\u0115\u0121\3\2\2\2\u0116\u0117\f\6\2\2\u0117\u0118\7\34\2\2\u0118"+
		"\u0119\5\36\20\7\u0119\u011a\b\20\1\2\u011a\u0121\3\2\2\2\u011b\u011c"+
		"\f\5\2\2\u011c\u011d\7\35\2\2\u011d\u011e\5\36\20\6\u011e\u011f\b\20\1"+
		"\2\u011f\u0121\3\2\2\2\u0120\u00fb\3\2\2\2\u0120\u0102\3\2\2\2\u0120\u0107"+
		"\3\2\2\2\u0120\u010c\3\2\2\2\u0120\u0111\3\2\2\2\u0120\u0116\3\2\2\2\u0120"+
		"\u011b\3\2\2\2\u0121\u0124\3\2\2\2\u0122\u0120\3\2\2\2\u0122\u0123\3\2"+
		"\2\2\u0123\37\3\2\2\2\u0124\u0122\3\2\2\2\u0125\u0126\7)\2\2\u0126\u0127"+
		"\7\n\2\2\u0127\u0128\5\"\22\2\u0128\u0129\7\13\2\2\u0129\u012a\b\21\1"+
		"\2\u012a!\3\2\2\2\u012b\u012c\5\36\20\2\u012c\u012d\7\5\2\2\u012d\u012e"+
		"\5\"\22\2\u012e\u012f\b\22\1\2\u012f\u0134\3\2\2\2\u0130\u0131\5\36\20"+
		"\2\u0131\u0132\b\22\1\2\u0132\u0134\3\2\2\2\u0133\u012b\3\2\2\2\u0133"+
		"\u0130\3\2\2\2\u0134#\3\2\2\2\u0135\u0136\7\n\2\2\u0136\u0137\5\36\20"+
		"\2\u0137\u0138\7\13\2\2\u0138\u0139\b\23\1\2\u0139%\3\2\2\2\u013a\u013b"+
		"\t\6\2\2\u013b\u013c\7)\2\2\u013c\u0145\b\24\1\2\u013d\u013e\7)\2\2\u013e"+
		"\u013f\t\6\2\2\u013f\u0145\b\24\1\2\u0140\u0141\7\25\2\2\u0141\u0142\5"+
		"\36\20\2\u0142\u0143\b\24\1\2\u0143\u0145\3\2\2\2\u0144\u013a\3\2\2\2"+
		"\u0144\u013d\3\2\2\2\u0144\u0140\3\2\2\2\u0145\'\3\2\2\2\u0146\u0147\7"+
		")\2\2\u0147\u0148\t\7\2\2\u0148\u0149\5\36\20\2\u0149\u014a\b\25\1\2\u014a"+
		")\3\2\2\2\u014b\u014c\7%\2\2\u014c\u014d\5\36\20\2\u014d\u014e\b\26\1"+
		"\2\u014e+\3\2\2\2\32/\66:I^u{\u0083\u0089\u0090\u009b\u00a6\u00ad\u00b2"+
		"\u00bc\u00c1\u00cc\u00d7\u00e3\u00f9\u0120\u0122\u0133\u0144";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}