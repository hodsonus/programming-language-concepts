% there is a debug mode - this changes the way that prolog compiles and then interprets the code
% prolog USUALLY compiles the code after optimizing it
% some of the code that is given below is a little bit subtle - some is not subtle

% asserts
    % 'asserta' adds a new definition for whatever you give - almoset behaves as a macro
        % adds a new definition to gvars - becomes the most important one
        % runs on unification - this system takes the place of hash tables in OCaml
        % line 79 sets up the whole system, the call here prevents exceptions from being thrown when it sees no Gvars

% infer cleans
    % makes sure the code is a list
    % deletes the global variables
    % type code applys the type definitions
    % infer is usually the function that we want to test

% we have to write the code to define fucntions
% test the functons in a specific way - add a fact with a name (my_funct, for example) and the input type to the output type

% what he wants us to go and do
    % figure out how you can represent every type of statement - this is the equivalent of sum types in OCaml'
        % this is necessary for the bonus

% strong advice to us
%     **reload the code**

% be aware of the following
%     define some fxns that dont need to bind variables - let them work in a generic way
%     in Ocaml, the type infrerence mechanism can say a' -> a' (alpha type to alpha type)

% similarly to OCaml, loops are discouraged heavily

% the only way to get things done here is through unification

%  write negative tests so that it fails
%  line 38 on the testing paltfor - put fails insteaf of nondet

% add a gvar
% 	when you delete them it

% 	knock off the definition at the end
% 	declare as dynamic ??
% 	dynamic name_of_predicate

% use **trace**, with or without the tests

/* match functions by unifying with arguments 
    and infering the result
*/
typeExp(Fct, T):-
    \+ var(Fct), /* make sure Fct is not a variable */ 
    \+ atom(Fct), /* or an atom */
    functor(Fct, Fname, _Nargs), /* ensure we have a functor */
    !, /* if we make it here we do not try anything else */
    Fct =.. [Fname|Args], /* get list of arguments */
    append(Args, [T], FType), /* make it loook like a function signature */
    functionType(Fname, TArgs), /* get type of arguments from definition */
    typeExpList(FType, TArgs). /* recurisvely match types */

/* propagate types */
typeExp(T, T).

/* list version to allow function mathine */
typeExpList([], []).
typeExpList([Hin|Tin], [Hout|Tout]):-
    typeExp(Hin, Hout), /* type infer the head */
    typeExpList(Tin, Tout). /* recurse */

/* TODO: add statements types and their type checking */


/* global variable definition
    Example:
        gvLet(v, T, int) ~ let v = 3;
 */
typeStatement(gvLet(Name, T, Code), unit):-
    atom(Name), /* make sure we have a bound name */
    typeExp(Code, T), /* infer the type of Code and ensure it is T */
    bType(T), /* make sure we have an infered type */
    asserta(gvar(Name, T)). /* add definition to database */

% TODO, extra credit
% all you need to do to define the if statement\

% this is a super generic data structure
% similar to tuples in other proogramming langeages

% because we have thsi suepr general structure, so long
% as we have stuff that recognizes things that can fit
% into this general data structure then we are good

% the only reason the f types and the b types are
% designed are to organize the structure of the program better 
typeStatement(if(Cond, TCode, FCode),T) :-
    typeExp(Cond, bool),
    typeCode(TCode, T),
    typeCode(FCode, T),
    bType(T).

/* Expressions are statements */
typeStatement(Expr, T) :-
    typeExp(Expr,T).

typeCode([],T) :- bType(T). % enforces no type for empty lists, a generic alpha type

/* Code is simply a list of statements. The type is 
    the type of the last statement 
*/
typeCode([S], T):-typeStatement(S, T).
typeCode([S, S2|Code], T):-
    typeStatement(S,_T),
    typeCode([S2|Code], T).

/* top level function */
infer(Code, T) :-
    is_list(Code), /* make sure Code is a list */
    deleteGVars(), /* delete all global definitions */
    typeCode(Code, T).

/* Basic types
    TODO: add more types if needed
 */
bType(bool).
bType(int).
bType(float).
bType(string).
bType(unit). /* unit type for things that are not expressions */
/*  functions type.
    The type is a list, the last element is the return type
    E.g. add: int->int->int is represented as [int, int, int]
    and can be called as add(1,2)->3
 */
bType([H]):- bType(H).
bType([H|T]):- bType(H), bType(T).

% allow alpha types
% with this, go into the if statements and ensure that we do not have free vars
bType(T) :-
    var(T).

/*
    TODO: as you encounter global variable definitions
    or global functions add their definitions to 
    the database using:
        asserta( gvar(Name, Type) )
    To check the types as you encounter them in the code
    use:
        gvar(Name, Type) with the Name bound to the name.
    Type will be bound to the global type
    Examples:
        g

    Call the predicate deleveGVars() to delete all global 
    variables. Best wy to do this is in your top predicate
*/

deleteGVars():-
    retractall(gvar),
    asserta(gvar(_X,_Y) :- false()).

/*  builtin functions
    Each definition specifies the name and the 
    type as a function type

    TODO: add more functions
*/
fType('<', [float, float, bool]).
fType(iplus, [int,int,int]).
fType(fplus, [float, float, float]).
fType(fToInt, [float,int]).
fType(iToFloat, [int,float]).
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