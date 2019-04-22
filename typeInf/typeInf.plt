:- begin_tests(typeInf).
:- include(typeInf).

/* Note: when writing tests keep in mind that
    the use of of global variable and function definitions
    define facts for gvar() predicate. Either test
    directy infer() predicate or call
    delegeGVars() predicate to clean up gvar().
*/

% tests for typeExp
test(typeExp_iplus) :-
    typeExp(iPlus(int,int), int).
test(typeExp_iplus_T, [true(T == int)]) :-
    typeExp(iPlus(int, int), T).
test(typeExp_iplus_F, [fail]) :-
    typeExp(iPlus(int, int), float).

test(typeExp_fplus) :-
    typeExp(fPlus(float,float), float).
test(typeExp_fplus_T, [true(T == float)]) :-
    typeExp(fPlus(float, float), T).
test(typeExp_fplus_F, [fail]) :-
    typeExp(fPlus(float, float), int).

% test for statement with state cleaning
test(typeStatement_gvar, [nondet, true(T == int)]) :- % should succeed with T=int
    deleteGVars(), % clean up variables
    deleteLVars(),
    typeStatement(gvLet(v, T, iPlus(X, Y)), unit),
    assertion(X == int), assertion( Y == int), % make sure the types are int
    gvar(v, int). % make sure the global variable is defined

% same test as above but with infer
test(infer_gvar, [nondet]) :-
    infer([gvLet(v, T, iPlus(X, Y))], unit),
    assertion(T==int), assertion(X==int), assertion(Y=int),
    gvar(v,int).

% test custom function with mocked definition
test(mockedFct, [nondet]) :-
    asserta(gvar(my_fct, [int, float])), % add my_fct(int)-> float to the gloval variables
    typeExp(my_fct(X), T), % infer type of expression using or function
    assertion(X==int), assertion(T==float). % make sure the types infered are correct

test(ifStatement, [nondet]) :-
    typeStatement(if(lesser(X,float), [int], [int]), T),
    assertion(X==float), assertion(T==int).

test(ifStatement2, [nondet]) :- % an if with no else
    typeStatement(if(lesser(X,float), [int]), T),
    assertion(X==float), assertion(T==int).

test(whileStatement, [nondet]) :-
    typeStatement(while(greater(float,float), [bool]), T),
    assertion(T==bool).

test(gvLetInt, [nondet]) :-
    deleteGVars(),
    deleteLVars(),
    typeStatement(gvLet(i, TAssign, iPlus(int, int)), T),
    assertion(T==unit), assertion(TAssign==int).

test(gvLetFloat, [nondet]) :-
    deleteGVars(),
    deleteLVars(),
    typeStatement(gvLet(i, TAssign, fPlus(float, float)), T),
    assertion(T==unit), assertion(TAssign==float).

test(t5, [nondet]) :- % test inference of a statement as an expression
    typeStatement(unit, T),
    assertion(T==unit).

test(forStatement, [nondet]) :-
    typeStatement(for(unit, bool, unit, [bool]), T),
    assertion(T==bool).

test(t7, [nondet]) :-
    deleteGVars(),
    deleteLVars(),
    typeStatement(
        for(gvLet(i, TAssign, fPlus(float, float)), 
            greater(float,float),
            gvLet(j, TAssign, fPlus(float, float)),
            [bool]),
        T2),
    assertion(TAssign==float), assertion(T2==bool).

test(t8, [nondet]) :-
    deleteGVars(),
    deleteLVars(),
    typeStatement(gvLet(v, T, iPlus(X, Y)), unit),
    assertion(T==int), assertion(X==int), assertion(Y==int),
    gvar(v,int).

test(t9, [fail]) :- % should fail because we are declaring a LOCAL variable, which does not persist after the type inference on the code
    deleteGVars(),
    deleteLVars(),
    typeStatement(lvLet(v, T, iPlus(X, Y), [bool]), unit),
    assertion(T==int), assertion(X==int), assertion(Y==int),
    lvar(v,int).

test(t10, [nondet]) :-
    deleteGVars(),
    deleteLVars(),
    typeStatement(lvLet(v, int, iPlus(int, int), [iPlus(v, int)]), Z),
    assertion(Z==int).

% same test as above but with infer
test(t11, [nondet]) :-
    infer([lvLet(v, int, iPlus(int, int), [iPlus(v, int)])], Y),
    assertion(Y==int).

% same test as above but fails because local variables dont persist
test(t12, [nondet]) :-
    infer([lvLet(v, int, iPlus(int, int), [iPlus(v, int)])], int),
    \+ lvar(v,int).

:- end_tests(typeInf).