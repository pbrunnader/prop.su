%
% This is the "assignment 2" for the course "Programming languages and Paradigms" 
% at the Stockholm University 
% 
% assigment 2
% 
%  @author Peter Brunnader 
%  @author Katrin Freihofner
%  @version 1.0
% 


run(Program,_Variable) :-
    write('Parsing program.'), nl,
    parse(ParseTree,Program,[]),
    write('Program correct and parsed.'), nl,
    write(ParseTree), nl,
    write('Execution start.'), nl,
    executeRoot(ParseTree,[],_Variable), nl,
    write('Execution finished.').

% PARSING THE INPUT LIST
parse(root(X)) --> beginToken, statements(X), endToken.

statements(groupNode(X,Y)) --> statement(Y),statements(X).
statements(X) --> statement(X).
statement(X) --> read(X)|write(X)|assign(X)|block(X)|while(X)|if(X).

read(readNode(X)) --> readToken, var(X).
write(writeNode(X)) --> writeToken, expression(X).
assign(assignNode(X,Y)) --> var(X), assignToken, expression(Y).

block(blockNode(X)) --> beginToken, statements(X), endToken.
while(whileNode(W,X,Y,Z)) --> whileToken, expression(W), operator(X), expression(Y), statement(Z).
if(ifNode(W,X,Y,Z)) --> ifToken, expression(W), operator(X), expression(Y), statement(Z).

operator(operatorNode(X)) --> [>],{X = g}|[<],{X = l}|[<=],{X = le}|[>=],{X = ge}|[=],{X = e}. %|[!=],{X = n}.

expression(X) --> term(X1), expr(X1,X).
expr(X1,X) --> plusToken, term(X2), expr(plusNode(X1,X2),X). 
expr(X1,X) --> minusToken, term(X2), expr(minusNode(X1,X2),X). 
expr(X,X) --> [].

term(X) --> [X1], {number(X1)}, t(numNode(X1),X).
term(X) --> [X1], {atom(X1)}, t(varNode(X1),X).
t(X1,X) --> multiToken, [X2], {number(X2)}, t(multiNode(X1,numNode(X2)),X); multiToken, [X2], {atom(X2)}, t(multiNode(X1,varNode(X2)),X). 
t(X1,X) --> divToken, [X2], {number(X2)}, t(divNode(X1,numNode(X2)),X); divToken, [X2], {atom(X2)}, t(divNode(X1,varNode(X2)),X).
t(X,X) --> [].

factor(X) --> expression(X).



% EXECUTE THE BUILD PARSETREE

% root
executeRoot(root(X),V,_V) :- execute(X,V,_V).

% control structures
execute(blockNode(X),V,_V) :- execute(X,V,_V).
execute(whileNode(W,operatorNode(X),Y,Z),V,_V) :- while(W,X,Y,Z,V,_V).
execute(ifNode(W,operatorNode(X),Y,Z),V,_V) :- if(W,X,Y,Z,V,_V).

% grouping
execute(groupNode(X,Y),V,_V) :- execute(Y,V,T), execute(X,T,_V).

% get user input 
execute(readNode(varNode(X)),V,_V) :- write(X), write(': '), read(TMP), assign(X,TMP,V,_V).

% write a number, variable or an expression 
execute(writeNode(numNode(X)),V,_V) :- write(X), append(V,[],_V), nl.
execute(writeNode(varNode(X)),V,_V) :- assigned(X,Result,V,T), write(Result), append(T,[],_V), nl.
execute(writeNode(X),V,_V) :- execute(X,Result,V,T), write(Result), append(T,[],_V), nl.

% assigning
execute(assignNode(varNode(X),numNode(Y)),V,_V) :- assign(X,Y,V,_V), !.
execute(assignNode(varNode(X),Y),V,_V) :- execute(Y,Result,V,T), assign(X,Result,T,_V).

% execute the expression
execute(plusNode(X,numNode(Y)),Result,V,_V) :- execute(X,Z,V,_V), Result is Z + Y, append(V,[],_V).
execute(plusNode(X,varNode(Y)),Result,V,_V) :- assigned(Y,_Y,V,_V), execute(X,Z,V,_V), Result is Z + _Y, append(V,[],_V).
execute(plusNode(X,Y),Result,V,_V) :- execute(X,_X,V,T), execute(Y,_Y,T,S), Result is _X + _Y, append(S,[],_V).

execute(minusNode(X,numNode(Y)),Result,V,_V) :- execute(X,Z,V,_V), Result is Z - Y, append(V,[],_V).
execute(minusNode(X,varNode(Y)),Result,V,_V) :- assigned(Y,_Y,V,_V), execute(X,Z,V,_V), Result is Z - _Y, append(V,[],_V).
execute(minusNode(X,Y),Result,V,_V) :- execute(X,_X,V,T), execute(Y,_Y,T,S), Result is _X - _Y, append(S,[],_V).

