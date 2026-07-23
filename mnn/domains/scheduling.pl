domain(scheduling).

concept(task_graph).

task(load_inputs, [], purity(pure), true).
task(run_reasoner, [load_inputs], purity(pure), true).
task(export_trace, [run_reasoner], purity(pure), true).

dependency(run_reasoner, load_inputs).
dependency(export_trace, run_reasoner).

negative_constraint(effectful_task, parallel_only).
