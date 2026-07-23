:- module(mnn_reasoner, [
    ask/2,
    derive_all/1
]).

:- use_module(library(lists)).
:- use_module(mnn_storage).

ask(Query, result{
    query: Query,
    truth: Truth,
    status: Status,
    support_facts: Facts,
    support_rules: Rules
}) :-
    findall(Proof, prove(Query, [], Proof), Proofs0),
    list_to_set(Proofs0, Proofs),
    findall(NegProof, prove(not(Query), [], NegProof), NegProofs0),
    list_to_set(NegProofs0, NegProofs),
    classify_truth(Proofs, NegProofs, Truth, Status),
    collect_support(Proofs, Facts, Rules).

derive_all(Derived) :-
    findall(Conclusion,
        ( mnn_storage:stored_rule(_, _, Conditions, Conclusion, _, _),
          conditions_true(Conditions, [])
        ),
        All),
    sort(All, Derived).

classify_truth(Proofs, NegProofs, conflict, conflicting) :-
    Proofs \= [],
    NegProofs \= [],
    !.
classify_truth(Proofs, _NegProofs, true, logically_derived) :-
    Proofs \= [],
    !.
classify_truth(_Proofs, NegProofs, false, logically_derived) :-
    NegProofs \= [],
    !.
classify_truth(_, _, unknown, unknown).

collect_support(Proofs, Facts, Rules) :-
    findall(F, (member(proof(Fs, _), Proofs), member(F, Fs)), FactList),
    findall(R, (member(proof(_, Rs), Proofs), member(R, Rs)), RuleList),
    sort(FactList, Facts),
    sort(RuleList, Rules).

prove(Query, _Visited, proof([Query], [])) :-
    mnn_storage:stored_fact(_, Query).
prove(Query, _Visited, proof([Query], [])) :-
    mnn_storage:stored_claim(_, Query, proven).
prove(Query, Visited, proof(Facts, [RuleId|RuleIds])) :-
    \+ memberchk(Query, Visited),
    mnn_storage:stored_rule(_, RuleId, Conditions, Conclusion, _Status, _Meta),
    copy_term((Conclusion, Conditions), (ConclusionCopy, ConditionsCopy)),
    ConclusionCopy = Query,
    conditions_proofs(ConditionsCopy, [Query|Visited], ConditionProofs),
    append_condition_proofs(ConditionProofs, Facts, RuleIds).

conditions_true([], _Visited).
conditions_true([Condition|Rest], Visited) :-
    prove(Condition, Visited, _),
    conditions_true(Rest, Visited).

conditions_proofs([], _Visited, []).
conditions_proofs([Condition|Rest], Visited, [Proof|Proofs]) :-
    prove(Condition, Visited, Proof),
    conditions_proofs(Rest, Visited, Proofs).

append_condition_proofs(ConditionProofs, Facts, RuleIds) :-
    findall(Fact, (member(proof(Fs, _), ConditionProofs), member(Fact, Fs)), Facts0),
    findall(RuleId, (member(proof(_, Rs), ConditionProofs), member(RuleId, Rs)), Rules0),
    sort(Facts0, Facts),
    sort(Rules0, RuleIds).
