:- begin_tests(integration).

:- use_module('../mnn').

test(example_number_theory_session) :-
    load_domain(number_theory),
    ask(is_composite(341), Result),
    assertion(Result.truth == true),
    explain(is_composite(341), Trace),
    assertion(member(r_composite_from_factor, Trace.support_rules)).

test(research_and_synthesis_session) :-
    load_domain(list_algorithms),
    synthesise(double_list, SynthResult),
    assertion(SynthResult.status == verified_on_examples),
    research(fermat_test(341), ResearchResult),
    assertion(ResearchResult.classification == pseudoprime_behaviour).

:- end_tests(integration).