execute(multiNode(X,numNode(Y)),Result,V,_V) :- execute(X,Z,V,_V), Result is Z * Y, append(V,[],_V).
execute(multiNode(X,varNode(Y)),Result,V,_V) :- assigned(Y,_Y,V,_V), execute(X,Z,V,_V), Result is Z * _Y, append(V,[],_V).
execute(multiNode(X,Y),Result,V,_V) :- execute(X,_X,V,T), execute(Y,_Y,T,S), Result is _X * _Y, append(S,[],_V).

execute(divNode(X,numNode(Y)),Result,V,_V) :- \+ (isZero(Y)), execute(X,Z,V,_V), Result is Z / Y, append(V,[],_V).
execute(divNode(_,numNode(Y)),_,_,_V) :- isZero(Y), throw('error: divisor with value zero not allowed.').
execute(divNode(X,varNode(Y)),Result,V,_V) :- assigned(Y,_Y,V,_V), \+ (isZero(_Y)), execute(X,Z,V,_V), Result is Z / _Y, append(V,[],_V).
execute(divNode(_,varNode(Y)),_,V,_V) :- assigned(Y,_Y,V,_V), isZero(_Y), throw('error: divisor with value zero not allowed.').
execute(divNode(X,Y),Result,V,_V) :- execute(X,_X,V,T), execute(Y,_Y,T,S), \+ (isZero(_Y)), Result is _X / _Y, append(S,[],_V).
execute(divNode(X,Y),_,V,_V) :- execute(X,_X,V,T), execute(Y,_Y,T,_), isZero(_Y), throw('error: divisor with value zero not allowed.').

% data 'type'
execute(numNode(X),Result,V,_V) :- Result is X, append(V,[],_V).
execute(varNode(X),Result,V,_V) :- assigned(X,Result,V,T), append(T,[],_V).

% variable handling
assign(Name,Value,V,_V) :- removeVar(Name,V,T), appendVar(Name,Value,T,_V).

assigned(_,Value,[],[]) :- number(Value).
assigned(Name,Value,[[Name|E]|V],_V) :- assigned(E,Value), assigned(Name,Value,V,T), appendVar(Name,Value,T,_V).
assigned(Name,Value,[E|V],[E|_V]) :- assigned(Name,Value,V,_V).
assigned(Name,Value,V,_V) :- Value is 0, appendVar(Name,0,V,_V).
assigned([Value|_],Value).

isAssigned(Name,[[Name|_]|_],_V).
isZero(Value) :- Value =:= 0.

appendVar(Name,Value,V,_V) :- append(V,[[Name,Value]],_V).

removeVar(_,[],[]). 
removeVar(Name,[[Name|_]|V],_V) :- removeVar(Name,V,_V).
removeVar(Name,[E|V],[E|_V]) :- Name \== [_|E], removeVar(Name,V,_V). 

while(numNode(W),X,numNode(Y),_,V,_V) :- (condition(W,X,Y), throw('error: while-loop is infinite.'));(\+ (condition(W,X,Y)), write('warning: while-loop is never entered.'), nl), append(V,[],_V).

while(W,X,Y,_,V,_V) :- execute(W,Value1,V,_), execute(Y,Value2,V,T), append(T,[],_V), \+ (condition(Value1,X,Value2)).
while(W,X,Y,Z,V,_V) :- execute(W,Value1,V,_), execute(Y,Value2,V,_), condition(Value1,X,Value2), execute(Z,V,U), while(W,X,Y,Z,U,_V).

if(W,X,Y,_,V,_V) :- execute(W,Value1,V,_), execute(Y,Value2,V,T), append(T,[],_V), \+ (condition(Value1,X,Value2)). 
if(W,X,Y,Z,V,_V) :- execute(W,Value1,V,_), execute(Y,Value2,V,T), condition(Value1,X,Value2), execute(Z,T,_V).

num(numNode(X)) --> [X],{number(X)}.
var(varNode(X)) --> [X],{atom(X)}.

% check if conditions are valid 
condition(X,'l',Z) :- X < Z.
condition(X,'g',Z) :- X > Z.
condition(X,'le',Z) :- X =< Z.
condition(X,'ge',Z) :- X >= Z.
condition(X,'e',Z) :- X =:= Z.
% condition(X,'n',Z) :- \+ (X=:=Z). 


% TERMINALE
beginToken --> ['begin'].
endToken --> ['end'].

readToken --> ['read'].
writeToken --> ['write'].
assignToken --> [':='].

whileToken --> ['while'].
loopToken --> ['loop'].
ifToken --> ['if'].

minusToken --> ['-'].
plusToken --> ['+'].
multiToken --> ['*'].
divToken --> ['/'].
openToken --> ['('].
closeToken --> [')'].


