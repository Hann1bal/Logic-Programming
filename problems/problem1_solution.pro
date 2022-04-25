/*
    Семейные отношения

gender enum:
        male / female
*/

person(4, "Maggy", female).
person(3, "Matt", male).


person(1, "Tom", male).
person(2, "Pam", female).

person(5, "Julia", female).
person(6, "Daemon", male).
person(7, "Tony", male).

/* Семантика и последовательность атрибутов определяется программистом */

/* parent(Child, Parent) */
parent(4, 1).

parent(3, 1).
parent(3, 2).

parent(4, 2).

parent(1, 5).
parent(1, 6).

parent(2, 7).

/* строки: father("Matt", "Tom")  */
father(Child, Father) :-
    person(ChildId, Child, _),
    person(FatherId, Father, male),
    parent(ChildId, FatherId).

mother(Child, Mother) :-
    person(ChildId, Child, _),
    person(MotherId, Mother, female),
    parent(ChildId, MotherId).

gfather(Person, Grandfather) :-
    person(PersonId, Person, _),
    parent(PersonId, ParentId),
    person(ParentId, Parent, _),
    father(Parent, Grandfather).

gmother(Person, Grandmother) :-
    person(PersonId, Person, _),
    parent(PersonId, ParentId),
    person(ParentId, Parent, _),
    mother(Parent, Grandmother).

sister(Person, Sister) :-
    person(_, Sister, female), /* Sister - женского пола */
    father(Person, Father), /* Person и Sister имееют одинакового отца */
    father(Sister, Father),
    not(Person = Sister). /* Person и Sister - разные люди */

sister(Person, Sister) :-
    person(_, Sister, female), /* Sister - женского пола */
    mother(Person, Mother), /* Person и Sister имееют одинаковую мать */
    mother(Sister, Mother),
    not(Person = Sister). /* Person и Sister - разные люди */

/* brother  - аналогично sister */

/* супер сложно. через рекурсию. Предок */
ancestor(Person, Ancestor) :- /* отец - предок */
    father(Person, Ancestor).
ancestor(Person, Ancestor) :- /* мать - предок */
    mother(Person, Ancestor).
ancestor(Person, Ancestor) :- /* предок человека - это предок его отца или матери */
    father(Person, Father),
    ancestor(Father, Ancestor).
ancestor(Person, Ancestor) :-
    mother(Person, Mother),
    ancestor(Mother, Ancestor).


