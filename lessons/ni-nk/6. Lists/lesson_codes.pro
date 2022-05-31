% Copyright

implement main
    open core, stdio

domains
    ilist = integer*.

class predicates
    add_head : (integer Element, ilist List, ilist NewList [out]).
clauses
    add_head(Element, List, [Element | List]).

class predicates
    add_tail : (integer Element, ilist List, ilist NewList [out]).
clauses
    add_tail(Element, [], [Element]).
    add_tail(Element, [H | T], [H | NewT]) :-
        add_tail(Element, T, NewT).

class predicates
    index_of : (integer Element, ilist List, integer Index [out]).
    interface_index_of : (integer Element, ilist List).

class facts
    index : (integer Idx) single.
    sum : (integer Sum) single.

clauses
    index(0).
    index_of(_, [], -1) :-
        assert(index(-1)).
    index_of(Element, List, Ind) :-
        List = [H | _],
        Element = H,
        index(Ind),
        !.
    index_of(Element, [_ | List], Index) :-
        index(Ind),
        assert(index(Ind + 1)),
        index_of(Element, List, Index).

    interface_index_of(Element, List) :-
        assert(index(0)),
        index_of(Element, List, Index),
        write("Index: ", Index),
        nl.

class predicates
    length : (ilist List, integer Length [out]).
    length : (ilist List, integer Current, integer Length [out]).
    length_down : (ilist List, integer Length [out]).

clauses
    length(List, Length) :-
        length(List, 0, Length).

    length([], Current, Current).
    length([H | T], Current, Length) :-
        length(T, Current + 1, Length).

    length_down([], 0).
    length_down([_ | T], 1 + Len) :-
        length_down(T, Len).

class predicates
    average_value : (ilist List).
    list_sum : (ilist List, integer Res [out]).

clauses
    sum(0).
    list_sum([], Res) :-
        sum(Res),
        !.
    list_sum([H | T], Res) :-
        sum(Sum),
        assert(sum(Sum + H)),
        list_sum(T, Res).

    average_value(List) :-
        assert(sum(0)),
        length(List, Length),
        list_sum(List, Res),
        write("Average value : ", Res / Length).

class predicates
    contains : (integer, ilist) determ.
clauses
    contains(X, [X | _]) :-
        !.
    contains(X, [_ | T]) :-
        contains(X, T).

class predicates
    remove_all : (ilist Input, ilist BadElements, ilist Output [out]).
clauses
    remove_all([], _, []).
    remove_all([H | T], BadElements, [H | Out2]) :-
        not(contains(H, BadElements)),
        !,
        remove_all(T, BadElements, Out2).

    remove_all([H | T], BadElements, Out) :-
        remove_all(T, BadElements, Out).

class predicates
    generate_list : (ilist List [out], ilist CurList, integer Num) determ.
    generate_interface : (integer Num, ilist List [out]) determ.

clauses
    generate_list(List, List, 0) :-
        !.

    generate_list(List, CurList, Num) :-
        Num > 0,
        generate_list(List, [Num | CurList], Num - 1).

    generate_interface(Num, List) :-
        generate_list(List, [], Num).

clauses
    run() :-
        %average_value([2, 3, 4, 5]).
        %remove_all([1, 2, 3, 4, 5], [2, 4], L),
        generate_interface(10, L),
        !,
        write(L),
        nl.
        /*write(Lengt
        nl.*/
    run().

end implement main

goal
    console::runUtf8(main::run).
