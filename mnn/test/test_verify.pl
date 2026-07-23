:- begin_tests(verify).

:- use_module('../src/mnn_verify').

user:id(X, X).
user:id_ref(X, X).
user:bounded_id(N, N).
user:non_negative(N) :- N >= 0.

test(verify_examples_pass) :-
    mnn_verify:verify_examples(user:id, [io(a, a), io(2, 2)], Status),
    assertion(Status == verified).

test(bounded_exhaustive) :-
    mnn_verify:bounded_check(user:bounded_id, user:non_negative, 5, Status),
    assertion(Status == verified_within_bound(5)).

test(reference_compare) :-
    mnn_verify:compare_with_reference(user:id, user:id_ref, [a, b], Status),
    assertion(Status == verified_reference_match).

:- end_tests(verify).
