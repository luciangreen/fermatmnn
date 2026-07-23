:- module(mnn_rules, [
    valid_rule/1
]).

valid_rule(rule(Id, Conditions, Conclusion, Status)) :-
    nonvar(Id),
    is_list(Conditions),
    nonvar(Conclusion),
    atom(Status).
valid_rule(rule(Id, Conditions, Conclusion, Status, Metadata)) :-
    valid_rule(rule(Id, Conditions, Conclusion, Status)),
    is_list(Metadata).
