:- module(mnn_benchmark, [
    run_benchmarks/1
]).

run_benchmarks(report{
    environment: Env,
    results: Results
}) :-
    current_prolog_flag(version_data, swi(Major, Minor, Patch, _)),
    current_prolog_flag(cpu_count, CpuCount),
    Env = environment{
        swi_version: version(Major, Minor, Patch),
        cpu_count: CpuCount
    },
    benchmark_cases(Cases),
    maplist(run_case, Cases, Results).

benchmark_cases([
    case(modexp_small, (powm(2, 1000, 341, _))),
    case(list_double, (double_list_ref([1,2,3,4], _)))
]).

run_case(case(Name, Goal), case_result{
    name: Name,
    cpu: Cpu,
    inferences: Inferences
}) :-
    statistics(inferences, I0),
    call_time(Goal, Time),
    statistics(inferences, I1),
    Cpu is Time.cpu,
    Inferences is I1 - I0.

powm(_, 0, Mod, 1 mod Mod) :- !.
powm(Base, Exp, Mod, Result) :-
    Exp > 0,
    E1 is Exp - 1,
    powm(Base, E1, Mod, Prev),
    Result is (Prev * Base) mod Mod.

double_list_ref([], []).
double_list_ref([A|As], [A, A|Bs]) :-
    double_list_ref(As, Bs).
