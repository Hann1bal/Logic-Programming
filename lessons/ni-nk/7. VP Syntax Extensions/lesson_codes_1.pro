% Copyright

implement main
    open core, stdio

domains
    tuple3 = tuple3(integer, integer, integer).

class facts
    s : (integer Num).
    m : (string Num).

clauses
    s(0).
    s(1).
    s(2).
    s(3).
    s(4).
    s(5).
    s(6).
    s(7).
    s(8).
    s(9).
    s(10).

    m("3").
    m("6").
    m("9").
    m("10").

class predicates
    length : (integer*) -> integer.
    sum : (integer*) -> integer.
    average : (integer*) -> real determ.
    factorial : (integer) -> integer64 determ.

clauses
    length([]) = 0.
    length([_ | T]) = length(T) + 1.

    sum([]) = 0.
    sum([H | T]) = sum(T) + H.

    average(L) = sum(L) / Len :-
        Len = length(L),
        Len > 0.

    factorial(0) = 1 :-
        !.
    factorial(N) = N * factorial(N - 1) :-
        N > 0.

clauses
    run() :-
        L =
            [ tuple3(X, Y, X + Y) ||
                s(X),
                m(Z),
                Y = toTerm(Z),
                X = Y,
                X mod 3 = 0
            ],
        write(L),
        nl,
        R =
            [ Element ||
                Item = list::getMember_nd(L),
                Item = tuple3(_, _, Element)
            ],
        write(R),
        writef("% % %", length(R), sum(R), average(R)),
        nl,
        write(factorial(13)),
        !.
    run().

end implement main

goal
    console::runUtf8(main::run).
