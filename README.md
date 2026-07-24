# fermatmnn

Fermat-oriented **Manual Neuronet (MNN)** prototype in SWI-Prolog.

The implementation lives in `mnn/` and includes:

- transparent symbolic knowledge representation;
- provenance-aware reasoning and trace export;
- deterministic choice packets and dependency analysis;
- bounded algorithm synthesis, research classification, verification, and scheduling;
- number-theory domain examples (including Fermat-test caveats);
- plunit regression suite and benchmark harness.

## Feature showcase (example commands)

Run from the repository root directory.

### Start interactive REPL

```sh
swipl
?- use_module('mnn/mnn.pl').
?- mnn.
```

### Load a domain and ask symbolic queries

```sh
swipl -q -g "use_module('mnn/mnn.pl'), load_domain(number_theory), ask(is_composite(341), Result), writeln(Result), halt"
```

### Generate provenance trace and DOT graph output

```sh
swipl -q -g "use_module('mnn/mnn.pl'), use_module('mnn/src/mnn_trace.pl'), load_domain(number_theory), ask(is_composite(341), Result), mnn_trace:trace_from_result(is_composite(341), Result, Trace), mnn_trace:trace_graph(Trace, Dot), writeln(Dot), halt"
```

### Inspect dependency closure for a derived claim

```sh
swipl -q -g "use_module('mnn/src/mnn_storage.pl'), use_module('mnn/src/mnn_domain.pl'), use_module('mnn/src/mnn_dependencies.pl'), mnn_storage:reset_storage, mnn_domain:load_domain(number_theory), mnn_dependencies:necessary_for(is_composite(341), Needed), writeln(Needed), halt"
```

### Use deterministic choice packets

```sh
swipl -q -g "use_module('mnn/src/mnn_choice.pl'), mnn_choice:splice([cp([a,b]), cp([1,2])], Results), writeln(Results), halt"
```

### Run bounded synthesis and research classification

```sh
swipl -q -g "use_module('mnn/mnn.pl'), load_domain(list_algorithms), synthesise(double_list, Synth), writeln(Synth), research(fermat_test(341), Research), writeln(Research), halt"
```

### Run bounded verification helpers

```sh
swipl -q -g "use_module('mnn/src/mnn_verify.pl'), assertz((user:bounded_id(N,N))), assertz((user:non_negative(N) :- N>=0)), mnn_verify:bounded_check(user:bounded_id, user:non_negative, 5, Status), writeln(Status), halt"
```

### Build sequential schedules from dependencies

```sh
swipl -q -g "use_module('mnn/src/mnn_scheduler.pl'), Tasks=[task(a,[],purity(pure),true),task(b,[a],purity(pure),true),task(c,[b],purity(pure),true)], mnn_scheduler:sequential_schedule(Tasks, Results), writeln(Results), halt"
```

### Run full test suite

```sh
swipl -q -s mnn/test/run_tests.pl -g main,halt
```

### Run benchmarks

```sh
swipl -q -g "use_module('mnn/mnn.pl'), run_benchmarks(Result), writeln(Result), halt"
```

See `mnn/README.md` for additional usage details.
