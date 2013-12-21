% This is a prolog source code.


run(Program,_Variable) :-
    write('Parsing program.'), nl,
    parse(ParseTree,Program,[]),
    write('Program correct and parsed.'), nl,
    write(ParseTree), nl,
    write('Execution start.'), nl,
    executeRoot(ParseTree,[],_Variable),
    nl, write('Execution finished.').

% PARSE
parse(root(X)) --> begin, statements(X), end.

statements(groupNode(X,Y)) --> statement(Y),statements(X).
statements(X) --> statement(X).
statement(X) --> read(X)|write(X)|assign(X)|block(X)|while(X)|if(X).

read(readNode(X)) --> readToken, var(X).
write(writeNode(X)) --> writeToken, expression(X).
assign(assignNode(X,Y)) --> var(X), assignToken, expression(Y).

block(blockNode(X)) --> begin, statements(X), end.
while(whileNode(W,X,Y,Z)) --> whileToken, expression(W), operator(X), expression(Y), statement(Z).
if(ifNode(W,X,Y,Z)) --> ifToken, expression(W), operator(X), expression(Y), statement(Z).

operator(operatorNode(X)) --> [<],{X = l}|[>],{X = g}|[<=],{X = le}|[>=],{X = ge}|[=],{X = e}. %|[!=],{X = n}.

expression(X) --> num(X)|var(X).
expression(plusNode(X,Y)) --> num(X), plusToken, expression(Y).
expression(plusNode(X,Y)) --> var(X), plusToken, expression(Y).
expression(minusNode(X,Y)) --> num(X), minusToken, expression(Y).
expression(minusNode(X,Y)) --> var(X), minusToken, expression(Y).


num(numNode(X)) --> [X],{number(X)}.
var(varNode(X)) --> [X],{atom(X)}.


% EXECUTION PART

% root
executeRoot(root(X),V,_V) :- execute(X,V,_V).

% control structures
execute(blockNode(X),V,_V) :- execute(X,V,_V).
execute(whileNode(W,operatorNode(X),Y,Z),V,_V) :- while(W,X,Y,Z,V,_V).
execute(ifNode(W,operatorNode(X),Y,Z),V,_V) :- if(W,X,Y,Z,V,_V).

% grouping
execute(groupNode(X,Y),V,_V) :- execute(Y,V,T), execute(X,T,_V).

% get user input 
execute(readNode(varNode(X)),V,_V) :- write(X), write(':'), read(TMP), assign(X,TMP,V,_V).

% write a number, variable or an expression 
execute(writeNode(numNode(X)),V,_V) :- write(X), append(V,[],_V), nl.
execute(writeNode(varNode(X)),V,_V) :- assigned(X,Result,V,T), write(Result), append(T,[],_V), nl.
execute(writeNode(X),V,_V) :- execute(X,Result,V,T), write(Result), append(T,[],_V), nl.

% assigning
execute(assignNode(varNode(X),numNode(Y)),V,_V) :- assign(X,Y,V,_V).
execute(assignNode(varNode(X),Y),V,_V) :- execute(Y,Result,V,T), assign(X,Result,T,_V).

% execute the expression
execute(plusNode(numNode(X),Y),Result,V,_V) :- execute(Y,Z,V,_V), Result is X + Z, append(V,[],_V).
execute(plusNode(varNode(X),Y),Result,V,_V) :- assigned(X,_X,V,_V), execute(Y,Z,V,_V), Result is _X + Z, append(V,[],_V).
execute(minusNode(numNode(X),Y),Result,V,_V) :- execute(Y,Z,V,_V), Result is X - Z, append(V,[],_V).
execute(minusNode(varNode(X),Y),Result,V,_V) :- assigned(X,_X,V,_V), execute(Y,Z,V,_V), Result is _X - Z, append(V,[],_V).

