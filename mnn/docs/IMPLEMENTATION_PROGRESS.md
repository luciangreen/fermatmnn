# Implementation Progress

## Completed stages

Stages 1-12 are implemented as an integrated release baseline. The benchmark
harness has since been extended with six deterministic workloads and modular
exponentiation now uses a correct exponentiation-by-squaring implementation.

## Files changed

All core modules under `src/`, domain files under `domains/`, examples, benchmark harness, tests, and top-level documentation.

## Test coverage

Plunit suites for domain loading, rules, reasoning, tracing, dependencies, choice packets, synthesis, optimiser, scheduler, research, verification, benchmark shape, REPL flow, and integration scenarios.

Run the full suite from the repository root with:

```sh
swipl -q -s mnn/test/run_tests.pl -g main,halt
```

See `mnn/README.md` for feature descriptions, runnable examples, individual
suite commands, and benchmark invocation.

## Known limitations

- Reasoning and optimisation are intentionally bounded to explicit supported patterns.
- Synthesis is intentionally scoped to small deterministic candidates.

## Remaining work

- Broader theorem-search strategies, including richer control over search
  breadth and termination.
- Advanced, semantics-preserving optimizer transformations with explicit
  equivalence checks and counterexample retention.
- A larger benchmark corpus covering more representative MNN workloads.

## Benchmark status

Six deterministic workloads are available; measured time and inference counts
are machine-specific. Reproduce them with the command in `mnn/BENCHMARKS.md`.

## Next stage

Expand rule/search breadth and optimizer analysis/transformation support while
preserving deterministic, inspectable traces and non-claiming benchmark output.
