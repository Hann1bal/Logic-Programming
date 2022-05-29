% Copyright

implement main
    open core, stdio

class predicates
    move : (integer N, string A, string B, string C) determ.
clauses
    move(1, A, B, _) :-
        writef("Move a ring from % to %\n", A, B),
        !.
    move(N, A, B, C) :-
        N > 1,
        move(N - 1, A, C, B),
        move(1, A, B, C),
        move(N - 1, C, B, A).

class facts
    state : (integer Small, integer Large).

class predicates
    find : (integer GoalSmall, integer GoalLarge) determ.
    find : (integer Small, integer Large, integer GoalSmall, integer GoalLarge) determ.
    adj : (integer Small, integer Large, integer AdjSmall [out], integer AdjLarge [out]) nondeterm.

clauses
    adj(S, L, S, 0) :-
        L > 0.
    adj(S, L, 0, L) :-
        S > 0.
    adj(S, L, S, 5) :-
        L < 5.
    adj(S, L, 3, L) :-
        S < 3.
    adj(S, L, 0, S + L) :-
        S + L <= 5.
    adj(S, L, L - 5 + S, 5) :-
        L - 5 + S >= 0.
    adj(S, L, S + L, 0) :-
        S + L <= 3.
    adj(S, L, 3, L + S - 3) :-
        L + S - 3 >= 0.

    find(Small, Large, GoalSmall, GoalLarge) :-
        GoalSmall = Small,
        GoalLarge = Large,
        writef("Small: %\tLarge: %\n", Small, Large),
        !.

    find(Small, Large, GoalSmall, GoalLarge) :-
        adj(Small, Large, Small_, Large_),
        not(state(Small_, Large_)),
        assert(state(Small_, Large_)),
        find(Small_, Large_, GoalSmall, GoalLarge),
        !,
        writef("Small: %\tLarge: %\n", Small, Large).

    find(GoalSmall, GoalLarge) :-
        assert(state(0, 0)),
        find(0, 0, GoalSmall, GoalLarge).

class facts
    obstacle : (integer Row, integer Col).
    state_new : (integer Row, integer Col).

clauses
    obstacle(0, 1).
    obstacle(1, 3).

class predicates
    find_bin_matrix : (integer StartRow, integer StartCol, integer GoalRow, integer GoalCol) determ.
    adj_mat : (integer StartRow, integer StartCol, integer GoalRow [out], integer GoalCol [out]) nondeterm.

clauses
    adj_mat(StartRow, StartCol, StartRow - 1, StartCol) :-
        StartRow >= 1.
    adj_mat(StartRow, StartCol, StartRow + 1, StartCol) :-
        StartRow <= 5.

    adj_mat(StartRow, StartCol, StartRow, StartCol - 1) :-
        StartCol >= 1.
    adj_mat(StartRow, StartCol, StartRow, StartCol + 1) :-
        StartCol <= 5.

    find_bin_matrix(GoalRow, GoalCol, GoalRow, GoalCol) :-
        writef("Row: %\tCol: %\n", GoalRow, GoalCol),
        !.

    find_bin_matrix(Row, Col, GoalRow, GoalCol) :-
        adj_mat(Row, Col, Row1, Col1),
        not(obstacle(Row1, Col1)),
        not(state_new(Row1, Col1)),
        assert(state_new(Row1, Col1)),
        find_bin_matrix(Row1, Col1, GoalRow, GoalCol),
        writef("Row: %\tCol: %\n", Row, Col),
        !.

clauses
    run() :-
        find_bin_matrix(0, 0, 1, 4),
        !.
    run().

end implement main

goal
    console::runUtf8(main::run).
