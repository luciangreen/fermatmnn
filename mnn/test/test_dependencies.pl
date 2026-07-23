:- begin_tests(dependencies).

:- use_module('../src/mnn_storage').
:- use_module('../src/mnn_domain').
:- use_module('../src/mnn_dependencies').

test(necessary_calculations_for_output) :-
    mnn_storage:reset_storage,
    mnn_domain:load_domain(number_theory),
    mnn_dependencies:necessary_for(is_composite(341), Needed),
    assertion(member(is_composite(341), Needed)),
    assertion(member(has_factor(341, 11, 31), Needed)).

:- end_tests(dependencies).
