:- begin_tests(scheduler).

:- use_module('../src/mnn_scheduler').

test(sequential_ordering) :-
    Tasks = [
        task(a, [], purity(pure), true),
        task(b, [a], purity(pure), true),
        task(c, [b], purity(pure), true)
    ],
    mnn_scheduler:sequential_schedule(Tasks, Results),
    assertion(Results == [a-success,b-success,c-success]).

test(parallel_pure_tasks) :-
    Tasks = [
        task(a, [], purity(pure), true),
        task(b, [], purity(pure), true)
    ],
    mnn_scheduler:parallel_schedule(Tasks, 2, Results),
    assertion(member(a-success, Results)),
    assertion(member(b-success, Results)).

test(reject_effectful_parallel, [throws(error(permission_error(run, effectful_task, e), _))]) :-
    Tasks = [task(e, [], purity(effectful), true)],
    mnn_scheduler:parallel_schedule(Tasks, 1, _).

:- end_tests(scheduler).
