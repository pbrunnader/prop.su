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
expression(plus(Z)) --> num(X), [+], expression(Y), {Z is X+Y}.
expression(minus(Z)) --> num(X), [-], expression(Y), {Z is X-Y}.
num(D) --> [D], {number(D)}.

expression_value(L, V) :- expression(V, L, []).

get_input(X) :-
repeat,
write(`Enter term: `),
read(STRING),
expression_value(STRING, V),
write(V).

/***
To run this:

consult('/Applications/bin/Assignment02.pl).

...

yes
| ?- get_input(X).
Enter term: [3,+,2].
5
true ? yes
***/