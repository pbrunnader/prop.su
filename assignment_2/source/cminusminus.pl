% This is a prolog source code.


run(Program,_Variable) :-
    write('Parsing program ...'),
    parse(ParseTree,Program,[]),
    write(' parsetree done. \n'),
    write(ParseTree),
    write('\nExecute ...'),
    executeRoot(ParseTree,[],_Variable),
    write(' done. \n').

% PARSE
parse(root(X)) --> begin, statements(X), end.

statements(groupNode(X,Y)) --> statement(Y),statements(X).
statements(X) --> statement(X).
statement(X) --> read(X)|write(X)|assign(X)|block(X)|while(X).

read(readNode(X)) --> readToken, var(X).
write(writeNode(X)) --> writeToken, expression(X).
assign(assignNode(X,Y)) --> var(X), assignToken, expression(Y).

block(blockNode(X)) --> begin, statements(X), end.
while(whileNode(W,X,Y,Z)) --> whileToken, expression(W), operator(X), expression(Y), block(Z).

operator(operatorNode(_)) --> operatorToken(o).

expression(X) --> num(X)|var(X).
expression(plusNode(X,Y)) --> num(X), plusToken, expression(Y).
expression(plusNode(X,Y)) --> var(X), plusToken, expression(Y).
expression(minusNode(X,Y)) --> num(X), minusToken, expression(Y).
expression(minusNode(X,Y)) --> var(X), minusToken, expression(Y).

num(numNode(X)) --> [X],{number(X)}.
var(varNode(X)) --> [X],{atom(X)}.





% EXECUTE
executeRoot(root(X),V,_V) :- execute(X,V,_V).

execute(groupNode(X,Y),V,_V) :- execute(Y,V,T), execute(X,T,_V).

execute(readNode(varNode(X)),V,_V) :- write(X), write(':'), read(TMP), assign(X,TMP,V,_V).
execute(writeNode(numNode(X)),V,_V) :- write(X), append(V,[],_V), nl.
execute(writeNode(varNode(X)),V,_V) :- write(X), append(V,[],_V), nl.
execute(assignNode(varNode(X),numNode(Y)),V,_V) :- assign(X,Y,V,_V).
execute(assignNode(varNode(X),Y),V,_V) :- execute(Y,Result,V,T), assign(X,Result,T,_V).

execute(plusNode(numNode(X),Y),Result,V,_V) :- execute(Y,Z,V,_V), Result is X + Z, append(V,[],_V).
execute(minusNode(numNode(X),Y),Result,V,_V) :- execute(Y,Z,V,_V), Result is X - Z, append(V,[],_V).

execute(numNode(X),Result,V,_V) :- Result is X, append(V,[],_V).



assign(Name,Value,V,_V) :- removeVar(Name,V,T), appendVar(Name,Value,T,_V).

% assigned(a,Value,[[a,11],[b,9],[c,3]],Liste).
assigned(Name,Value,[],[]) :- number(Value).
assigned(Name,Value,[],[]) :- \+ (number(Value)), Value is 0.
assigned(Name,Value,[[Name|E]|V],_V) :- assigned(E,Value), assigned(Name,Value,V,T), appendVar(Name,Value,T,_V).
assigned(Name,Value,[E|V],[E|_V]) :- assigned(Name,Value,V,_V).
assigned([Value|E],Value).



removeVar(_,[],[]). 
removeVar(Name,[[Name|_]|V],_V) :- removeVar(Name,V,_V).
removeVar(Name,[E|V],[E|_V]) :- Name \== [_|E], removeVar(Name,V,_V). 

appendVar(Name,Value,V,_V) :- append(V,[[Name,Value]],_V).





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
% run([begin,a,:=,8,b,:=,10,+,2,+,2,c,:=,3,a,:=,111,end], V).
% run([begin,a,:=,8,b,:=,2,c,:=,1,a,:=,7,end], V).
% run([begin,a,:=,1,+,2,b,:=,a,-,3,end],X).
% run([begin,while,1,<,2,a,end]).
% run([begin,write,abc,end]).
% run([begin,1,begin,a,:=,1,end,end]).
% run([begin,while,a,<,10,begin,a,:=,1,+,2,end,write,a,end]).
% run([begin,a,:=,1,+,2,+,3,end]).
% run([begin,a,:=,1,+,b,-,3,end]).
% run([begin,end]).



