:- module(mnn_dependencies, [
    dependency_graph/1,
    has_cycle/1,
    necessary_for/2
]).

:- use_module(library(lists)).
:- use_module(mnn_storage).

dependency_graph(Edges) :-
    findall(edge(Target, Needs),
        mnn_storage:stored_dependency(_, Target, Needs),
        Edges0),
    sort(Edges0, Edges).

has_cycle(Cycle) :-
    dependency_graph(Edges),
    member(edge(Start, _), Edges),
    path(Start, Start, Edges, [Start], Cycle),
    !.

necessary_for(Output, Necessary) :-
    necessary_closure([Output], [], Needed),
    sort(Needed, Necessary).

necessary_closure([], Acc, Acc).
necessary_closure([Node|Rest], Acc, Out) :-
    ( memberchk(Node, Acc) ->
        necessary_closure(Rest, Acc, Out)
    ; findall(Dep, mnn_storage:stored_dependency(_, Node, Dep), Deps0),
      append(Rest, Deps0, Next),
      necessary_closure(Next, [Node|Acc], Out)
    ).

path(Current, Target, Edges, Visited, [Current, Target]) :-
    member(edge(Current, Target), Edges),
    \+ memberchk(Target, Visited).
path(Current, Target, Edges, Visited, [Current|RestPath]) :-
    member(edge(Current, Next), Edges),
    \+ memberchk(Next, Visited),
    path(Next, Target, Edges, [Next|Visited], RestPath).
