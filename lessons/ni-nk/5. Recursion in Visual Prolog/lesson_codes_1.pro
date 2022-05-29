% Copyright

implement main
    open core, stdio

class predicates
    sum_n : (integer N, integer S [out]) determ.
clauses
    sum_n(1, 1) :-
        !.
        % sum_n(N, S) :- N > 0, sum_n(N - 1, S1), S = S1 + N.
    sum_n(N, S + N) :-
        N > 0,
        sum_n(N - 1, S).

class predicates
    fib : (integer N, integer F [out]) determ.
clauses
    fib(1, 1) :-
        !.
    fib(2, 1) :-
        !.
    fib(N, F1 + F2) :-
        N > 2,
        fib(N - 1, F1),
        fib(N - 2, F2).

class predicates
    factorial : (integer N, integer F [out]) determ.
    factorial_rec : (integer N_current, integer N, integer F, integer Result [out]) determ.

clauses
    factorial_rec(N, N, F, F) :-
        !.
    factorial_rec(N_current, N, F, Result) :-
        factorial_rec(N_current + 1, N, F * (N_current + 1), Result).

    factorial(N, F) :-
        N >= 0,
        factorial_rec(0, N, 1, F).

class predicates
    fib_int : (integer N, integer F [out]) determ.
    fib_rec : (integer CurrentStep, integer FPrev, integer FCurrent, integer N, integer F [out]) determ.

clauses
    fib_rec(N, _, F, N, F) :-
        !.

    fib_rec(CurStep, FPrev, FCur, N, F) :-
        fib_rec(CurStep + 1, FCur, FCur + FPrev, N, F).

    fib_int(N, F) :-
        N > 0,
        fib_rec(1, 0, 1, N, F).

class predicates
    pow : (integer A, integer Power, integer Res [out]) determ.
clauses
    pow(0, N, 0) :-
        N > 0,
        !.
    pow(0, _, _) :-
        write("Failure"),
        !,
        fail.
    pow(_, 0, 1) :-
        !.
    pow(A, N, Res * A) :-
        pow(A, N - 1, Res).

class predicates
    pow_int : (integer A, integer Power, integer Res [out]) determ.
    pow_rec : (integer A, integer Power, integer CurStep, integer CurRes, integer Res [out]) determ.

clauses
    pow_int(A, Power, Res) :-
        Power > 0,
        pow_rec(A, Power, 0, 1, Res).

    pow_rec(_, Power, Power, Res, Res) :-
        !.
    pow_rec(A, Power, CurStep, CurRes, Res) :-
        pow_rec(A, Power, CurStep + 1, CurRes * A, Res).

clauses
    run() :-
        pow_int(2, 5, X),
        write(X),
        nl,
        !.
    run().

end implement main

goal
    console::runUtf8(main::run).
