% Copyright

implement main
    open core, stdio

class predicates
    at : (A*, integer) -> A determ.
    length : (A*) -> integer Len.

clauses
    length([]) = 0.
    length([_ | T]) = length(T) + 1.

    at(L, Index) = at(L, Len + Index) :-
        Index < 0,
        Len = length(L),
        Len >= -Index,
        !.
    at([H | _], Index) = H :-
        Index = 0,
        !.
    at([_ | T], Index) = at(T, Index - 1).

clauses
    run() :-
        L = [1, 2, 3, 4],
        write(at(L, -3)),
        fail.
    run().

end implement main

goal
    console::runUtf8(main::run).
