:- begin_tests(research).

:- use_module('../src/mnn_research').

test(labels_pseudoprime_behaviour) :-
    mnn_research:research(fermat_test(341), Result),
    assertion(Result.classification == pseudoprime_behaviour).

test(candidate_classification) :-
    mnn_research:classify_candidate(false, false, Status),
    assertion(Status == empirical).

:- end_tests(research).
