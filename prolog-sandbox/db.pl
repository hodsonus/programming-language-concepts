%% following Derek Banas' GNU prolog tutorial
%% https://www.youtube.com/watch?v=SykxWpFwMGs

loves(romeo, juliet).

loves(juliet, romeo) :- loves(romeo,juliet).

male(albert).
male(bob).
male(bill).
male(carl).
male(charlie).
male(dan).
male(edward).

female(alice).
female(betsy).
female(diana).

happy(albert).
happy(alice).
happy(bob).
happy(bill).

with_albert(alice).

runs(albert) :- happy(albert).

dances(alice) :-
	happy(alice),
	with_albert(alice).

does_alice_dance :- dances(alice),
	write('When Alice is happy and with Albert, she dances').

parent(albert,bob).
parent(albert,betsy).
parent(albert,bill).

parent(alice,bob).
parent(alice,betsy).
parent(alice,bill).

parent(bob,carl).
parent(bob,charlie).

get_grandchild :-
	parent(albert,X),
	parent(X,Y),
	write('Albert\'s grandchild is '),
	write(Y), nl.

get_grandparent :-
	parent(X,carl),
	parent(X,charlie),
	format('~w ~s grandparent~n', [X, "is the"]).

brother(bob,bill).

grandparent(X,Y) :- 
	parent(Z,X),
	parent(Y,Z).

blushes(X) :- human(X).
human(derek).

stabs(tybalt,mercutio,sword).
hates(romeo,X) :- stabs(X,mercutio,sword).

what_grade(5) :-
	write('Go to kindergarten').

what_grade(6) :-
	write('Go to 1st Grade').

what_grade(Other) :-
	Grade is Other-5,
	format('Go to grade ~w', [Grade]).

%% has(albert,olive).

%% functor below
%% arity refers to the paramaters of a functor
%% female(alice).

%% complex terms and structures

owns(albert, pet(cat,olive)).

customer(tom, smith, 20.55).
customer(sally, smith, 120.55).

get_cust_bal(FName, LName) :-
	customer(FName,LName,Bal),
	write(FName),tab(1),
	format('~w owes us $~2f ~n', [LName, Bal]).

vertical(line(point(X,Y),point(X,Y2))).
horizontal(line(point(X,Y),point(X2,Y))).

%% comparing values

%% trace
warm_blooded(penguin).
warm_blooded(human).

produce_milk(penguin).
produce_milk(human).

have_feathers(penguin).
have_hair(human).

mammal(X) :- 
	warm_blooded(X),
	produce_milk(X),
	have_hair(X).

related(X, Y) :-
	parent(X,Y).

related(X, Y) :-
	parent(X,Z),
	related(Z,Y).

%% math fxns
%% use the is keyword to assign
%% 		x is 2+2.
%% do comparisons using <,=<,>,>=, =:=, =\=
%% 		symbols nontraditional to avoid looking like arrows
%% 'not' is done with '\+'
%% or operator is the semicolon, ';'
%% X = mod(7,2)
%% 		X = 1

double_digit(X,Y) :-
	Y is X*2.

%% random(0,10,X).
%% between(0,10,X).
%% succ(2,X).
%% X is abs(-8).
%% X is max(10,5).
%% X is min(10,5).
%% X is round(10.56).
%% X is truncate(10.56).
%% X is floor(10.56).
%% X is ceiling(10.56).
%% X is 2**3.
is_even(X) :-
	Y is X//2, X =:= 2*Y.

say_hi :-
	write('What is yout name? '),
	read(X),
	write('Hi '),
	write(X).

%% get(X) gets one character's ascii value from the user input stream
%% put(X) prints a character to the output stream using the ascii value

%% the cut operator, '!.', tells prolog to stop backtrackign

%% looping in prolog
count_to_10(10) :-
	write(10), nl.

count_to_10(Others) :-
	write(Others),
	nl,
	Y is 1+Others,
	count_to_10(Y).

count_down(Low,High) :-
	between(Low,High,Y),
	Z is High - Y.
	write(X),nl.