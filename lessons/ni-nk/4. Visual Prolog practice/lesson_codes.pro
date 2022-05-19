% Copyright

implement main
    open core, stdio

class predicates
    func : (integer X, integer Y [out]).
clauses
    func(X, Y) :-
        X > 0,
        !,
        Y = 2 * X - 10.
    func(X, Y) :-
        X = 0,
        !,
        Y = 0.
    func(X, Y) :-
        X < 0,
        !,
        Y = 2 * X * -1 - 1.
    func(_, 0).

class predicates
    show : (integer Min, integer Max, integer Step).
clauses
    show(Min, Max, Step) :-
        Min < Max,
        write(Min),
        nl,
        show(Min + Step, Max, Step),
        fail.
    show(_, _, _).

class facts
    max_val : (integer Max_val) single.
    flag : (boolean Flag) single.

clauses
    max_val(-65536).
    flag(false()).

class predicates
    max_on_interval : (integer Min, integer Max).
    max : (integer X, integer Y, integer Z [out]).

clauses
    max(X, Y, X) :-
        X >= Y,
        !.
    max(X, Y, Y).

    max_on_interval(Min, Max) :-
        Min < Max,
        func(Min, Y),
        max_val(Max_val),
        max(Y, Max_val, Z),
        assert(max_val(Z)),
        max_on_interval(Min + 1, Max),
        fail.

    max_on_interval(Min, Max) :-
        max_val(Max_val),
        Max_val > -65536,
        write(Max_val),
        nl,
        assert(max_val(-65536)),
        fail.

    max_on_interval(Min, Max) :-
        !.

class facts
    temp_max : (integer Temp) single.

clauses
    temp_max(0).

class predicates
    max_digit : (integer Number, integer Max [out]) determ.
clauses
    max_digit(Number, Max) :-
        Number > 0,
        temp_max(Temp),
        max(Temp, Number mod 10, Max2),
        assert(temp_max(Max2)),
        max_digit(Number div 10, Max),
        fail.

    max_digit(_, Max) :-
        temp_max(Max),
        Max > -1,
        write("Max digit = ", Max),
        assert(temp_max(-1)).

class facts
    seed : (integer S) single.
    iteration : (integer N) single.

clauses
    seed(19).
    iteration(0).

class predicates
    repeat : () multi.
    rand : (integer R, integer Random [out]).
    print_row : () nondeterm.
    print_n_rows : (integer N) nondeterm.

clauses
    repeat().
    repeat() :-
        repeat().

    rand(R, Random) :-
        seed(Seed),
        NewSeed = (187 * Seed + 1) mod 4096,
        assert(seed(NewSeed)),
        Random = NewSeed mod R.

    print_row() :-
        repeat(),
        rand(10, N),
        write(N, " "),
        N = 5,
        nl.

    print_n_rows(N) :-
        assert(iteration(1)),
        repeat(),
        print_row(),
        iteration(Iter),
        assert(iteration(Iter + 1)),
        Iter = N.

class predicates
    characteristic : (integer Height, string S [out]).
clauses
    characteristic(H, "очень высокий") :-
        H >= 200,
        !.
    characteristic(H, "высокий") :-
        H >= 180,
        !.
    characteristic(H, "средний") :-
        H >= 160,
        !.
    characteristic(_, "низкий").

class predicates
    factorial : (integer N, integer64 F [out]) determ.
clauses
    factorial(0, 1) :-
        !.
    factorial(N, F * N) :-
        N > 0,
        factorial(N - 1, F).

class predicates
    between : (integer X, integer Min, integer Max) nondeterm (i,i,i) (o,i,i).
clauses
    between(X, X, Max) :-
        !,
        X <= Max.
    between(X, Min, Max) :-
        Min <= Max,
        between(X, Min + 1, Max).

clauses
    /*run() :-
        X = 10,
        func(X, Y),
        write("y(", X, ") = ", Y),
        nl,
        fail.*/
    % run() :-
    %show(10, 20, 1),
    %max_on_interval(5, 10).
    % max_digit(123454321, Max),
    % print_n_rows(10),
    % !.
    run() :-
        % characteristic(195, S),
        factorial(6, S),
        write(S),
        nl,
        fail.
    run() :-
        between(X, 3, 7),
        write(X),
        nl,
        fail.
    run() :-
        between(6, 2, 8),
        write("Yes!"),
        !.
    run().

end implement main

goal
    console::runUtf8(main::run).
