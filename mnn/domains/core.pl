domain(core).

concept(reasoning).
concept(status).

fact(system(mnn)).
fact(supports(transparency)).

claim(first_release(scope_symbolic), proven).

question(system(mnn)).
question(supports(transparency)).

hotlist(initial, system(mnn)).
bridge(system, reasoning).

rule(r_core_support, [system(mnn)], supports(transparency), logically_derived).

dependency(supports(transparency), system(mnn)).
