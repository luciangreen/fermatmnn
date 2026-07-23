:- module(mnn_verify, [
    verify_examples/3,
    bounded_check/4,
    compare_with_reference/4
]).

verify_examples(_Predicate, [], verified).
verify_examples(Predicate, [io(Input, Output)|Rest], Status) :-
    ( call(Predicate, Input, Observed), Observed == Output ->
        verify_examples(Predicate, Rest, Status)
    ; Status = failed_example(io(Input, Output))
    ).

bounded_check(Generator, Property, Bound, verified_within_bound(Bound)) :-
    forall(
        (between(0, Bound, N), call(Generator, N, Value)),
        call(Property, Value)
    ).

compare_with_reference(Predicate, Reference, Inputs, verified_reference_match) :-
    forall(
        member(Input, Inputs),
        ( call(Predicate, Input, A),
          call(Reference, Input, B),
          A == B
        )
    ).
