:- begin_tests(benchmark).

:- use_module('../src/mnn_benchmark').
:- use_module('../benchmarks/expected_results').

test(benchmark_report_shape) :-
    mnn_benchmark:run_benchmarks(Result),
    assertion(is_dict(Result)),
    assertion(_ = Result.environment),
    assertion(_ = Result.results).

test(benchmark_cases_are_documented) :-
    mnn_benchmark:run_benchmarks(Result),
    maplist(case_name, Result.results, Names0),
    sort(Names0, Names),
    assertion(Names == [
        factor_trial,
        gcd_euclid,
        list_double_100,
        list_reverse_1000,
        modexp_large,
        modexp_small
    ]),
    forall(
        member(Case, Result.results),
        ( expected_results:expected_case(Case.name, non_negative_inferences),
          assertion(Case.cpu >= 0),
          assertion(Case.inferences >= 0)
        )
    ).

test(modular_exponentiation_handles_zero_and_large_exponents) :-
    mnn_benchmark:powm(9, 0, 7, Identity),
    mnn_benchmark:powm(2, 10, 341, Result),
    assertion(Identity == 1),
    assertion(Result == 1).

test(euclidean_gcd_handles_negative_inputs) :-
    mnn_benchmark:gcd_euclid(-54, 24, Gcd),
    assertion(Gcd == 6).

case_name(Case, Name) :-
    Name = Case.name.

:- end_tests(benchmark).
