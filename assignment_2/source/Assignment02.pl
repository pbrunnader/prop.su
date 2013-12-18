/***

Peter Brunnader
Katrin Freihofner

Assignment02

***/

assign(Variable,Expression):-
variable(Letter, Variable),
expression(Num, Expression).

variable(X):-atom(X).


expression(Z) --> num(Z).
expression(Z) --> num(X), [+], expression(Y), {Z is X+Y}.
expression(Z) --> num(X), [-], expression(Y), {Z is X-Y}.
num(D) --> [D], {number(D)}.

expression_value(L, V) :- expression(V, L, []).


/***
expression(X):-number(X).
expression(X|Expression):-number(X),rest_expression(Expression).
rest_expression(operator(Operator,X)|Expression):-operator(Operator),number(X),rest_expression(Expression).
rest_expression(operator(Operator|X)):-operator(Operator), number(X).

operator(plus):- +.
operator(minus):- -.
***/

/***
expression([Value]) --> value(Value).
expression([Value|Expression]) --> value(Value), rest_expression(Expression).
value(number(Number)) --> [Number], {number(Number)}.
value(variable(Variable)) --> [Variable], {atom(Variable)}.
rest_expression([operator(Operator,Value)|Expression]) --> operator(Operator), value(Value), rest_expression(Expression).
rest_expression([operator(Operator,Value)]) --> operator(Operator), value(Value).
operator(plus) --> [+].
operator(minus) --> [-].
***/

/***
evaluate(A+B,CV,Vars):-eval_v(A,AV,Vars),eval_v(B,BV,Vars),CV is AV+BV.
evaluate(A-B,CV,Vars):-eval_v(A,AV,Vars),eval_v(B,BV,Vars),CV is AV-BV.
evaluate(A*B,CV,Vars):-eval_v(A,AV,Vars),eval_v(B,BV,Vars),CV is AV*BV.
evaluate(Num,Num,Vars):-number(Num).
evaluate(Var,Value,Vars):-atom(Var),member(Var/Value,Vars).

***/
