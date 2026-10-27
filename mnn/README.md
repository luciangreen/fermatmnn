# MNN (Manual Neuronet)

MNN is a transparent symbolic reasoning and bounded algorithm-synthesis system
implemented in SWI-Prolog. It favors explicit data, inspectable results, and
small reproducible workflows over unrestricted theorem proving.

## Requirements and setup

Install SWI-Prolog 9.x. Run commands below from the repository root; no package
installation is needed. The public API is in `mnn/mnn.pl`.

## Features

- **Domains and knowledge:** Load Prolog domain files containing concepts,
  facts, claims, questions, rules, dependencies, constraints, examples, and
  tasks. See [DOMAIN_FORMAT.md](DOMAIN_FORMAT.md) and [RULE_FORMAT.md](RULE_FORMAT.md).
- **Reasoning:** `ask/2` returns truth classification, status, supporting facts,
  and supporting rule IDs. Reasoning follows explicit rules and facts; it does
  not execute arbitrary rule metadata as code.
- **Provenance:** `explain/2` returns a trace summary. `mnn_trace.pl` can render
  a trace as DOT for graph visualization.
- **Dependency analysis:** `necessary_for/2` reports the explicit dependency
  closure for a target.
- **Choice packets:** `mnn_choice.pl` provides deterministic choice packet
  operations, including Cartesian splicing.
- **Synthesis:** `synthesise/2` produces bounded list-recursion or lookup
  candidates and checks them against domain examples.
- **Optimization analysis:** `mnn_optimiser:analyse_clause/2` reports repeated
  goals, a repeated leading goal, and a memoisation suggestion. It reports
  patterns; it does not rewrite program clauses.
- **Scheduling:** `mnn_scheduler.pl` creates dependency-ordered sequential
  schedules and permits parallel scheduling only for pure tasks.
- **Research classification:** `research/2` classifies bounded candidates,
  including the composite/pseudoprime behavior demonstrated in the examples.
- **Verification:** `mnn_verify.pl` supports example checks, checks over a
  finite bound, and comparisons against a reference predicate.
- **Benchmarks:** `run_benchmarks/1` returns SWI-Prolog/CPU metadata and
  per-case CPU and inference measurements for modular exponentiation, GCD,
  factor search, list doubling, and list reversal.
- **Interactive REPL:** supports `help.`, `load_domain(Name).`,
  `unload_domain(Name).`, `ask(Query).`, `explain(Query).`,
  `research(Query).`, `synthesise(Name).`, and `quit.`. See [REPL.md](REPL.md).

Example domains include core facts, list algorithms, scheduling, and number
theory. The number-theory examples distinguish compositeness evidence from
passing a selected Fermat test; a Fermat test alone is not proof of primality.

## Running examples

Load a domain and ask a question:

```sh
swipl -q -g "use_module('mnn/mnn.pl'), load_domain(number_theory), ask(is_composite(341), Result), writeln(Result), halt"
```

Inspect the synthesis and research workflows:

```sh
swipl -q -g "use_module('mnn/mnn.pl'), load_domain(list_algorithms), synthesise(double_list, Synth), writeln(Synth), research(fermat_test(341), Research), writeln(Research), halt"
```

Print a provenance graph in DOT format:

```sh
swipl -q -g "use_module('mnn/mnn.pl'), use_module('mnn/src/mnn_trace.pl'), load_domain(number_theory), ask(is_composite(341), Result), mnn_trace:trace_from_result(is_composite(341), Result, Trace), mnn_trace:trace_graph(Trace, Dot), writeln(Dot), halt"
```

Run the optimiser analysis on a sample clause:

```sh
swipl -q -g "use_module('mnn/src/mnn_optimiser.pl'), mnn_optimiser:analyse_clause((p(X) :- q(X), q(X), r(X)), Report), writeln(Report), halt"
```

## Tests and benchmarks

Run the complete plunit suite from the repository root:

```sh
swipl -q -s mnn/test/run_tests.pl -g main,halt
```

The suite covers `domain`, `rules`, `reasoner`, `trace`, `dependencies`,
`choice`, `synthesis`, `optimiser`, `scheduler`, `research`, `verify`,
`repl`, `benchmark`, and integration workflows. Run an individual suite, for
example:

```sh
swipl -q -g "consult('mnn/test/test_benchmark.pl'), run_tests(benchmark), halt"
```

Run all benchmark cases and print the measurements:

```sh
swipl -q -g "use_module('mnn/mnn.pl'), run_benchmarks(Result), writeln(Result), halt"
```

Benchmark measurements are machine-specific; the harness reports results and
does not claim a universal speedup. See [BENCHMARKS.md](BENCHMARKS.md) for
details.

## Current limitations and next work

Reasoning and synthesis deliberately support bounded, explicit patterns.
Broader theorem-search strategies, more advanced semantics-preserving optimizer
transformations, and a larger benchmark corpus remain future work. See
[docs/IMPLEMENTATION_PROGRESS.md](docs/IMPLEMENTATION_PROGRESS.md) for the
current implementation status.
