:- module(mnn_storage, [
    reset_storage/0,
    clear_domain/1,
    loaded_domain/1,
    set_loaded_domain/1,
    stored_concept/2,
    stored_fact/2,
    stored_claim/3,
    stored_question/2,
    stored_hotlist/3,
    stored_bridge/3,
    stored_rule/6,
    stored_dependency/3,
    stored_negative_constraint/3,
    stored_example/4,
    stored_task/5
]).

:- dynamic loaded_domain/1.
:- dynamic stored_concept/2.
:- dynamic stored_fact/2.
:- dynamic stored_claim/3.
:- dynamic stored_question/2.
:- dynamic stored_hotlist/3.
:- dynamic stored_bridge/3.
:- dynamic stored_rule/6.
:- dynamic stored_dependency/3.
:- dynamic stored_negative_constraint/3.
:- dynamic stored_example/4.
:- dynamic stored_task/5.

reset_storage :-
    retractall(loaded_domain(_)),
    retractall(stored_concept(_, _)),
    retractall(stored_fact(_, _)),
    retractall(stored_claim(_, _, _)),
    retractall(stored_question(_, _)),
    retractall(stored_hotlist(_, _, _)),
    retractall(stored_bridge(_, _, _)),
    retractall(stored_rule(_, _, _, _, _, _)),
    retractall(stored_dependency(_, _, _)),
    retractall(stored_negative_constraint(_, _, _)),
    retractall(stored_example(_, _, _, _)),
    retractall(stored_task(_, _, _, _, _)).

set_loaded_domain(Domain) :-
    ( loaded_domain(Domain) -> true ; assertz(loaded_domain(Domain)) ).

clear_domain(Domain) :-
    retractall(loaded_domain(Domain)),
    retractall(stored_concept(Domain, _)),
    retractall(stored_fact(Domain, _)),
    retractall(stored_claim(Domain, _, _)),
    retractall(stored_question(Domain, _)),
    retractall(stored_hotlist(Domain, _, _)),
    retractall(stored_bridge(Domain, _, _)),
    retractall(stored_rule(Domain, _, _, _, _, _)),
    retractall(stored_dependency(Domain, _, _)),
    retractall(stored_negative_constraint(Domain, _, _)),
    retractall(stored_example(Domain, _, _, _)),
    retractall(stored_task(Domain, _, _, _, _)).
