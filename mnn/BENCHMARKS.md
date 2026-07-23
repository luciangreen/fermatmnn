# Benchmarks

Benchmarks are executed by `src/mnn_benchmark.pl` and report:

- Environment metadata (SWI-Prolog version and CPU count).
- Per-case CPU time and inferences.

Reproduce:

```sh
swipl -q -g "use_module('mnn/mnn.pl'), run_benchmarks(Result), writeln(Result), halt"
```

The benchmark harness reports measured cases without claiming universal speedup.
