:- module(mnn_choice, [
    cp/1,
    valid_packet/1,
    splice/2,
    splice_stream/2,
    product_size/2
]).

cp(Values) :-
    valid_packet(cp(Values)).

valid_packet(cp(Values)) :-
    is_list(Values),
    Values \= [].

splice(Items, Results) :-
    findall(Combo, splice_stream(Items, Combo), Results).

splice_stream([], []).
splice_stream([cp(Choices)|Rest], [Choice|Tail]) :-
    valid_packet(cp(Choices)),
    member(Choice, Choices),
    splice_stream(Rest, Tail).
splice_stream([Fixed|Rest], [Fixed|Tail]) :-
    Fixed \= cp(_),
    splice_stream(Rest, Tail).

product_size(Items, Size) :-
    foldl(product_multiplier, Items, 1, Size).

product_multiplier(cp(Choices), Acc, Next) :-
    is_list(Choices),
    length(Choices, Count),
    Next is Acc * Count.
product_multiplier(Value, Acc, Acc) :-
    Value \= cp(_).
