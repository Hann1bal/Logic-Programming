% Copyright

implement main
    open core, stdio

domains
    unit = шт; кг; г; щепотка; л; мл; чл; стл; стакан; зб.

class facts - kulinarDb
    продукт : (integer Id, string Название, unit Units, real Калорийность).
    блюдо : (integer Id, string Название, string Рецепт).
    состав_блюда : (integer IdБлюда, integer IdПродукта, real Количество).

class facts
    s : (real Sum) single.

clauses
    s(0).

class predicates
    состав : (string Название_блюда) nondeterm.
    исп_пр : (string Название_продукта) nondeterm.
    калорийность : (string Название_блюда) nondeterm.
    калор_расш : (string Название_блюда) failure.

clauses
    состав(X) :-
        блюдо(Id, X, _),
        writef("Состав %:\n", X),
        состав_блюда(Id, IdПр, _),
        продукт(IdПр, НазваниеПродукта, _, _),
        writef("\t%\n", НазваниеПродукта),
        fail.
    состав(X) :-
        блюдо(_, X, _),
        write("Конец списка\n").

    исп_пр(X) :-
        продукт(Id, X, _, _),
        writef("% используется в:\n", X),
        состав_блюда(IdБ, Id, _),
        блюдо(IdБ, Название, _),
        writef("\t%\n", Название),
        fail.
    исп_пр(X) :-
        продукт(_, X, _, _),
        write("Конец списка\n").

    калорийность(X) :-
        блюдо(Id, X, _),
        assert(s(0)),
        состав_блюда(Id, IdПр, Количество),
        продукт(IdПр, _, _, Калорийность),
        s(Sum),
        assert(s(Sum + Количество * Калорийность)),
        fail.
    калорийность(X) :-
        блюдо(_, X, _),
        s(Sum),
        writef("Калорийность % равна % калорий", X, Sum),
        nl.

    калор_расш(X) :-
        калорийность(X),
        блюдо(Id, X, _),
        состав_блюда(Id, IdПр, Количество),
        продукт(IdПр, Название, _, Калорийность),
        writef("\t%: % калорий\n", Название, Количество * Калорийность),
        fail.

clauses
    run() :-
        file::consult("../kuldb.txt", kulinarDb),
        fail.

    run() :-
        состав("Тающий картофель"),
        fail.

    run() :-
        исп_пр("Сливочное масло"),
        fail.

    run() :-
        калорийность("Тающий картофель"),
        fail.

    run() :-
        калор_расш("Курица, запеченая с картошкой").

    run().

end implement main

goal
    console::runUtf8(main::run).
