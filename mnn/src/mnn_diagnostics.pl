:- module(mnn_diagnostics, [
    format_result/2
]).

format_result(Result, Text) :-
    format(string(Text), "~q", [Result]).
