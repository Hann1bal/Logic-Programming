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

/* Последующие предикаты необходимо реализовать самостоятельно */
mother(Child, Mother)
grandfather(Person, Grandfather) /* дедушка */
grandmother(Person, Grandmother) /* бабушка */
sister(Person, Sister) / brother(Person, Brother)   /* может потребоваться not() */

/* супер сложно. через рекурсию. Предок - любой человек, который находится "выше" Person в генеалогическом древе */
ancestor(Person, Ancestor)
