:- module(mnn_knowledge, [
    valid_domain_term/1,
    add_domain_term/2
]).

:- use_module(mnn_storage).

valid_domain_term(domain(_)).
valid_domain_term(concept(_)).
valid_domain_term(fact(_)).
valid_domain_term(claim(_, _)).
valid_domain_term(question(_)).
valid_domain_term(hotlist(_, _)).
valid_domain_term(bridge(_, _)).
valid_domain_term(rule(_, _, _, _)).
valid_domain_term(rule(_, _, _, _, _)).
valid_domain_term(dependency(_, _)).
valid_domain_term(negative_constraint(_, _)).
valid_domain_term(example(_, _, _)).
valid_domain_term(task(_, _, _, _)).

add_domain_term(_Domain, domain(_)) :- !.
add_domain_term(Domain, concept(Concept)) :-
    assertz(mnn_storage:stored_concept(Domain, Concept)).
add_domain_term(Domain, fact(Fact)) :-
    assertz(mnn_storage:stored_fact(Domain, Fact)).
add_domain_term(Domain, claim(Claim, Status)) :-
    assertz(mnn_storage:stored_claim(Domain, Claim, Status)).
add_domain_term(Domain, question(Question)) :-
    assertz(mnn_storage:stored_question(Domain, Question)).
add_domain_term(Domain, hotlist(Name, Question)) :-
    assertz(mnn_storage:stored_hotlist(Domain, Name, Question)).
add_domain_term(Domain, bridge(From, To)) :-
    assertz(mnn_storage:stored_bridge(Domain, From, To)).
add_domain_term(Domain, rule(Id, Conditions, Conclusion, Status)) :-
    assertz(mnn_storage:stored_rule(Domain, Id, Conditions, Conclusion, Status, [])).
add_domain_term(Domain, rule(Id, Conditions, Conclusion, Status, Metadata)) :-
    assertz(mnn_storage:stored_rule(Domain, Id, Conditions, Conclusion, Status, Metadata)).
add_domain_term(Domain, dependency(Target, Needs)) :-
    assertz(mnn_storage:stored_dependency(Domain, Target, Needs)).
add_domain_term(Domain, negative_constraint(Target, Blocker)) :-
    assertz(mnn_storage:stored_negative_constraint(Domain, Target, Blocker)).
add_domain_term(Domain, example(Kind, Name, Data)) :-
    assertz(mnn_storage:stored_example(Domain, Kind, Name, Data)).
add_domain_term(Domain, task(TaskName, Deps, Purity, Goal)) :-
    assertz(mnn_storage:stored_task(Domain, TaskName, Deps, Purity, Goal)).