% data 'type'
execute(numNode(X),Result,V,_V) :- Result is X, append(V,[],_V).
execute(varNode(X),Result,V,_V) :- assigned(X,Result,V,_V), append(V,[],_V).


% Managing the variables, save, read and remove
assign(Name,Value,V,_V) :- removeVar(Name,V,T), appendVar(Name,Value,T,_V).

assigned(_,Value,[],[]) :- number(Value).
assigned(Name,Value,[[Name|E]|V],_V) :- assigned(E,Value), assigned(Name,Value,V,T), appendVar(Name,Value,T,_V).
assigned(Name,Value,[E|V],[E|_V]) :- assigned(Name,Value,V,_V).
assigned(Name,Value,V,_V) :- Value is 0.
assigned([Value|_],Value).

removeVar(_,[],[]). 
removeVar(Name,[[Name|_]|V],_V) :- removeVar(Name,V,_V).
removeVar(Name,[E|V],[E|_V]) :- Name \== [_|E], removeVar(Name,V,_V). 

appendVar(Name,Value,V,_V) :- append(V,[[Name,Value]],_V).

while(numNode(W),X,numNode(Y),_,V,_V) :- (condition(W,X,Y), throw('error: while-loop is infinite.'));(\+ (condition(W,X,Y)), write('warning: while-loop is never entered.'), nl), append(V,[],_V).
while(varNode(W),X,numNode(Y),Z,V,_V) :- (assigned(W,Value,V,T), condition(Value,X,Y), execute(Z,T,U), while(varNode(W),X,numNode(Y),Z,U,_V));append(V,[],_V).
while(numNode(W),X,varNode(Y),Z,V,_V) :- (assigned(Y,Value,V,T), condition(W,X,Value), execute(Z,T,U), while(numNode(W),X,varNode(Y),Z,U,_V));append(V,[],_V).

if(varNode(W),X,numNode(Y),Z,V,_V) :- (assigned(W,Value,V,T), condition(Value,X,Y), execute(Z,T,_V));append(V,[],_V).
if(numNode(W),X,varNode(Y),Z,V,_V) :- (assigned(Y,Value,V,T), condition(W,X,Value), execute(Z,T,_V));append(V,[],_V).



% check if conditions are valid 
condition(X,'l',Z) :- X < Z.
condition(X,'g',Z) :- X > Z.
condition(X,'le',Z) :- X =< Z.
condition(X,'ge',Z) :- X >= Z.
% condition(X,'e',Z) :- X =:= Z.
% condition(X,'n',Z) :- Y = n, X=:=Z. UNGLEICH!





% TERMINALE
begin --> ['begin'].
end --> ['end'].

readToken --> ['read'].
writeToken --> ['write'].
assignToken --> [':='].

whileToken --> ['while'].
loopToken --> ['loop'].
ifToken --> ['if'].

minusToken --> ['-'].
plusToken --> ['+'].


% run([begin,write,b,write,a,b,:=,10,write,b,write,a,end],V).
% run([begin,while,a,<,5,begin,write,a,a,:=,a,+,1,end,end],V).
% run([begin,a,:=,0,while,5,>,10,a,:=,a,+,1,write,a,end], V).
% run([begin,a,:=,2,b,:=,100,write,10,-,a,-,a,end], V).
% run([begin,a,:=,8,b,:=,2,c,:=,1,a,:=,7,end], V).
% run([begin,while,a,<,10,begin,a,:=,a,+,1,write,a,end,end],V).
% run([begin,b,:=,10,write,a,write,b,end], V).
% run([begin,1,begin,a,:=,1,end,end]).
% run([begin,while,a,<,10,begin,a,:=,1,+,2,end,write,a,end]).
% run([begin,a,:=,1,+,2,+,3,end]).
% run([begin,a,:=,1,+,b,-,3,end]).
% run([begin,end]).


% execute(whileNode(varNode(a),operatorNode(<),numNode(10),assignNode(varNode(b),numNode(123))),[[a,6]],Y).

