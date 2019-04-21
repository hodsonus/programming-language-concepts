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

test(typeExp_iplus_F, [fail]) :- % should fail
    typeExp(iPlus(int, int), float).

% test for statement with state cleaning
test(typeStatement_gvar, [nondet, true(T == int)]) :- % should succeed with T=int
    deleteGVars(), % clean up variables
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
    deleteGVars(), % clean up variables since we cannot use infer
    asserta(gvar(my_fct, [int, float])), % add my_fct(int)-> float to the gloval variables
    typeExp(my_fct(X), T), % infer type of expression using or function
    assertion(X==int), assertion(T==float). % make sure the types infered are correct

test(ifStatement, [nondet]) :-
    typeStatement(if(lesser(X,float), [int], [int]), T),
    assertion(X==float), assertion(T==int).

test(whileStatement, [nondet]) :-
    typeStatement(while(greater(float,float), [bool]), T),
    assertion(T==bool).

test(gvLetInt, [nondet]) :-
    deleteGVars(),
    typeStatement(gvLet(i, TAssign, iPlus(int, int)), T),
    assertion(T==unit), assertion(TAssign==int).

test(gvLetFloat, [nondet]) :-
    deleteGVars(),
    typeStatement(gvLet(i, TAssign, fPlus(float, float)), T),
    assertion(T==unit), assertion(TAssign==float).

test(t5, [nondet]) :-
    deleteGVars(),
    typeStatement(unit, T),
    assertion(T==unit).

test(forStatement, [nondet]) :-
    deleteGVars(),
    typeStatement(for(unit, bool, unit, [bool]), T),
    assertion(T==bool).

test(t7, [nondet]) :-
    deleteGVars(),
    typeStatement(
        for(gvLet(i, TAssign, fPlus(float, float)), 
            greater(float,float),
            gvLet(j, TAssign, fPlus(float, float)),
            [bool]),
        T2),
    assertion(TAssign==float), assertion(T2==bool).

:-end_tests(typeInf).
