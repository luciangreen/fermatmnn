:- begin_tests(rules).

:- use_module('../src/mnn_rules').

test(valid_rule_basic) :-
    mnn_rules:valid_rule(rule(r1, [a], b, logically_derived)).

test(valid_rule_with_metadata) :-
    mnn_rules:valid_rule(rule(r2, [a], b, empirical, [note(ok)])).

test(invalid_rule, [fail]) :-
    mnn_rules:valid_rule(rule(r_bad, a, b, logically_derived)).

:- end_tests(rules).
