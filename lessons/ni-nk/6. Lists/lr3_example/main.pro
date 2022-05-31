% Copyright
/*
Какие продукты входят в блюдо
В каких блюдах используется данный продукт
Калорийность каждого продукта в блюде
Общая калорийность блюда
*/

implement main
    open core, stdio

domains
    unit = шт; г; кг; мл; л; чл; стл; щепотка; зб.
    продкалор = продкалор(string Название_продукта, real Калорийность_в_блюде).
    сострец = сострец(string Название_продукта, real Количество, unit Единица_измерения).

class facts - kulinarDB
    блюдо : (integer Номер, string Название, string Рецепт).
    продукт : (integer Номер, string Название, unit Единица_измерения, real Калории_в_единице).
    состав_блюда : (integer Номер_блюда, integer Номер_продукта, real Количество).

class predicates %Вспомогательные предикаты
    длина : (A*) -> integer N.
    сумма_элем : (real* List) -> real Sum.
    среднее_списка : (real* List) -> real Average determ.

clauses
    длина([]) = 0.
    длина([_ | T]) = длина(T) + 1.

    сумма_элем([]) = 0.
    сумма_элем([H | T]) = сумма_элем(T) + H.

    среднее_списка(L) = сумма_элем(L) / длина(L) :-
        длина(L) > 0.

class predicates %Основные предикаты
    состав : (string Название_блюда) -> string* Компоненты determ.
    состав_расш : (string Название_блюда) -> сострец* determ.
    кол_ингр : (string Название_блюда) -> integer N determ.
    исп_пр : (string Название_продукта) -> string* Блюда determ.
    калорийность : (string Название_блюда) -> real Калорийность determ.
    калор_расш : (string Название_блюда) -> продкалор* determ.

clauses
    состав(X) = Nprs :-
        блюдо(N, X, _),
        !,
        Nprs =
            [ NamePr ||
                состав_блюда(N, NPR, _),
                продукт(NPR, NamePr, _, _)
            ].

    кол_ингр(X) = длина(состав(X)).

    исп_пр(X) = List :-
        продукт(Npr, X, _, _),
        !,
        List =
            [ NameBl ||
                состав_блюда(Nbl, Npr, _),
                блюдо(Nbl, NameBl, _)
            ].

    калорийность(X) =
            сумма_элем(
                [ Kol * Kalor ||
                    состав_блюда(Nbl, NPR, Kol),
                    продукт(NPR, _, _, Kalor)
                ]) :-
        блюдо(Nbl, X, _),
        !.

    калор_расш(X) =
            [ продкалор(NamePr, Kol * Kalor) ||
                состав_блюда(Nbl, NPR, Kol),
                продукт(NPR, NamePr, _, Kalor)
            ] :-
        блюдо(Nbl, X, _),
        !.

    состав_расш(X) =
            [ сострец(NamePr, Kol, Unit) ||
                состав_блюда(Nbl, NPR, Kol),
                продукт(NPR, NamePr, Unit, _)
            ] :-
        блюдо(Nbl, X, _),
        !.

class predicates %Вывод на экран продуктов блюда + их калорий
    write_prodcalor : (продкалор* Продукты_и_калорийности).
    write_sostrec : (сострец* Продукты_и_количество).

clauses
    write_prodcalor(L) :-
        foreach продкалор(NamePr, CalorPr) = list::getMember_nd(L) do
            writef("\t%\t%\n", NamePr, CalorPr)
        end foreach.
    write_sostrec(L) :-
        foreach сострец(NamePr, Kol, Unit) = list::getMember_nd(L) do
            writef("\t%s\t%f%s\n", NamePr, Kol, toString(Unit))
        end foreach.
/*
Устаревшие предикаты для вывода таблицы
НО: данный предикат рабтоает для вывода таблиц любой размерности.
Важно только, чтобы все данные были строками.

class predicates
    write_table : (string** Data) procedure (i).
    write_trow : (string** Data, string** Rest) procedure (i, o).
    append : (A*, A*, A*) procedure (i, i, o).
    convert_rs : (real* List) ->  string* SList procedure (i).
clauses
    append([], Y, Y).
    append([X1|T1], Y, [X1|T2]) :- append(T1, Y, T2).

    write_trow([[]|_], []) :- !.
    write_trow([], []) :- nl, !.
    write_trow([[H|Lt]|T], Rest) :- write("\t", H), write_trow(T, Rest1), append([Lt], Rest1, Rest).

    write_table([]) :- write("________"), !.
    write_table(Data) :- write_trow(Data, Rest), write_table(Rest).

    convert_rs([]) = [].
    convert_rs([R|Tr]) = S :- append( [toString(R)] , convert_rs(Tr) , S ).
*/

clauses
    run() :-
        console::init(),
        file::consult("..\\kul.txt", kulinarDB),
        fail.
    run() :-
        X = "Тающий картофель",
        L = состав(X),
        write(L),
        write("\tКоличество = "),
        write(кол_ингр(X)),
        nl,
        fail.
    run() :-
        L = исп_пр("Сливочное масло"),
        write(L),
        nl,
        write(калорийность("Тающий картофель")),
        nl,
        fail.
    run() :-
        X = "Тающий картофель",
        write_prodcalor(калор_расш(X)),
        nl,
        fail.
    run() :-
        X = "Тающий картофель",
        write_sostrec(состав_расш(X)),
        nl,
        fail.
    run() :-
        succeed.

end implement main

goal
    console::run(main::run).
