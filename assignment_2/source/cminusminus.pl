% This is a prolog source code.


run(Program) :-
    parse(ParseTree,Program,[]).

parse(start(X)) --> begin, statements(X), end.

statements(group(X,Y)) --> statement(X),statements(Y).
statements(X) --> statement(X).
% TEST !!!
statement(X) --> [X], {atomic(X)}.

statement(X) --> read(X)|write(X)|assign(X)|block(X)|while(X).

read(read(X)) --> readToken, [X], var(X).
write(write(X)) --> writeToken, [X], expression(X).
assign(assign(X,Y)) --> var(X), assignToken, expression(Y).

block(block(X)) --> begin, statements(X), end.
while(while(X)) --> whileToken, expression(X), operator(X), expression(X), block(X).

operator(operator(X)) --> operatorTocken(o).



expression(Z) --> num(Z)|var(Z).
% ACHTUNG !!! atomic
expression(plus(X,Y)) --> [X], {atomic(X)}, plusToken, expression(Y).
expression(minus(X,Y)) --> [X], {atomic(X)}, minusToken, expression(Y).





num(num(X)) --> [X],{number(X)}.
var(var(X)) --> [X],{atom(X)}.



% TERMINALE
begin --> [begin].
end --> [end].

readToken --> ['read'].
writeToken --> ['write'].
assignToken --> [:=].

whileToken --> ['while'].
loopToken --> ['loop'].

minusToken --> ['-'].
plusToken --> ['+'].

operatorTocken(o) --> [<].
operatorTocken(o) --> [>].
operatorTocken(o) --> [<=].
operatorTocken(o) --> [>=].
operatorTocken(o) --> [=].





% expr_value("100", V).
% run([begin,while,a,<,10,begin,a,:=,a,+,1,write,a,end,end]).
% run([begin,while,1,<,2,a,end]).
% run([begin,write,abc,end]).
% run([begin,1,begin,a,:=,1,end,end]).
% run([begin,a,:=,1,+,2,end]).
% run([begin,a,:=,1,+,2,+,3,end]).
% run([begin,a,:=,1,+,b,-,3,end]).
% run([begin,end]).



