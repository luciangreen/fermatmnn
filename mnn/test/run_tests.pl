:- initialization(main, main).

main :-
    consult('mnn/test/test_domain.pl'),
    consult('mnn/test/test_rules.pl'),
    consult('mnn/test/test_reasoner.pl'),
    consult('mnn/test/test_trace.pl'),
    consult('mnn/test/test_dependencies.pl'),
    consult('mnn/test/test_choice.pl'),
    consult('mnn/test/test_synthesis.pl'),
    consult('mnn/test/test_optimiser.pl'),
    consult('mnn/test/test_scheduler.pl'),
    consult('mnn/test/test_research.pl'),
    consult('mnn/test/test_verify.pl'),
    consult('mnn/test/test_repl.pl'),
    consult('mnn/test/test_benchmark.pl'),
    consult('mnn/test/test_integration.pl'),
    run_tests,
    halt.
