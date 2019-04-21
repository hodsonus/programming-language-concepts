% loops discouraged, use trace for debugging, reload code often

% 'asserta' adds a new definition to gvars with first priority
% 'assertz' adds a new definition to gvars with last priority
% both run on unification - and take the place of hash tables in OCaml
% deleteGVars - sets up the whole system, the call here prevents exceptions from being thrown when it sees no Gvars

% NOTE: use nondet as option to test if the test is nondeterministic

% infer cleans
    % makes sure the code is a list
    % deletes the global variables
    % type code applys the type definitions
    % infer is usually the function that we want to test

% we have to write the code to define fucntions
% test the functons in a specific way - add a fact with a name (my_funct, for example) and the input type to the output type

% figure out how you can represent every type of statement - this is the equivalent of sum types in OCaml'
% this is necessary for the bonus

% be aware of the following
%     define some fxns that dont need to bind variables - let them work in a generic way
%     in Ocaml, the type infrerence mechanism can say a' -> a' (alpha type to alpha type)

% the only way to get things done here is through unification

%  write negative tests so that it fails
%  line 38 on the testing paltfor - put fails insteaf of nondet

% add a gvar
% 	when you delete them it

% 	knock off the definition at the end
% 	declare as dynamic ??
% 	dynamic name_of_predicate

/*
    as you encounter global variable definitions
    or global functions add their definitions to the database using:
        asserta( gvar(Name, Type) )
    To check the types as you encounter them in the code use:
        gvar(Name, Type) with the Name bound to the name.
    Type will be bound to the global type
    Examples:
        g
    Call the predicate deleveGVars() to delete all global
    variables. Best wy to do this is in your top predicate
*/

/* match functions by unifying with arguments and infering the result */
typeExp(Fct, T):-
    \+ var(Fct), /* make sure Fct is not a variable */
    \+ atom(Fct), /* or an atom */
    functor(Fct, Fname, _Nargs), /* ensure we have a functor */
    !, /* if we make it here we do not try anything else */
    Fct =.. [Fname|Args], /* get list of arguments */
    append(Args, [T], FType), /* make it look like a function signature */
    functionType(Fname, TArgs), /* get type of arguments from definition */
    typeExpList(FType, TArgs). /* recurisvely match types */

/* propagate types */
typeExp(T, T).

/* list version to allow function matching */
typeExpList([], []).
typeExpList([Hin|Tin], [Hout|Tout]):-
    typeExp(Hin, Hout), /* type infer the head */
    typeExpList(Tin, Tout). /* recurse */

/* list version to allow block matching */
typeStatementList([], []).
typeStatementList([Hin|Tin], [Hout|Tout]):-
    typeStatement(Hin, Hout), /* type infer the head */
    typeStatementList(Tin, Tout). /* recurse */

/* global variable definition
    Example:
        gvLet(v, T, int) ~ let v = 3;
 */
typeStatement(gvLet(Name, T, Code), unit) :-
    atom(Name), /* make sure we have a bound name */
    typeExp(Code, T), /* infer the type of Code and ensure it is T */
    bType(T), /* make sure we have an infered type */
    asserta(gvar(Name, T)). /* add definition to database */

/* Expressions are statements */
typeStatement(Expr, T) :-
    typeExp(Expr,T).

typeStatement(if(Cond, TCode, FCode),T) :-
    typeExp(Cond, bool),
    typeCode(TCode, T),
    typeCode(FCode, T),
    bType(T).

% an if with no else
typeStatement(if(Cond, TCode),T) :-
    typeExp(Cond, bool),
    typeCode(TCode, T),
    bType(T).

typeStatement(while(Cond, Code),T) :-
    typeExp(Cond, bool),
    typeCode(Code, T),
    bType(T).

typeStatement(for(Init, Cond, End, Code),T) :-
    typeStatement(Init, unit),
    typeExp(Cond, bool),
    typeStatement(End, unit),
    typeCode(Code, T),
    bType(T).

/* Code is simply a list of statements. The type is the type of the last statement */
typeCode([S], T):-typeStatement(S, T).
typeCode([S, S2|Code], T):-
    typeStatement(S,_T),
    typeCode([S2|Code], T).

/* top level function */
infer(Code, T) :-
    is_list(Code), /* make sure Code is a list */
    deleteGVars(), /* delete all global definitions */
    typeCode(Code, T).

/* Basic types */
bType(bool).
bType(int).
bType(float).
bType(string).
bType(unit).

/* Alpha types */
bType(T) :- var(T).

/* Functions type */
% The type is a list, the last element is the return type and can be called as add(1,2)->3
% E.g. add: int->int->int is represented as [int, int, int]
bType([H]) :- bType(H).
bType([H|T]) :- bType(H), bType(T).

deleteGVars() :-
    retractall(gvar),
    asserta(gvar(_X,_Y) :- false()).

fType(equal, [T, T, bool]).
fType(nequal, [T, T, bool]).
fType(lesser, [T, T, bool]).
fType(lesserEq, [T, T, bool]).
fType(greater, [T, T, bool]).
fType(greaterEq, [T, T, bool]).

fType(bAnd, [bool, bool, bool]).
fType(bOr, [bool, bool, bool]).
fType(bNot, [bool, bool]).

fType(iNeg, [int, int]).
fType(fNeg, [float, float]).

fType(iPlus, [int, int, int]).
fType(fPlus, [float, float, float]).
fType(iSub, [int, int, int]).
fType(fSub, [float, float, float]).
fType(iTimes, [int, int, int]).
fType(fTimes, [float, float, float]).
fType(iDivide, [int, int, int]).
fType(fDivide, [float, float, float]).
fType(iMod, [int, int, int]).
fType(fExp, [float, float, float]).
fType(fToInt, [float, int]).
fType(iToFlt, [int, float]).

fType(sConcat, [string, string, string]).

fType(print, [_X, unit]). /* simple print */
fType(identity, [T,T]). /* polymorphic function */
/* Find function signature
   A function is either buld in using fType or
   added as a user definition with gvar(fct, List)
*/

% Check the user defined functions first
functionType(Name, Args):-
    gvar(Name, Args),
    is_list(Args). % make sure we have a function not a simple variable

% Check first built in functions
functionType(Name, Args) :-
    fType(Name, Args), !. % make deterministic

% This gets wiped out but we have it here to make the linter happy
% gvar(_, _) :- false().
% a rule with no head, run it right now
:- dynamic(gvar/2).