:- module(mnn_optimiser, [
    analyse_clause/2
]).

analyse_clause((Head :- Body), report{
    head: Head,
    goals: Goals,
    repeated_goals: Repeated,
    common_prefix: Prefix,
    memoisation_suggestion: Memo
}) :-
    body_goals(Body, Goals),
    repeated(Goals, Repeated),
    prefix(Goals, Prefix),
    memo_suggestion(Head, Memo).
analyse_clause(Fact, report{
    head: Fact,
    goals: [],
    repeated_goals: [],
    common_prefix: [],
    memoisation_suggestion: none
}) :-
    Fact \= (_ :- _).

body_goals((A, B), Goals) :-
    !,
    body_goals(A, Left),
    body_goals(B, Right),
    append(Left, Right, Goals).
body_goals(true, []) :- !.
body_goals(Goal, [Goal]).

repeated(Goals, Repeated) :-
    findall(G, (append(_, [G|Tail], Goals), memberchk(G, Tail)), Repeated0),
    sort(Repeated0, Repeated).

prefix([A, A|_], [A]) :- !.
prefix(_, []).

memo_suggestion(Head, suggested) :-
    functor(Head, _, Arity),
    Arity > 1,
    !.
memo_suggestion(_, none).
