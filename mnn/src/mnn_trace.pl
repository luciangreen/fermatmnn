:- module(mnn_trace, [
    trace_from_result/3,
    trace_text/2,
    trace_graph/2
]).

trace_from_result(Query, Result, trace{
    query: Query,
    status: Result.status,
    support_facts: Result.support_facts,
    support_rules: Result.support_rules
}).

trace_text(Trace, Text) :-
    format(string(Text),
        "Query: ~q~nStatus: ~w~nFacts: ~q~nRules: ~q~n",
        [Trace.query, Trace.status, Trace.support_facts, Trace.support_rules]).

trace_graph(Trace, Dot) :-
    maplist(fact_edge, Trace.support_facts, FactEdges),
    maplist(rule_edge, Trace.support_rules, RuleEdges),
    append(FactEdges, RuleEdges, Edges),
    atomic_list_concat(Edges, '\n', EdgeText),
    format(string(Dot), "digraph trace {~n~s~n}", [EdgeText]).

fact_edge(Fact, Edge) :-
    format(string(Edge), "\"~q\" -> \"~q\";", [Fact, conclusion]).

rule_edge(Rule, Edge) :-
    format(string(Edge), "\"~q\" -> \"~q\";", [Rule, conclusion]).
