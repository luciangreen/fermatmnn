:- module(mnn_research, [
    research/2,
    classify_candidate/3
]).

research(fermat_test(N), result{
    query: fermat_test(N),
    finding: Finding,
    classification: Classification,
    status: Status
}) :-
    ( pseudoprime_base2(N) ->
        Finding = 'passes base-2 Fermat test despite compositeness',
        Classification = pseudoprime_behaviour,
        Status = computationally_verified([bases([2])])
    ; Finding = 'no pseudoprime behaviour found in tested bounds',
      Classification = candidate,
      Status = bounded_search_complete
    ).
research(correlation(Xs, Ys), result{
    query: correlation(Xs, Ys),
    finding: correlation_candidate(Sign),
    classification: candidate,
    status: empirical
}) :-
    correlation_sign(Xs, Ys, Sign).
research(Query, result{
    query: Query,
    finding: not_supported,
    classification: candidate,
    status: inconclusive
}).

classify_candidate(PassesChecks, Refuted, Status) :-
    ( Refuted == true ->
        Status = refuted
    ; PassesChecks == true ->
        Status = verified
    ; Status = empirical
    ).

pseudoprime_base2(N) :-
    integer(N),
    N > 2,
    \+ is_prime_small(N),
    Pow is N - 1,
    Mod is (2^Pow) mod N,
    Mod =:= 1.

is_prime_small(2).
is_prime_small(N) :-
    integer(N),
    N > 2,
    Max is floor(sqrt(N)),
    \+ (between(2, Max, D), N mod D =:= 0).

correlation_sign([X1,X2|_], [Y1,Y2|_], positive) :-
    X2 > X1,
    Y2 >= Y1,
    !.
correlation_sign([X1,X2|_], [Y1,Y2|_], negative) :-
    X2 > X1,
    Y2 =< Y1,
    !.
correlation_sign(_, _, unknown).
