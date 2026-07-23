:- module(mnn_codegen, [
    clauses_to_text/2,
    install_clauses/1
]).

clauses_to_text(Clauses, Text) :-
    maplist(clause_line, Clauses, Lines),
    atomic_list_concat(Lines, '\n', Text).

clause_line((Head :- Body), Line) :-
    format(string(Line), "~q :- ~q.", [Head, Body]).
clause_line(Fact, Line) :-
    Fact \= (_ :- _),
    format(string(Line), "~q.", [Fact]).

install_clauses([]).
install_clauses([Clause|Rest]) :-
    assertz(user:Clause),
    install_clauses(Rest).
