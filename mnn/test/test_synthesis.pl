:- begin_tests(synthesis).

:- use_module('../src/mnn_storage').
:- use_module('../src/mnn_domain').
:- use_module('../src/mnn_synthesis').

test(synthesise_recursive_list_algorithm) :-
    mnn_storage:reset_storage,
    mnn_domain:load_domain(list_algorithms),
    mnn_synthesis:synthesise(double_list, Result),
    assertion(Result.candidate_type == recursive_list),
    assertion(Result.status == verified_on_examples).

test(synthesise_lookup_algorithm) :-
    mnn_storage:reset_storage,
    mnn_domain:load_domain(list_algorithms),
    mnn_synthesis:synthesise(color_of, Result),
    assertion(Result.candidate_type == lookup),
    assertion(sub_string(Result.code, _, _, _, "lookup")).

:- end_tests(synthesis).
