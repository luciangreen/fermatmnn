:- module(mnn_repl, [
    start_repl/0,
    run_command/4
]).

:- use_module(library(readutil)).
:- use_module(mnn_domain).
:- use_module(mnn_reasoner).
:- use_module(mnn_trace).
:- use_module(mnn_synthesis).
:- use_module(mnn_research).

start_repl :-
    writeln('MNN Manual Neuronet'),
    writeln('Type help. for commands.'),
    repl_loop(state{output_mode:text}).

repl_loop(State) :-
    write('mnn> '),
    flush_output(current_output),
    read_line_to_string(user_input, Line),
    ( Line == end_of_file ->
        true
    ; normalize_space(string(Trimmed), Line),
      ( Trimmed = "" ->
            NextState = State,
            Continue = true
      ; run_command(State, Trimmed, NextState, Continue)
      ),
      ( Continue == true -> repl_loop(NextState) ; true )
    ).

run_command(State, "help.", State, true) :-
    writeln('Commands: load_domain(NAME). ask(TERM). explain(TERM). research(TERM). synthesise(NAME). quit.').
run_command(State, "quit.", State, false) :-
    writeln('Bye.').
run_command(State, Line, State, true) :-
    parse_command(Line, Goal),
    !,
    run_goal(Goal).
run_command(State, _Line, State, true) :-
    writeln('Unrecognised command. Type help.').

parse_command(Line, Goal) :-
    atom_string(Atom, Line),
    atom_to_term(Atom, Goal, _).

run_goal(load_domain(Domain)) :-
    mnn_domain:load_domain(Domain),
    format('Loaded domain ~w.~n', [Domain]).
run_goal(unload_domain(Domain)) :-
    mnn_domain:unload_domain(Domain),
    format('Unloaded domain ~w.~n', [Domain]).
run_goal(ask(Query)) :-
    mnn_reasoner:ask(Query, Result),
    format('Result: ~q~n', [Result.truth]),
    format('Status: ~w~n', [Result.status]).
run_goal(explain(Query)) :-
    mnn_reasoner:ask(Query, Result),
    mnn_trace:trace_from_result(Query, Result, Trace),
    format('Trace: ~q~n', [Trace]).
run_goal(research(Query)) :-
    mnn_research:research(Query, Result),
    format('Research: ~q~n', [Result]).
run_goal(synthesise(Name)) :-
    mnn_synthesis:synthesise(Name, Result),
    format('Generated candidate:~n~s~nStatus: ~w~n', [Result.code, Result.status]).
run_goal(Goal) :-
    call(Goal),
    writeln(true).
