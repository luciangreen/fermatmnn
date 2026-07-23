:- begin_tests(optimiser).

:- use_module('../src/mnn_optimiser').

test(reports_repeated_goals) :-
    Clause = (p(X) :- q(X), q(X), r(X)),
    mnn_optimiser:analyse_clause(Clause, Report),
    assertion(member(q(_), Report.repeated_goals)).

:- end_tests(optimiser).
