:- begin_tests(reasoner).

:- use_module('../src/mnn_storage').
:- use_module('../src/mnn_domain').
:- use_module('../src/mnn_reasoner').

test(answers_rule_chain_with_status) :-
    mnn_storage:reset_storage,
    mnn_domain:load_domain(number_theory),
    mnn_reasoner:ask(is_composite(341), Result),
    assertion(Result.truth == true),
    assertion(Result.status == logically_derived),
    assertion(Result.support_rules == [r_composite_from_factor]).

test(unknown_query_status) :-
    mnn_storage:reset_storage,
    mnn_domain:load_domain(number_theory),
    mnn_reasoner:ask(is_composite(997), Result),
    assertion(Result.truth == unknown),
    assertion(Result.status == unknown).

:- end_tests(reasoner).
