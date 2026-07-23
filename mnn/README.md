# MNN (Manual Neuronet)

MNN is a transparent symbolic reasoning and synthesis system implemented in SWI-Prolog.

## Installation

1. Install SWI-Prolog 9.x.
2. From this repository root, start SWI-Prolog in the `mnn/` directory.

## Starting the REPL

```prolog
?- use_module('../mnn').
?- mnn.
```

## Minimal example

```prolog
?- load_domain(number_theory).
?- ask(is_composite(341), Result).
?- explain(is_composite(341), Trace).
```

## Limitations

The first release supports bounded, explicit symbolic workflows and deliberately does not perform unrestricted theorem proving or natural-language reasoning.

## Test command

```sh
swipl -q -s mnn/test/run_tests.pl -g run_tests,halt
```

## Benchmark command

```sh
swipl -q -g "use_module('mnn/mnn.pl'), run_benchmarks(Result), writeln(Result), halt"
```
