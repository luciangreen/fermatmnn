:- begin_tests(trace).

:- use_module('../src/mnn_storage').
:- use_module('../src/mnn_domain').
:- use_module('../src/mnn_reasoner').
:- use_module('../src/mnn_trace').

test(trace_contains_provenance) :-
    mnn_storage:reset_storage,
    mnn_domain:load_domain(number_theory),
    mnn_reasoner:ask(is_composite(341), Result),
    mnn_trace:trace_from_result(is_composite(341), Result, Trace),
    assertion(Trace.support_facts \= []),
    assertion(Trace.support_rules == [r_composite_from_factor]).

:- end_tests(trace).
