% Copyright
% To practice on fail-loops and assert/retract predicates
% uses external data file 'problem2.data'

implement main
    open core, stdio

domains
    category = living; transport; food; other.

class facts
    spendings : (integer Spendings, category Category, integer Day, string Month).

class predicates
%    prints report with total / average spendings per day on this category over the given month
    categoryReport : (category Category, string Month).
%    prints full report with total / average spendings by category (and in general) over the given month
%    you may also implement a report of stats by date on the given month
    fullReport : (string Month).

clauses
    run().

end implement main

goal
    console::runUtf8(main::run).
