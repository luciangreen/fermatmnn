:- begin_tests(benchmark).

:- use_module('../src/mnn_benchmark').

test(benchmark_report_shape) :-
    mnn_benchmark:run_benchmarks(Result),
    assertion(is_dict(Result)),
    assertion(_ = Result.environment),
    assertion(_ = Result.results).

:- end_tests(benchmark).
