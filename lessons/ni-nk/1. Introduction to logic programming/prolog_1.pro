mother(sam, lucy).
mother(lucy, pamela).
father(lucy, erick).
father(sam, john).


/* parent(X, Y) :- mother(X, Y); father(X, Y). */
parent(X, Y) :- mother(X, Y).
parent(X, Y) :- father(X, Y).

grandfather(X, G) :- parent(X, P), father(P, G).