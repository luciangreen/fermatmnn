:- begin_tests(repl).

:- use_module('../src/mnn_storage').
:- use_module('../src/mnn_repl').

test(parse_and_execute_load_command) :-
    mnn_storage:reset_storage,
    State0 = state{output_mode:text},
    mnn_repl:run_command(State0, "load_domain(core).", State1, Continue),
    assertion(State1 == State0),
    assertion(Continue == true).

test(quit_changes_continue_flag) :-
    State = state{output_mode:text},
    mnn_repl:run_command(State, "quit.", _StateOut, Continue),
    assertion(Continue == false).

:- end_tests(repl).
