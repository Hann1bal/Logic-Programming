% Copyright

implement main
    open core, stdio, file

class facts
    stip : (string Name, integer Ngr, integer Stip).

clauses
    stip("Alena", 1, 1000).
    stip("Max", 1, 1100).
    stip("Peter", 2, 800).
    stip("Bob", 2, 1500).
    stip("Helen", 1, 2000).

class predicates
    printStips : ().
    increaseStip : (integer H).

clauses
    printStips() :-
        stip(Name, _, Stip),
        write(Name, ":\t", Stip),
        nl,
        fail.
    printStips() :-
        write("All students are shown above\n").

class facts
    stats : (integer Min, integer Max, integer Count, integer Sum) single.

clauses
    stats(0, 0, 0, 0).

class predicates
    writeStipStats : ().
    min : (integer X, integer Y, integer Z [out]).
    max : (integer X, integer Y, integer Z [out]).

clauses
    min(X, Y, X) :-
        X <= Y,
        !.
    min(_, Y, Y).

    max(X, Y, X) :-
        X >= Y,
        !.
    max(_, Y, Y).

clauses
    writeStipStats() :-
        assert(stats(65536, 0, 0, 0)),
        stip(_, _, Stip),
        stats(Min, Max, Count, Sum),
        min(Min, Stip, NewMin),
        max(Max, Stip, NewMax),
        assert(stats(NewMin, NewMax, Count + 1, Sum + Stip)),
        fail.

    writeStipStats() :-
        stats(Min, Max, Count, Sum),
        writef("Stip min: %\nStipMax: %\nCount: %\nSum: %\nAverage: %\n", Min, Max, Count, Sum, Sum / Count).

clauses
    increaseStip(H) :-
        retract(stip(Name, Ngr, Stip)),
        asserta(stip(Name, Ngr, Stip + H)),
        fail.
    increaseStip(_).

clauses
    run() :-
        printStips(),
        writeStipStats(),
        X = stdio::readLine(),
        increaseStip(toTerm(X)),
        printStips(),
        writeStipStats().

end implement main

goal
    console::runUtf8(main::run).
