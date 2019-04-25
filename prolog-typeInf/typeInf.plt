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

% test the if that has both an if and an else
test(ifStatement, [nondet]) :-
    typeStatement(if(lesser(X,float), [int], [int]), T),
    assertion(X==float), assertion(T==int).

% test the if statement that has both an if and an else, this fails because both if clauses do not have the same type
test(ifStatement_t2, [fail]) :-
    typeStatement(if(lesser(X,float), [int], [float]), T),
    assertion(X==float), assertion(T==int).

% test the if with no else
test(ifStatement_t3, [nondet]) :-
    typeStatement(if(lesser(X,float), [int]), T),
    assertion(X==float), assertion(T==int).

% test the while loop
test(whileStatement, [nondet]) :-
    typeStatement(while(greater(float,float), [bool]), T),
    assertion(T==bool).

% test gvlet, assign an int
test(gvLetInt, [nondet]) :-
    deleteGVars(),
    deleteLVars(),
    typeStatement(gvLet(i, TAssign, iPlus(int, int)), T),
    assertion(T==unit), assertion(TAssign==int).

% test gvlet, assign a float
test(gvLetFloat, [nondet]) :-
    deleteGVars(),
    deleteLVars(),
    typeStatement(gvLet(i, TAssign, fPlus(float, float)), T),
    assertion(T==unit), assertion(TAssign==float).

% test inference of a statement as an expression
test(t5, [nondet]) :-
    typeStatement(unit, T),
    assertion(T==unit).

% unit test the for loop and hardcode the different parts to their specific type
test(forStatement, [nondet]) :-
    typeStatement(for(unit, bool, unit, [bool]), T),
    assertion(T==bool).

% 'integration' test the for loop, use the different components and build an actual loop
test(t7, [nondet]) :-
    deleteGVars(),
    deleteLVars(),
    typeStatement(
        for(gvLet(i, TAssign, float), 
            greater(float,float),
            gvLet(i, TAssign, fPlus(i, float)),
            [gvLet(a, float, fPlus(i, float))]),
        T2),
    assertion(T2==unit).

test(t8, [nondet]) :-
    deleteGVars(),
    deleteLVars(),
    typeStatement(gvLet(v, T, iPlus(X, Y)), unit),
    assertion(T==int), assertion(X==int), assertion(Y==int),
    gvar(v,int).

% should fail because we are declaring a LOCAL variable, which does not persist after the type inference on the code
test(t9, [fail]) :-
    deleteGVars(),
    deleteLVars(),
    typeStatement(lvLet(v, T, iPlus(X, Y), [bool]), unit),
    assertion(T==int), assertion(X==int), assertion(Y==int),
    lvar(v,int).

% tests local variables
test(t10, [nondet]) :-
    deleteGVars(),
    deleteLVars(),
    typeStatement(lvLet(v, int, iPlus(int, int), [iPlus(v, int)]), Z),
    assertion(Z==int).

% same test as above but with infer, also tests that the lvar is not present after the infer
test(t11, [nondet]) :-
    infer([lvLet(v, int, iPlus(int, int), [iPlus(v, int)])], Y),
    assertion(Y==int),
    \+ lvar(v,int).

% same test as above but passes because global variables are used instead of local variables
test(t12, [nondet]) :-
    infer([gvLet(v, int, iPlus(int, int)), iPlus(v, int)], int),
    gvar(v,int).

% general infer test, tests the fPlus function
test(t13, [nondet]) :-
    infer([fPlus(float,float)], T),
    assertion(T==float).

% test that the last piece of code in a code block is the type that is inferrred
test(t14, [nondet]) :- 
    infer([fPlus(float,float), iPlus(int,int)], T),
    assertion(T==int).

test(infer_typeExp_iplus, [nondet]) :-
    infer([iPlus(int,int), bool], bool).

test(infer_typeExp_iplus_F, [fail]) :-
    infer([iPlus(int, int)], float).

test(infer_typeExp_fplus, [nondet]) :-
    infer([fPlus(float,float)], float).

test(infer_typeExp_fplus_F, [fail]) :-
    infer([fPlus(float, float)], int).

test(infer_typeStatement_gvar, [nondet]) :-
    infer([gvLet(u, T1, iPlus(_, _)),
           gvLet(v, T2, fPlus(_, _)),
           iPlus(u, int),
           fPlus(v, float)], float),
    assertion(T1==int),
    assertion(T2==float).

test(infer_mockedFct, [nondet]) :-
    asserta(gvar(my_fct, [int, float])),
    infer([my_fct(X)], float),
    assertion(X==int).

test(infer_ifStatement, [nondet]) :-
    infer([if(lesser(X,float), [int], [int])], int),
    assertion(X==float).

test(infer_ifStatement2, [nondet]) :- % an if with no else
    infer([if(lesser(X,float), [int])], int),
    assertion(X==float).

test(infer_whileStatement, [nondet]) :-
    infer([while(greater(float,float), [bool])], bool).

test(infer_gvLetInt, [nondet]) :-
    infer([gvLet(i, TAssign, iPlus(int, int))], unit),
    assertion(TAssign==int).

test(infer_gvLetFloat, [nondet]) :-
    infer([gvLet(i, TAssign, fPlus(float, float))], unit),
    assertion(TAssign==float).

test(infer_t5, [nondet]) :-
    infer([unit], unit).

test(infer_forStatement, [nondet]) :-
    infer([for(unit, bool, unit, [bool])], bool).

test(infer_t7, [nondet]) :-
    infer([for(gvLet(i, TAssign, fPlus(float, float)),
            greater(float,float),
            gvLet(j, TAssign, fPlus(float, float)),
            [bool])], bool),
    assertion(TAssign==float).

test(infer_t8, [nondet]) :-
    infer([gvLet(v, T, iPlus(X, Y))], unit),
    assertion(T==int), assertion(X==int), assertion(Y==int),
    gvar(v,int).

test(infer_t9, [fail]) :-
    infer([lvLet(v, T, iPlus(X, Y), [bool])], unit),
    assertion(T==int), assertion(X==int), assertion(Y==int),
    lvar(v,int).

test(infer_t10, [nondet]) :-
    infer([lvLet(v, int, iPlus(int, int), [iPlus(v, int)])], int).

:- end_tests(typeInf).