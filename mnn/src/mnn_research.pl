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
    !,
    fermat_finding(N, Finding, Classification, Status).

% The four cases are told apart: a composite that passes (a pseudoprime), a
% prime (it passes, as Fermat's theorem says), a composite that fails, and a
% number the test does not apply to.
fermat_finding(N, 'passes base-2 Fermat test despite compositeness', pseudoprime_behaviour,
               computationally_verified([bases([2])])) :-
    pseudoprime_base2(N), !.
fermat_finding(N, 'is prime (primes other than 2 pass the base-2 Fermat test)', prime,
               computationally_verified([trial_division])) :-
    integer(N), N >= 2, is_prime_small(N), !.
fermat_finding(N, 'fails base-2 Fermat test, so it is composite', composite,
               computationally_verified([bases([2])])) :-
    integer(N), N > 2, !.
fermat_finding(_, 'the Fermat test applies only to integers greater than 1', not_applicable,
               not_applicable).

research(correlation(Xs, Ys), result{
    query: correlation(Xs, Ys),
    finding: correlation_candidate(Sign),
    classification: candidate,
    status: empirical
}) :-
    !,
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
    mod_pow(2, Pow, N, Mod),     % the remainder, without building 2^Pow
    Mod =:= 1.

% mod_pow(+B, +E, +M, -R): R is B^E mod M by repeated squaring, so no number
% larger than M squared is built.
mod_pow(_, 0, M, R) :- !, R is 1 mod M.
mod_pow(B, E, M, R) :-
    E1 is E // 2,
    mod_pow(B, E1, M, H),
    H2 is (H * H) mod M,
    (   E mod 2 =:= 0 -> R = H2 ; R is (H2 * B) mod M ).

is_prime_small(2).
is_prime_small(N) :-
    integer(N),
    N > 2,
    Max is floor(sqrt(N)),
    \+ (between(2, Max, D), N mod D =:= 0).

% The sign of the correlation over every pair of values (the sum of the
% products of deviations from the means), not just the first two points.
correlation_sign(Xs, Ys, Sign) :-
    length(Xs, N), length(Ys, N), N >= 2,
    sum_list(Xs, SX), sum_list(Ys, SY),
    MX is SX / N, MY is SY / N,
    foldl([X, Y, A0, A]>>(A is A0 + (X - MX) * (Y - MY)), Xs, Ys, 0, Cov),
    (   Cov > 0 -> Sign = positive
    ;   Cov < 0 -> Sign = negative
    ;   Sign = unknown
    ), !.
correlation_sign(_, _, unknown).
