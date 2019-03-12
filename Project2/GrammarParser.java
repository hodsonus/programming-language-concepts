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
		T__31=32, T__32=33, T__33=34, T__34=35, T__35=36, BLOCK=37, INLINE=38, 
		STRING=39, ID=40, NUM=41, WS=42, NL=43;
	public static final int
		RULE_allExpr = 0, RULE_topExpr = 1, RULE_expr = 2, RULE_printExpr = 3, 
		RULE_printList = 4, RULE_ctrl = 5, RULE_exprList = 6, RULE_bracketedExprs = 7, 
		RULE_whileLoop = 8, RULE_ifStatement = 9, RULE_forLoop = 10, RULE_defineFxn = 11, 
		RULE_fxnArgList = 12, RULE_num = 13, RULE_fxn = 14, RULE_numArgList = 15, 
		RULE_parens = 16, RULE_uniArith = 17, RULE_assign = 18, RULE_uniLogic = 19;
	private static String[] makeRuleNames() {
		return new String[] {
			"allExpr", "topExpr", "expr", "printExpr", "printList", "ctrl", "exprList", 
			"bracketedExprs", "whileLoop", "ifStatement", "forLoop", "defineFxn", 
			"fxnArgList", "num", "fxn", "numArgList", "parens", "uniArith", "assign", 
			"uniLogic"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "';'", "'print'", "','", "'{'", "'}'", "'while('", "')'", "'\r'", 
			"'\n'", "'if('", "'else'", "'for('", "'define'", "'('", "'^'", "'*'", 
			"'/'", "'%'", "'+'", "'-'", "'<='", "'<'", "'>='", "'>'", "'=='", "'!='", 
			"'&&'", "'||'", "'++'", "'--'", "'='", "'+='", "'-='", "'*='", "'/='", 
			"'!'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, "BLOCK", "INLINE", "STRING", "ID", "NUM", "WS", "NL"
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
			setState(43);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__0 || _la==NL) {
				{
				{
				setState(40);
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
				setState(45);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(54);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__1) | (1L << T__5) | (1L << T__9) | (1L << T__11) | (1L << T__12) | (1L << T__13) | (1L << T__19) | (1L << T__28) | (1L << T__29) | (1L << T__35) | (1L << ID) | (1L << NUM))) != 0)) {
				{
				{
				setState(46);
				topExpr();
				setState(48); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(47);
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
					setState(50); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( _la==T__0 || _la==NL );
				}
				}
				setState(56);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			{
			setState(57);
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
			setState(60);
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
			setState(69);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__1:
			case T__5:
			case T__9:
			case T__11:
			case T__12:
				enterOuterAlt(_localctx, 1);
				{
				setState(63);
				((ExprContext)_localctx).c = ctrl();

				        ((ExprContext)_localctx).i =  ((ExprContext)_localctx).c.i;
				    
				}
				break;
			case T__13:
			case T__19:
			case T__28:
			case T__29:
			case T__35:
			case ID:
			case NUM:
				enterOuterAlt(_localctx, 2);
				{
				setState(66);
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
			setState(71);
			match(T__1);
			setState(72);
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
			setState(90);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,4,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(75);
				((PrintListContext)_localctx).n = num(0);
				setState(76);
				match(T__2);
				setState(77);
				((PrintListContext)_localctx).pL = printList();

				        LinkedList<ValueNode> partSolvedList = ((PrintListContext)_localctx).pL.i;
				        partSolvedList.push(((PrintListContext)_localctx).n.i);
				        ((PrintListContext)_localctx).i =  partSolvedList;
				    
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(80);
				((PrintListContext)_localctx).str = match(STRING);
				setState(81);
				match(T__2);
				setState(82);
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
				setState(85);
				((PrintListContext)_localctx).n = num(0);

				        LinkedList<ValueNode> retList = new LinkedList<ValueNode>();
				        retList.push(((PrintListContext)_localctx).n.i);
				        ((PrintListContext)_localctx).i =  retList;
				    
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(88);
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
			setState(107);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__9:
				enterOuterAlt(_localctx, 1);
				{
				setState(92);
				((CtrlContext)_localctx).ifs = ifStatement();

				        ((CtrlContext)_localctx).i =  ((CtrlContext)_localctx).ifs.i;
				    
				}
				break;
			case T__5:
				enterOuterAlt(_localctx, 2);
				{
				setState(95);
				((CtrlContext)_localctx).w = whileLoop();

				        ((CtrlContext)_localctx).i =  ((CtrlContext)_localctx).w.i;
				    
				}
				break;
			case T__11:
				enterOuterAlt(_localctx, 3);
				{
				setState(98);
				((CtrlContext)_localctx).f = forLoop();

				        ((CtrlContext)_localctx).i =  ((CtrlContext)_localctx).f.i;
				    
				}
				break;
			case T__12:
				enterOuterAlt(_localctx, 4);
				{
				setState(101);
				((CtrlContext)_localctx).d = defineFxn();

				        ((CtrlContext)_localctx).i =  ((CtrlContext)_localctx).d.i;
				    
				}
				break;
			case T__1:
				enterOuterAlt(_localctx, 5);
				{
				setState(104);
				((CtrlContext)_localctx).p = printExpr();

				        ((CtrlContext)_localctx).i =  ((CtrlContext)_localctx).p.i;
				    
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
			setState(121);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,7,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(109);
				((ExprListContext)_localctx).e = expr();
				setState(111); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(110);
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
					setState(113); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( _la==T__0 || _la==NL );
				setState(115);
				((ExprListContext)_localctx).eL = exprList();

				        LinkedList<ExprNode> partSolvedList = ((ExprListContext)_localctx).eL.i;
				        partSolvedList.push(((ExprListContext)_localctx).e.i);
				        ((ExprListContext)_localctx).i =  partSolvedList;
				    
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(118);
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
			setState(123);
			match(T__3);
			setState(127);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__0 || _la==NL) {
				{
				{
				setState(124);
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
				setState(129);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(130);
			((BracketedExprsContext)_localctx).eL = exprList();
			setState(134);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__0 || _la==NL) {
				{
				{
				setState(131);
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
				setState(136);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(137);
			match(T__4);

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
		public BracketedExprsContext brackExpr;
		public ExprContext e;
		public NumContext num() {
			return getRuleContext(NumContext.class,0);
		}
		public BracketedExprsContext bracketedExprs() {
			return getRuleContext(BracketedExprsContext.class,0);
		}
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
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
			setState(164);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,14,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(140);
				match(T__5);
				setState(141);
				((WhileLoopContext)_localctx).n = num(0);
				setState(142);
				match(T__6);
				setState(147);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__7 || _la==T__8) {
					{
					setState(144);
					_errHandler.sync(this);
					_la = _input.LA(1);
					if (_la==T__7) {
						{
						setState(143);
						match(T__7);
						}
					}

					setState(146);
					match(T__8);
					}
				}

				setState(149);
				((WhileLoopContext)_localctx).brackExpr = bracketedExprs();

				        ((WhileLoopContext)_localctx).i =  new WhileNode(((WhileLoopContext)_localctx).n.i, new ArrayList(((WhileLoopContext)_localctx).brackExpr.i));
				    
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(152);
				match(T__5);
				setState(153);
				((WhileLoopContext)_localctx).n = num(0);
				setState(154);
				match(T__6);
				setState(159);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__7 || _la==T__8) {
					{
					setState(156);
					_errHandler.sync(this);
					_la = _input.LA(1);
					if (_la==T__7) {
						{
						setState(155);
						match(T__7);
						}
					}

					setState(158);
					match(T__8);
					}
				}

				setState(161);
				((WhileLoopContext)_localctx).e = expr();

				        ArrayList<ExprNode> lis = new ArrayList<ExprNode>();
				        lis.add(((WhileLoopContext)_localctx).e.i);
				        ((WhileLoopContext)_localctx).i =  new WhileNode(((WhileLoopContext)_localctx).n.i, lis);
				    
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

	public static class IfStatementContext extends ParserRuleContext {
		public IfNode i;
		public NumContext n;
		public ExprListContext ifExpL;
		public ExprListContext elseExpL;
		public NumContext num() {
			return getRuleContext(NumContext.class,0);
		}
		public List<ExprListContext> exprList() {
			return getRuleContexts(ExprListContext.class);
		}
		public ExprListContext exprList(int i) {
			return getRuleContext(ExprListContext.class,i);
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
		enterRule(_localctx, 18, RULE_ifStatement);
		try {
			setState(180);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,15,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(166);
				match(T__9);
				setState(167);
				((IfStatementContext)_localctx).n = num(0);
				setState(168);
				match(T__6);
				setState(169);
				((IfStatementContext)_localctx).ifExpL = exprList();
				setState(170);
				match(T__10);
				setState(171);
				((IfStatementContext)_localctx).elseExpL = exprList();

				        ((IfStatementContext)_localctx).i =  new IfNode(((IfStatementContext)_localctx).n.i, new ArrayList(((IfStatementContext)_localctx).ifExpL.i), new ArrayList(((IfStatementContext)_localctx).elseExpL.i));
				    
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(174);
				match(T__9);
				setState(175);
				((IfStatementContext)_localctx).n = num(0);
				setState(176);
				match(T__6);
				setState(177);
				((IfStatementContext)_localctx).ifExpL = exprList();

				        ((IfStatementContext)_localctx).i =  new IfNode(((IfStatementContext)_localctx).n.i, new ArrayList(((IfStatementContext)_localctx).ifExpL.i), null);
				    
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
		public ExprListContext expL;
		public List<NumContext> num() {
			return getRuleContexts(NumContext.class);
		}
		public NumContext num(int i) {
			return getRuleContext(NumContext.class,i);
		}
		public ExprListContext exprList() {
			return getRuleContext(ExprListContext.class,0);
		}
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
		enterRule(_localctx, 20, RULE_forLoop);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(182);
			match(T__11);
			setState(183);
			((ForLoopContext)_localctx).n1 = num(0);
			setState(184);
			match(T__0);
			setState(185);
			((ForLoopContext)_localctx).n2 = num(0);
			setState(186);
			match(T__0);
			setState(187);
			((ForLoopContext)_localctx).n3 = num(0);
			setState(188);
			match(T__6);
			setState(189);
			((ForLoopContext)_localctx).expL = exprList();

			        ((ForLoopContext)_localctx).i =  new ForNode(((ForLoopContext)_localctx).n1.i, ((ForLoopContext)_localctx).n2.i, ((ForLoopContext)_localctx).n3.i, new ArrayList(((ForLoopContext)_localctx).expL.i));
			    
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
		public ExprListContext expL;
		public TerminalNode ID() { return getToken(GrammarParser.ID, 0); }
		public FxnArgListContext fxnArgList() {
			return getRuleContext(FxnArgListContext.class,0);
		}
		public ExprListContext exprList() {
			return getRuleContext(ExprListContext.class,0);
		}
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
		enterRule(_localctx, 22, RULE_defineFxn);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(192);
			match(T__12);
			setState(193);
			((DefineFxnContext)_localctx).ID = match(ID);
			setState(194);
			match(T__13);
			setState(195);
			((DefineFxnContext)_localctx).fAL = fxnArgList();
			setState(196);
			match(T__6);
			setState(197);
			((DefineFxnContext)_localctx).expL = exprList();

			        ((DefineFxnContext)_localctx).i =  new DefineFxnNode(((DefineFxnContext)_localctx).ID.getText(), new ArrayList(((DefineFxnContext)_localctx).fAL.i), new ArrayList(((DefineFxnContext)_localctx).expL.i));
			    
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
		enterRule(_localctx, 24, RULE_fxnArgList);
		try {
			setState(207);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,16,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(200);
				((FxnArgListContext)_localctx).ID = match(ID);
				setState(201);
				match(T__2);
				setState(202);
				((FxnArgListContext)_localctx).fAL = fxnArgList();

				        LinkedList<String> partSolvedList = ((FxnArgListContext)_localctx).fAL.i;
				        partSolvedList.push(((FxnArgListContext)_localctx).ID.getText());
				        ((FxnArgListContext)_localctx).i =  partSolvedList;
				    
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(205);
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
		int _startState = 26;
		enterRecursionRule(_localctx, 26, RULE_num, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(229);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,17,_ctx) ) {
			case 1:
				{
				setState(210);
				((NumContext)_localctx).f = fxn();
				 ((NumContext)_localctx).i =  ((NumContext)_localctx).f.i; 
				}
				break;
			case 2:
				{
				setState(213);
				((NumContext)_localctx).p = parens();
				 ((NumContext)_localctx).i =  ((NumContext)_localctx).p.i; 
				}
				break;
			case 3:
				{
				setState(216);
				((NumContext)_localctx).uA = uniArith();
				 ((NumContext)_localctx).i =  ((NumContext)_localctx).uA.i; 
				}
				break;
			case 4:
				{
				setState(219);
				((NumContext)_localctx).a = assign();
				 ((NumContext)_localctx).i =  ((NumContext)_localctx).a.i; 
				}
				break;
			case 5:
				{
				setState(222);
				((NumContext)_localctx).uL = uniLogic();
				 ((NumContext)_localctx).i =  ((NumContext)_localctx).uL.i; 
				}
				break;
			case 6:
				{
				setState(225);
				((NumContext)_localctx).ID = match(ID);

				        ((NumContext)_localctx).i =  new IDNode(  ((NumContext)_localctx).ID.getText()  );
				    
				}
				break;
			case 7:
				{
				setState(227);
				((NumContext)_localctx).NUM = match(NUM);

				        ((NumContext)_localctx).i =  new ConstNode(  Double.parseDouble(((NumContext)_localctx).NUM.getText())  );
				    
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(270);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,19,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(268);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,18,_ctx) ) {
					case 1:
						{
						_localctx = new NumContext(_parentctx, _parentState);
						_localctx.nl = _prevctx;
						_localctx.nl = _prevctx;
						pushNewRecursionContext(_localctx, _startState, RULE_num);
						setState(231);
						if (!(precpred(_ctx, 11))) throw new FailedPredicateException(this, "precpred(_ctx, 11)");
						setState(232);
						((NumContext)_localctx).op1 = match(T__14);
						setState(233);
						((NumContext)_localctx).nm = num(0);
						setState(234);
						((NumContext)_localctx).op2 = match(T__14);
						setState(235);
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
						setState(238);
						if (!(precpred(_ctx, 10))) throw new FailedPredicateException(this, "precpred(_ctx, 10)");
						setState(239);
						((NumContext)_localctx).op = match(T__14);
						setState(240);
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
						setState(243);
						if (!(precpred(_ctx, 9))) throw new FailedPredicateException(this, "precpred(_ctx, 9)");
						setState(244);
						((NumContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__15) | (1L << T__16) | (1L << T__17))) != 0)) ) {
							((NumContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(245);
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
						setState(248);
						if (!(precpred(_ctx, 8))) throw new FailedPredicateException(this, "precpred(_ctx, 8)");
						setState(249);
						((NumContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !(_la==T__18 || _la==T__19) ) {
							((NumContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(250);
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
						setState(253);
						if (!(precpred(_ctx, 6))) throw new FailedPredicateException(this, "precpred(_ctx, 6)");
						setState(254);
						((NumContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__20) | (1L << T__21) | (1L << T__22) | (1L << T__23) | (1L << T__24) | (1L << T__25))) != 0)) ) {
							((NumContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(255);
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
						setState(258);
						if (!(precpred(_ctx, 4))) throw new FailedPredicateException(this, "precpred(_ctx, 4)");
						setState(259);
						((NumContext)_localctx).op = match(T__26);
						setState(260);
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
						setState(263);
						if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
						setState(264);
						((NumContext)_localctx).op = match(T__27);
						setState(265);
						((NumContext)_localctx).nr = num(4);

						                  ((NumContext)_localctx).i =  new BinNode(((NumContext)_localctx).nl.i, ((NumContext)_localctx).op.getText(), ((NumContext)_localctx).nr.i);
						              
						}
						break;
					}
					} 
				}
				setState(272);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,19,_ctx);
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
		enterRule(_localctx, 28, RULE_fxn);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(273);
			((FxnContext)_localctx).ID = match(ID);
			setState(274);
			match(T__13);
			setState(275);
			((FxnContext)_localctx).numList = numArgList();
			setState(276);
			match(T__6);

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
		enterRule(_localctx, 30, RULE_numArgList);
		try {
			setState(287);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,20,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(279);
				((NumArgListContext)_localctx).n = num(0);
				setState(280);
				match(T__2);
				setState(281);
				((NumArgListContext)_localctx).nl = numArgList();

				        LinkedList<NumNode> partSolvedList = ((NumArgListContext)_localctx).nl.i;
				        partSolvedList.push(((NumArgListContext)_localctx).n.i);
				        ((NumArgListContext)_localctx).i =  partSolvedList;
				    
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(284);
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
		enterRule(_localctx, 32, RULE_parens);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(289);
			match(T__13);
			setState(290);
			((ParensContext)_localctx).n = num(0);
			setState(291);
			match(T__6);

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
		enterRule(_localctx, 34, RULE_uniArith);
		int _la;
		try {
			setState(304);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__28:
			case T__29:
				enterOuterAlt(_localctx, 1);
				{
				setState(294);
				((UniArithContext)_localctx).op = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==T__28 || _la==T__29) ) {
					((UniArithContext)_localctx).op = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(295);
				((UniArithContext)_localctx).ID = match(ID);

				        ((UniArithContext)_localctx).i =  new SelfAssNode(((UniArithContext)_localctx).ID.getText(), ((UniArithContext)_localctx).op.getText(), true);
				    
				}
				break;
			case ID:
				enterOuterAlt(_localctx, 2);
				{
				setState(297);
				((UniArithContext)_localctx).ID = match(ID);
				setState(298);
				((UniArithContext)_localctx).op = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==T__28 || _la==T__29) ) {
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
			case T__19:
				enterOuterAlt(_localctx, 3);
				{
				setState(300);
				((UniArithContext)_localctx).op = match(T__19);
				setState(301);
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
		enterRule(_localctx, 36, RULE_assign);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(306);
			((AssignContext)_localctx).ID = match(ID);
			setState(307);
			((AssignContext)_localctx).op = _input.LT(1);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__30) | (1L << T__31) | (1L << T__32) | (1L << T__33) | (1L << T__34))) != 0)) ) {
				((AssignContext)_localctx).op = (Token)_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(308);
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
		enterRule(_localctx, 38, RULE_uniLogic);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(311);
			((UniLogicContext)_localctx).op = match(T__35);
			setState(312);
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
		case 13:
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3-\u013e\4\2\t\2\4"+
		"\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t"+
		"\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\3\2\7\2,\n\2\f\2\16\2/\13\2\3\2\3\2\6\2"+
		"\63\n\2\r\2\16\2\64\7\2\67\n\2\f\2\16\2:\13\2\3\2\3\2\3\2\3\3\3\3\3\3"+
		"\3\4\3\4\3\4\3\4\3\4\3\4\5\4H\n\4\3\5\3\5\3\5\3\5\3\6\3\6\3\6\3\6\3\6"+
		"\3\6\3\6\3\6\3\6\3\6\3\6\3\6\3\6\3\6\3\6\5\6]\n\6\3\7\3\7\3\7\3\7\3\7"+
		"\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\5\7n\n\7\3\b\3\b\6\br\n\b\r\b"+
		"\16\bs\3\b\3\b\3\b\3\b\3\b\3\b\5\b|\n\b\3\t\3\t\7\t\u0080\n\t\f\t\16\t"+
		"\u0083\13\t\3\t\3\t\7\t\u0087\n\t\f\t\16\t\u008a\13\t\3\t\3\t\3\t\3\n"+
		"\3\n\3\n\3\n\5\n\u0093\n\n\3\n\5\n\u0096\n\n\3\n\3\n\3\n\3\n\3\n\3\n\3"+
		"\n\5\n\u009f\n\n\3\n\5\n\u00a2\n\n\3\n\3\n\3\n\5\n\u00a7\n\n\3\13\3\13"+
		"\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\5\13\u00b7"+
		"\n\13\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\r\3\r\3\r\3\r\3\r\3\r"+
		"\3\r\3\r\3\16\3\16\3\16\3\16\3\16\3\16\3\16\5\16\u00d2\n\16\3\17\3\17"+
		"\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17"+
		"\3\17\3\17\3\17\3\17\5\17\u00e8\n\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17"+
		"\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17"+
		"\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17"+
		"\3\17\3\17\7\17\u010f\n\17\f\17\16\17\u0112\13\17\3\20\3\20\3\20\3\20"+
		"\3\20\3\20\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\5\21\u0122\n\21\3\22"+
		"\3\22\3\22\3\22\3\22\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\23"+
		"\5\23\u0133\n\23\3\24\3\24\3\24\3\24\3\24\3\25\3\25\3\25\3\25\3\25\2\3"+
		"\34\26\2\4\6\b\n\f\16\20\22\24\26\30\32\34\36 \"$&(\2\b\4\2\3\3--\3\2"+
		"\22\24\3\2\25\26\3\2\27\34\3\2\37 \3\2!%\2\u014f\2-\3\2\2\2\4>\3\2\2\2"+
		"\6G\3\2\2\2\bI\3\2\2\2\n\\\3\2\2\2\fm\3\2\2\2\16{\3\2\2\2\20}\3\2\2\2"+
		"\22\u00a6\3\2\2\2\24\u00b6\3\2\2\2\26\u00b8\3\2\2\2\30\u00c2\3\2\2\2\32"+
		"\u00d1\3\2\2\2\34\u00e7\3\2\2\2\36\u0113\3\2\2\2 \u0121\3\2\2\2\"\u0123"+
		"\3\2\2\2$\u0132\3\2\2\2&\u0134\3\2\2\2(\u0139\3\2\2\2*,\t\2\2\2+*\3\2"+
		"\2\2,/\3\2\2\2-+\3\2\2\2-.\3\2\2\2.8\3\2\2\2/-\3\2\2\2\60\62\5\4\3\2\61"+
		"\63\t\2\2\2\62\61\3\2\2\2\63\64\3\2\2\2\64\62\3\2\2\2\64\65\3\2\2\2\65"+
		"\67\3\2\2\2\66\60\3\2\2\2\67:\3\2\2\28\66\3\2\2\289\3\2\2\29;\3\2\2\2"+
		":8\3\2\2\2;<\7\2\2\3<=\b\2\1\2=\3\3\2\2\2>?\5\6\4\2?@\b\3\1\2@\5\3\2\2"+
		"\2AB\5\f\7\2BC\b\4\1\2CH\3\2\2\2DE\5\34\17\2EF\b\4\1\2FH\3\2\2\2GA\3\2"+
		"\2\2GD\3\2\2\2H\7\3\2\2\2IJ\7\4\2\2JK\5\n\6\2KL\b\5\1\2L\t\3\2\2\2MN\5"+
		"\34\17\2NO\7\5\2\2OP\5\n\6\2PQ\b\6\1\2Q]\3\2\2\2RS\7)\2\2ST\7\5\2\2TU"+
		"\5\n\6\2UV\b\6\1\2V]\3\2\2\2WX\5\34\17\2XY\b\6\1\2Y]\3\2\2\2Z[\7)\2\2"+
		"[]\b\6\1\2\\M\3\2\2\2\\R\3\2\2\2\\W\3\2\2\2\\Z\3\2\2\2]\13\3\2\2\2^_\5"+
		"\24\13\2_`\b\7\1\2`n\3\2\2\2ab\5\22\n\2bc\b\7\1\2cn\3\2\2\2de\5\26\f\2"+
		"ef\b\7\1\2fn\3\2\2\2gh\5\30\r\2hi\b\7\1\2in\3\2\2\2jk\5\b\5\2kl\b\7\1"+
		"\2ln\3\2\2\2m^\3\2\2\2ma\3\2\2\2md\3\2\2\2mg\3\2\2\2mj\3\2\2\2n\r\3\2"+
		"\2\2oq\5\6\4\2pr\t\2\2\2qp\3\2\2\2rs\3\2\2\2sq\3\2\2\2st\3\2\2\2tu\3\2"+
		"\2\2uv\5\16\b\2vw\b\b\1\2w|\3\2\2\2xy\5\6\4\2yz\b\b\1\2z|\3\2\2\2{o\3"+
		"\2\2\2{x\3\2\2\2|\17\3\2\2\2}\u0081\7\6\2\2~\u0080\t\2\2\2\177~\3\2\2"+
		"\2\u0080\u0083\3\2\2\2\u0081\177\3\2\2\2\u0081\u0082\3\2\2\2\u0082\u0084"+
		"\3\2\2\2\u0083\u0081\3\2\2\2\u0084\u0088\5\16\b\2\u0085\u0087\t\2\2\2"+
		"\u0086\u0085\3\2\2\2\u0087\u008a\3\2\2\2\u0088\u0086\3\2\2\2\u0088\u0089"+
		"\3\2\2\2\u0089\u008b\3\2\2\2\u008a\u0088\3\2\2\2\u008b\u008c\7\7\2\2\u008c"+
		"\u008d\b\t\1\2\u008d\21\3\2\2\2\u008e\u008f\7\b\2\2\u008f\u0090\5\34\17"+
		"\2\u0090\u0095\7\t\2\2\u0091\u0093\7\n\2\2\u0092\u0091\3\2\2\2\u0092\u0093"+
		"\3\2\2\2\u0093\u0094\3\2\2\2\u0094\u0096\7\13\2\2\u0095\u0092\3\2\2\2"+
		"\u0095\u0096\3\2\2\2\u0096\u0097\3\2\2\2\u0097\u0098\5\20\t\2\u0098\u0099"+
		"\b\n\1\2\u0099\u00a7\3\2\2\2\u009a\u009b\7\b\2\2\u009b\u009c\5\34\17\2"+
		"\u009c\u00a1\7\t\2\2\u009d\u009f\7\n\2\2\u009e\u009d\3\2\2\2\u009e\u009f"+
		"\3\2\2\2\u009f\u00a0\3\2\2\2\u00a0\u00a2\7\13\2\2\u00a1\u009e\3\2\2\2"+
		"\u00a1\u00a2\3\2\2\2\u00a2\u00a3\3\2\2\2\u00a3\u00a4\5\6\4\2\u00a4\u00a5"+
		"\b\n\1\2\u00a5\u00a7\3\2\2\2\u00a6\u008e\3\2\2\2\u00a6\u009a\3\2\2\2\u00a7"+
		"\23\3\2\2\2\u00a8\u00a9\7\f\2\2\u00a9\u00aa\5\34\17\2\u00aa\u00ab\7\t"+
		"\2\2\u00ab\u00ac\5\16\b\2\u00ac\u00ad\7\r\2\2\u00ad\u00ae\5\16\b\2\u00ae"+
		"\u00af\b\13\1\2\u00af\u00b7\3\2\2\2\u00b0\u00b1\7\f\2\2\u00b1\u00b2\5"+
		"\34\17\2\u00b2\u00b3\7\t\2\2\u00b3\u00b4\5\16\b\2\u00b4\u00b5\b\13\1\2"+
		"\u00b5\u00b7\3\2\2\2\u00b6\u00a8\3\2\2\2\u00b6\u00b0\3\2\2\2\u00b7\25"+
		"\3\2\2\2\u00b8\u00b9\7\16\2\2\u00b9\u00ba\5\34\17\2\u00ba\u00bb\7\3\2"+
		"\2\u00bb\u00bc\5\34\17\2\u00bc\u00bd\7\3\2\2\u00bd\u00be\5\34\17\2\u00be"+
		"\u00bf\7\t\2\2\u00bf\u00c0\5\16\b\2\u00c0\u00c1\b\f\1\2\u00c1\27\3\2\2"+
		"\2\u00c2\u00c3\7\17\2\2\u00c3\u00c4\7*\2\2\u00c4\u00c5\7\20\2\2\u00c5"+
		"\u00c6\5\32\16\2\u00c6\u00c7\7\t\2\2\u00c7\u00c8\5\16\b\2\u00c8\u00c9"+
		"\b\r\1\2\u00c9\31\3\2\2\2\u00ca\u00cb\7*\2\2\u00cb\u00cc\7\5\2\2\u00cc"+
		"\u00cd\5\32\16\2\u00cd\u00ce\b\16\1\2\u00ce\u00d2\3\2\2\2\u00cf\u00d0"+
		"\7*\2\2\u00d0\u00d2\b\16\1\2\u00d1\u00ca\3\2\2\2\u00d1\u00cf\3\2\2\2\u00d2"+
		"\33\3\2\2\2\u00d3\u00d4\b\17\1\2\u00d4\u00d5\5\36\20\2\u00d5\u00d6\b\17"+
		"\1\2\u00d6\u00e8\3\2\2\2\u00d7\u00d8\5\"\22\2\u00d8\u00d9\b\17\1\2\u00d9"+
		"\u00e8\3\2\2\2\u00da\u00db\5$\23\2\u00db\u00dc\b\17\1\2\u00dc\u00e8\3"+
		"\2\2\2\u00dd\u00de\5&\24\2\u00de\u00df\b\17\1\2\u00df\u00e8\3\2\2\2\u00e0"+
		"\u00e1\5(\25\2\u00e1\u00e2\b\17\1\2\u00e2\u00e8\3\2\2\2\u00e3\u00e4\7"+
		"*\2\2\u00e4\u00e8\b\17\1\2\u00e5\u00e6\7+\2\2\u00e6\u00e8\b\17\1\2\u00e7"+
		"\u00d3\3\2\2\2\u00e7\u00d7\3\2\2\2\u00e7\u00da\3\2\2\2\u00e7\u00dd\3\2"+
		"\2\2\u00e7\u00e0\3\2\2\2\u00e7\u00e3\3\2\2\2\u00e7\u00e5\3\2\2\2\u00e8"+
		"\u0110\3\2\2\2\u00e9\u00ea\f\r\2\2\u00ea\u00eb\7\21\2\2\u00eb\u00ec\5"+
		"\34\17\2\u00ec\u00ed\7\21\2\2\u00ed\u00ee\5\34\17\16\u00ee\u00ef\b\17"+
		"\1\2\u00ef\u010f\3\2\2\2\u00f0\u00f1\f\f\2\2\u00f1\u00f2\7\21\2\2\u00f2"+
		"\u00f3\5\34\17\r\u00f3\u00f4\b\17\1\2\u00f4\u010f\3\2\2\2\u00f5\u00f6"+
		"\f\13\2\2\u00f6\u00f7\t\3\2\2\u00f7\u00f8\5\34\17\f\u00f8\u00f9\b\17\1"+
		"\2\u00f9\u010f\3\2\2\2\u00fa\u00fb\f\n\2\2\u00fb\u00fc\t\4\2\2\u00fc\u00fd"+
		"\5\34\17\13\u00fd\u00fe\b\17\1\2\u00fe\u010f\3\2\2\2\u00ff\u0100\f\b\2"+
		"\2\u0100\u0101\t\5\2\2\u0101\u0102\5\34\17\t\u0102\u0103\b\17\1\2\u0103"+
		"\u010f\3\2\2\2\u0104\u0105\f\6\2\2\u0105\u0106\7\35\2\2\u0106\u0107\5"+
		"\34\17\7\u0107\u0108\b\17\1\2\u0108\u010f\3\2\2\2\u0109\u010a\f\5\2\2"+
		"\u010a\u010b\7\36\2\2\u010b\u010c\5\34\17\6\u010c\u010d\b\17\1\2\u010d"+
		"\u010f\3\2\2\2\u010e\u00e9\3\2\2\2\u010e\u00f0\3\2\2\2\u010e\u00f5\3\2"+
		"\2\2\u010e\u00fa\3\2\2\2\u010e\u00ff\3\2\2\2\u010e\u0104\3\2\2\2\u010e"+
		"\u0109\3\2\2\2\u010f\u0112\3\2\2\2\u0110\u010e\3\2\2\2\u0110\u0111\3\2"+
		"\2\2\u0111\35\3\2\2\2\u0112\u0110\3\2\2\2\u0113\u0114\7*\2\2\u0114\u0115"+
		"\7\20\2\2\u0115\u0116\5 \21\2\u0116\u0117\7\t\2\2\u0117\u0118\b\20\1\2"+
		"\u0118\37\3\2\2\2\u0119\u011a\5\34\17\2\u011a\u011b\7\5\2\2\u011b\u011c"+
		"\5 \21\2\u011c\u011d\b\21\1\2\u011d\u0122\3\2\2\2\u011e\u011f\5\34\17"+
		"\2\u011f\u0120\b\21\1\2\u0120\u0122\3\2\2\2\u0121\u0119\3\2\2\2\u0121"+
		"\u011e\3\2\2\2\u0122!\3\2\2\2\u0123\u0124\7\20\2\2\u0124\u0125\5\34\17"+
		"\2\u0125\u0126\7\t\2\2\u0126\u0127\b\22\1\2\u0127#\3\2\2\2\u0128\u0129"+
		"\t\6\2\2\u0129\u012a\7*\2\2\u012a\u0133\b\23\1\2\u012b\u012c\7*\2\2\u012c"+
		"\u012d\t\6\2\2\u012d\u0133\b\23\1\2\u012e\u012f\7\26\2\2\u012f\u0130\5"+
		"\34\17\2\u0130\u0131\b\23\1\2\u0131\u0133\3\2\2\2\u0132\u0128\3\2\2\2"+
		"\u0132\u012b\3\2\2\2\u0132\u012e\3\2\2\2\u0133%\3\2\2\2\u0134\u0135\7"+
		"*\2\2\u0135\u0136\t\7\2\2\u0136\u0137\5\34\17\2\u0137\u0138\b\24\1\2\u0138"+
		"\'\3\2\2\2\u0139\u013a\7&\2\2\u013a\u013b\5\34\17\2\u013b\u013c\b\25\1"+
		"\2\u013c)\3\2\2\2\30-\648G\\ms{\u0081\u0088\u0092\u0095\u009e\u00a1\u00a6"+
		"\u00b6\u00d1\u00e7\u010e\u0110\u0121\u0132";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}