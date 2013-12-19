% This is a prolog source code.


run(Program) :-
    parse(ParseTree,Program,[]).

% PARSE
parse(root(X)) --> begin, statements(X), end.

statements(groupNode(X,Y)) --> statement(X),statements(Y).
statements(X) --> statement(X).
statement(X) --> read(X)|write(X)|assign(X)|block(X)|while(X).

read(readNode(X)) --> readToken, var(X).
write(writeNode(X)) --> writeToken, expression(X).
assign(assignNode(X,Y)) --> var(X), assignToken, expression(Y).

block(blockNode(X)) --> begin, statements(X), end.
while(whileNode(W,X,Y,Z)) --> whileToken, expression(W), operator(X), expression(Y), block(Z).

operator(operatorNode(X)) --> operatorToken(o).

expression(Z) --> num(Z)|var(Z).
expression(plusNode(X,Y)) --> [X], {atomic(X)}, plusToken, expression(Y).
expression(minusNode(X,Y)) --> [X], {atomic(X)}, minusToken, expression(Y).

num(numNode(X)) --> [X],{number(X)}.
var(varNode(X)) --> [X],{atom(X)}.


% EXECUTE
% execute(root(X),V,_V).




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

operatorToken(o) --> [<].
operatorToken(o) --> [>].
operatorToken(o) --> [<=].
operatorToken(o) --> [>=].
operatorToken(o) --> [=].





% expr_value("100", V).
% run([begin,write,b,end]).
% run([begin,a,:=,1,+,2,b,:=,a,-,3,end],X).
% run([begin,while,1,<,2,a,end]).
% run([begin,write,abc,end]).
% run([begin,1,begin,a,:=,1,end,end]).
% run([begin,while,a,<,10,begin,a,:=,1,+,2,end,write,a,end]).
% run([begin,a,:=,1,+,2,+,3,end]).
% run([begin,a,:=,1,+,b,-,3,end]).
% run([begin,end]).



