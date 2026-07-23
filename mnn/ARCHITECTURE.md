# Architecture

MNN is organized around explicit, inspectable modules:

- `mnn.pl` entry API and REPL startup.
- `src/mnn_domain.pl` file-based domain loading and validation.
- `src/mnn_storage.pl` typed knowledge storage.
- `src/mnn_reasoner.pl` rule-driven reasoning and status output.
- `src/mnn_trace.pl` provenance summary and graph export.
- `src/mnn_dependencies.pl` dependency graph analysis.
- `src/mnn_choice.pl` deterministic choice packets and splicing.
- `src/mnn_synthesis.pl` bounded algorithm synthesis.
- `src/mnn_optimiser.pl` supported clause analysis.
- `src/mnn_scheduler.pl` dependency-aware sequential/parallel scheduling.
- `src/mnn_research.pl` bounded research-candidate generation and labelling.
- `src/mnn_verify.pl` example, bounded, and reference checks.
- `src/mnn_benchmark.pl` benchmark execution/reporting.

Data flow: domain files are parsed into storage, reasoner consumes storage, and trace/dependency/scheduler/research/synthesis modules consume explicit stored structures.
