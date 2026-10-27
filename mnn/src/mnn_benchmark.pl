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
    case(modexp_large, (powm(7, 4096, 65537, _))),
    case(gcd_euclid, (gcd_euclid(1234567890, 987654321, _))),
    case(factor_trial, (smallest_factor(341, _))),
    case(list_double_100, (numlist(1, 100, Input100), double_list_ref(Input100, _))),
    case(list_reverse_1000, (numlist(1, 1000, Input1000), reverse(Input1000, _)))
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

powm(Base, Exp, Mod, Result) :-
    integer(Base),
    integer(Exp),
    Exp >= 0,
    integer(Mod),
    Mod > 0,
    Base0 is Base mod Mod,
    powm_acc(Base0, Exp, Mod, 1, Result).

powm_acc(_, 0, Mod, Acc, Result) :-
    Result is Acc mod Mod,
    !.
powm_acc(Base, Exp, Mod, Acc, Result) :-
    ( Exp mod 2 =:= 1 ->
        Acc1 is (Acc * Base) mod Mod
    ; Acc1 = Acc
    ),
    Base1 is (Base * Base) mod Mod,
    Exp1 is Exp // 2,
    powm_acc(Base1, Exp1, Mod, Acc1, Result).

gcd_euclid(A, B, Gcd) :-
    A0 is abs(A),
    B0 is abs(B),
    gcd_euclid_nonnegative(A0, B0, Gcd).

gcd_euclid_nonnegative(A, 0, A) :- !.
gcd_euclid_nonnegative(A, B, Gcd) :-
    Remainder is A mod B,
    gcd_euclid_nonnegative(B, Remainder, Gcd).

smallest_factor(Number, Factor) :-
    Number > 1,
    smallest_factor_from(Number, 2, Factor).

smallest_factor_from(Number, Candidate, Candidate) :-
    Number mod Candidate =:= 0,
    !.
smallest_factor_from(Number, Candidate, Factor) :-
    Candidate * Candidate < Number,
    !,
    Next is Candidate + 1,
    smallest_factor_from(Number, Next, Factor).
smallest_factor_from(Number, _, Number).

double_list_ref([], []).
double_list_ref([A|As], [A, A|Bs]) :-
    double_list_ref(As, Bs).
