% Copyright

implement main
    open core, stdio, file

constants
    hello = "Hello, world!".

domains
    gender = male; female.
    name_type = string.

class facts - familyDb
    person : (name_type Name, gender Gender) nondeterm.
    parent : (name_type Child, name_type Parent) nondeterm.

class predicates
    father : (name_type Child, name_type Father) nondeterm anyflow.
clauses
    father(C, F) :-
        person(F, male),
        parent(C, F).

class predicates
    gfather : (name_type Child, name_type GFather) nondeterm anyflow.
clauses
    gfather(C, G) :-
        parent(C, F),
        father(F, G).

class predicates
    ancestor : (name_type Child, name_type Ancestor [out]) nondeterm.
clauses
    ancestor(C, A) :-
        parent(C, A).
    ancestor(C, A) :-
        parent(C, P),
        ancestor(P, A).

clauses
    run() :-
        consult("../family.txt", familyDb),
        fail.

    run() :-
        father("Matt", F),
        write(F),
        nl,
        fail.

    run() :-
        write("Ancestors for Matt:\n"),
        ancestor("Matt", A),
        write(A),
        nl,
        fail.

    run().

end implement main

goal
    console::runUtf8(main::run).
