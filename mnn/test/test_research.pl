:- begin_tests(research).

:- use_module('../src/mnn_research').

test(labels_pseudoprime_behaviour) :-
    mnn_research:research(fermat_test(341), Result),
    assertion(Result.classification == pseudoprime_behaviour).

test(candidate_classification) :-
    mnn_research:classify_candidate(false, false, Status),
    assertion(Status == empirical).

:- end_tests(research).

:- begin_tests(research_findings).

test(fermat_findings_tell_cases_apart) :-
    findall(N-C, ( member(N, [341, 561, 97, 4, 1]),
                   mnn_research:research(fermat_test(N), R), get_dict(classification, R, C) ), Cs),
    Cs == [341-pseudoprime_behaviour, 561-pseudoprime_behaviour, 97-prime, 4-composite, 1-not_applicable].

test(fermat_large_number_is_quick) :-
    mnn_research:research(fermat_test(1000003), R),
    R.classification == prime.

test(correlation_uses_every_point) :-
    mnn_research:research(correlation([1,2,3,4], [1,2,3,0]), R),
    R.finding == correlation_candidate(negative).

:- end_tests(research_findings).
