% Copyright

implement main
    open core, stdio, file

class facts
    a : (integer).

clauses
    a(0).
    a(1).
    a(2).

class predicates
    pall : ().
clauses
    pall() :-
        a(X),
        writef("\ta: %\n", X),
        fail.
    pall().

clauses
    run() :-
        pall(),
        fail.

    run() :-
        nl,
        write("Updating...\n"),
        retract(a(X)),
        asserta(a(10 * X)),
        fail.

    run() :-
        pall().

end implement main

goal
    console::runUtf8(main::run).
