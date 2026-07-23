:- begin_tests(domain).

:- use_module('../src/mnn_storage').
:- use_module('../src/mnn_domain').

test(load_and_unload_domain_no_stale_state) :-
    mnn_storage:reset_storage,
    mnn_domain:load_domain(core),
    mnn_storage:stored_fact(core, system(mnn)),
    mnn_domain:unload_domain(core),
    \+ mnn_storage:stored_fact(core, system(mnn)),
    \+ mnn_storage:loaded_domain(core).

:- end_tests(domain).
