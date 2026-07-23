:- module(mnn_domain, [
    load_domain/1,
    unload_domain/1,
    list_loaded_domains/1
]).

:- use_module(mnn_storage).
:- use_module(mnn_knowledge).

load_domain(Domain) :-
    atom(Domain),
    mnn_storage:clear_domain(Domain),
    domain_file_path(Domain, Path),
    read_domain_terms(Path, Terms),
    must_include_domain_declaration(Domain, Terms),
    validate_terms(Terms),
    maplist(mnn_knowledge:add_domain_term(Domain), Terms),
    mnn_storage:set_loaded_domain(Domain).

unload_domain(Domain) :-
    mnn_storage:clear_domain(Domain).

list_loaded_domains(Domains) :-
    findall(D, mnn_storage:loaded_domain(D), Domains).

domain_file_path(Domain, Path) :-
    atom_concat(Domain, '.pl', File),
    directory_file_path('mnn/domains', File, Relative),
    absolute_file_name(Relative, Path, [access(read), file_errors(fail)]).

read_domain_terms(Path, Terms) :-
    setup_call_cleanup(
        open(Path, read, Stream),
        stream_terms(Stream, Terms),
        close(Stream)
    ).

stream_terms(Stream, Terms) :-
    read_term(Stream, Term, []),
    ( Term == end_of_file ->
        Terms = []
    ; Terms = [Term|Rest],
      stream_terms(Stream, Rest)
    ).

must_include_domain_declaration(Domain, Terms) :-
    memberchk(domain(Domain), Terms).

validate_terms([]).
validate_terms([Term|Rest]) :-
    ( mnn_knowledge:valid_domain_term(Term) ->
        true
    ; throw(error(invalid_domain_term(Term), _))
    ),
    validate_terms(Rest).
