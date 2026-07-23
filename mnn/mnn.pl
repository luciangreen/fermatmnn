:- module(mnn_core, [
    mnn/0,
    load_domain/1,
    unload_domain/1,
    list_domains/1,
    ask/2,
    explain/2,
    synthesise/2,
    research/2,
    set_option/2,
    run_benchmarks/1
]).

:- use_module(src/mnn_repl, []).
:- use_module(src/mnn_storage, []).
:- use_module(src/mnn_domain, []).
:- use_module(src/mnn_reasoner, []).
:- use_module(src/mnn_trace, []).
:- use_module(src/mnn_synthesis, []).
:- use_module(src/mnn_research, []).
:- use_module(src/mnn_benchmark, []).

:- dynamic option/2.

option(output_mode, text).
option(trace_mode, summary).

mnn :-
    mnn_storage:reset_storage,
    mnn_repl:start_repl.

load_domain(Domain) :-
    mnn_domain:load_domain(Domain).

unload_domain(Domain) :-
    mnn_domain:unload_domain(Domain).

list_domains(Domains) :-
    mnn_domain:list_loaded_domains(Domains).

ask(Query, Result) :-
    mnn_reasoner:ask(Query, Result).

explain(Query, Explanation) :-
    ask(Query, Result),
    mnn_trace:trace_from_result(Query, Result, Explanation).

synthesise(Name, Result) :-
    mnn_synthesis:synthesise(Name, Result).

research(Query, Result) :-
    mnn_research:research(Query, Result).

set_option(Key, Value) :-
    retractall(option(Key, _)),
    assertz(option(Key, Value)).

run_benchmarks(Result) :-
    mnn_benchmark:run_benchmarks(Result).
