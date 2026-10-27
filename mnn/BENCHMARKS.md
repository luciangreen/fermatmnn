# Benchmarks

Benchmarks are executed by `src/mnn_benchmark.pl` and report:

- Environment metadata (SWI-Prolog version and CPU count).
- Per-case CPU time and inference count.
- Modular exponentiation at two workloads, Euclidean GCD, trial factor search,
  list doubling, and list reversal.

The workloads are deterministic and report measurements only. They are not
used to claim a speedup or to compare different machines.

Reproduce:

```sh
swipl -q -g "use_module('mnn/mnn.pl'), run_benchmarks(Result), writeln(Result), halt"
```

The report is a dict with `environment` and `results` fields. Each result
contains a workload `name`, CPU time in seconds, and inference count.

The benchmark harness reports measured cases without claiming universal speedup.
