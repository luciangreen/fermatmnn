:- module(benchmark_suite, [run/1]).

:- use_module('../src/mnn_benchmark').

run(Result) :-
    mnn_benchmark:run_benchmarks(Result).
