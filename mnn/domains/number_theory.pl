domain(number_theory).

concept(number_theory).
concept(compositeness).
concept(primality_evidence).

fact(integer_gt_one(341)).
fact(has_factor(341, 11, 31)).
fact(congruent_mod(2^340, 1, 341)).

claim(probable_prime_base(341, 2), empirical).

question(is_composite(341)).
question(probable_prime_base(341, 2)).

rule(r_composite_from_factor,
    [has_factor(N, A, B)],
    is_composite(N),
    logically_derived,
    [where(A > 1), where(B > 1)]).

rule(r_probable_prime_from_congruence,
    [congruent_mod(2^340, 1, 341)],
    probable_prime_base(341, 2),
    empirical).

dependency(is_composite(341), has_factor(341, 11, 31)).
dependency(probable_prime_base(341, 2), congruent_mod(2^340, 1, 341)).
negative_constraint(probable_prime_base(341, 2), proven_prime(341)).
