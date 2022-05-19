implement main
    open core, stdio

class facts
    s : (integer Value).

clauses
    s(1).
    s(2).
    s(-1).
    s(-10).
    s(0).
    s(0).
    s(18).
    % add more facts with different numbers

class predicates
%    Пусть задан список фактов, содержащий числовые значения, например, s(<num>).
%    - Необходимо определить количество положительных и отрицательных элементов,
%    - количество элементов, превосходящих по модулю заданный
%    - среднее арифметическое положительных элементов


clauses
    run().

end implement main

goal
    console::runUtf8(main::run).
