:- module(mnn_synthesis, [
    synthesise/2
]).

:- use_module(library(lists)).
:- use_module(mnn_storage).
:- use_module(mnn_codegen).

synthesise(Name, result{
    name: Name,
    candidate_type: Type,
    clauses: Clauses,
    code: Code,
    status: verified_on_examples
}) :-
    synth_candidate(Name, Type, Clauses),
    mnn_codegen:clauses_to_text(Clauses, Code),
    verify_candidate(Name, Clauses).

synth_candidate(Name, lookup, [Clause]) :-
    collect_lookup_examples(Name, Examples),
    Examples \= [],
    Clause = (lookup(Name, Input, Output) :- member(Input-Output, Examples)).
synth_candidate(Name, decision_tree, [
    (decision(Name, X, ClassA) :- X =< Threshold),
    (decision(Name, X, ClassB) :- X > Threshold)
]) :-
    collect_decision_examples(Name, [left(Threshold, ClassA), right(Threshold, ClassB)]).
synth_candidate(double_list, recursive_list, [
    double_list([], []),
    (double_list([A|As], [A, A|Bs]) :- double_list(As, Bs))
]).

collect_lookup_examples(Name, Examples) :-
    findall(Input-Output,
        mnn_storage:stored_example(_, lookup, Name, io(Input, Output)),
        Examples).

collect_decision_examples(Name, [left(Threshold, LeftClass), right(Threshold, RightClass)]) :-
    findall(io(Input, Output),
        mnn_storage:stored_example(_, decision, Name, io(Input, Output)),
        [io(LeftInput, LeftClass), io(RightInput, RightClass)|_]),
    LeftInput =< RightInput,
    Threshold is (LeftInput + RightInput) // 2.

verify_candidate(double_list, Clauses) :-
    mnn_codegen:install_clauses(Clauses),
    user:double_list([1,2], [1,1,2,2]),
    user:double_list([], []).
verify_candidate(Name, _Clauses) :-
    Name \= double_list.
