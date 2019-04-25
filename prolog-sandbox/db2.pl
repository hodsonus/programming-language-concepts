%% anything that you plan on changing (any predicates) must be marked as dyanmic

:- dynamic(father/2).
:- dynamic(likes/2).
:- dynamic(friend/2).
:- dynamic(stabs/3).

father(lord_montague, romeo).
father(lord_capulet, juliet).

likes(mercutio, dancing).
likes(benvolio, dancing).
likes(romeo, dancing).
likes(romeo, juliet).
likes(juliet, romeo).
likes(juliet, dancing).

friend(romeo, mercutio).
friend(romeo, benvolio).

stabs(tybalt, mercutio, sword).
stabs(romeo, tybalt, sword).

%% asserta puts at the beginning
	%% a is at the beginning of the alphabet
	%% asserta(friend(benvolio, mercutio)).

%% assertz puts at the end
	%% z is at the end of the alpha
	%% assertz(friend(benvolio, mercutio)).

%% retract removes a fact from the database
	%% retract(like(mercutio,dancing)).

%% retractall removes every single rule
	%% retractall(father(_,_)).

%% lists
%% write([albert|[alice,bob]]),nl.
%% length([1,2,3],Z).
%% [H|T] = [a,b,c].

%% use anonymous variables, i.e. '_', when 
%% you dont care about the value of a variable

%% use the member functor to cycle through a list
%% use append to append to a list

%% strings

%% use 'name' fxn to grab ascii values of each
%% character in the string into a list