:- module(mnn_scheduler, [
    ready_tasks/3,
    sequential_schedule/2,
    parallel_schedule/3
]).

:- use_module(library(lists)).
:- use_module(library(thread)).

ready_tasks(Tasks, Completed, Ready) :-
    include(is_ready(Completed), Tasks, Ready).

is_ready(Completed, task(Name, Deps, _Purity, _Goal)) :-
    \+ memberchk(Name, Completed),
    subset_list(Deps, Completed).

subset_list([], _).
subset_list([H|T], Set) :-
    memberchk(H, Set),
    subset_list(T, Set).

sequential_schedule(Tasks, Results) :-
    sequential_schedule_loop(Tasks, [], [], Results).

sequential_schedule_loop(Tasks, Completed, Acc, Results) :-
    ready_tasks(Tasks, Completed, Ready),
    ( Ready = [] ->
        reverse(Acc, Results)
    ; Ready = [task(Name, _Deps, _Purity, Goal)|_],
      call(Goal),
      sequential_schedule_loop(Tasks, [Name|Completed], [Name-success|Acc], Results)
    ).

parallel_schedule(Tasks, Workers, Results) :-
    ( Workers > 0 -> true ; throw(error(domain_error(workers, Workers), _)) ),
    ensure_pure_tasks(Tasks),
    parallel_schedule_continue(Tasks, Workers, [], [], Results).

parallel_schedule_continue([], _Workers, _Completed, Acc, Results) :-
    Results = Acc.
parallel_schedule_continue(Tasks, Workers, Completed, Acc, Results) :-
    ready_tasks(Tasks, Completed, Ready),
    ( Ready = [] ->
        Results = Acc
    ; take(Workers, Ready, Batch),
      run_batch(Batch, BatchResults),
      extract_completed(BatchResults, NewlyCompleted),
      append(Completed, NewlyCompleted, NextCompleted),
      remaining_tasks(Tasks, NewlyCompleted, Remaining),
      append(Acc, BatchResults, NextAcc),
      parallel_schedule_continue(Remaining, Workers, NextCompleted, NextAcc, Results)
    ).

ensure_pure_tasks([]).
ensure_pure_tasks([task(Name, _Deps, purity(effectful), _Goal)|_]) :-
    throw(error(permission_error(run, effectful_task, Name), _)).
ensure_pure_tasks([_|Rest]) :-
    ensure_pure_tasks(Rest).

run_batch([], []).
run_batch([task(Name, _Deps, _Purity, Goal)|Rest], [Name-Status|Results]) :-
    run_task_threaded(Goal, Status),
    run_batch(Rest, Results).

run_task_threaded(Goal, success) :-
    thread_create(call(Goal), Id, []),
    thread_join(Id, true),
    !.
run_task_threaded(_Goal, failed).

extract_completed([], []).
extract_completed([Name-success|Rest], [Name|Completed]) :-
    !,
    extract_completed(Rest, Completed).
extract_completed([_|Rest], Completed) :-
    extract_completed(Rest, Completed).

remaining_tasks(Tasks, Completed, Remaining) :-
    exclude(completed_task(Completed), Tasks, Remaining).

completed_task(Completed, task(Name, _Deps, _Purity, _Goal)) :-
    memberchk(Name, Completed).

take(0, _List, []) :- !.
take(_, [], []) :- !.
take(N, [H|T], [H|Rest]) :-
    N1 is N - 1,
    take(N1, T, Rest).
