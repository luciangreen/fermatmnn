# Domain Format

A domain file in `domains/*.pl` uses plain Prolog terms:

- `domain(Name).`
- `concept(Concept).`
- `fact(Fact).`
- `claim(Claim, Status).`
- `question(Question).`
- `hotlist(Name, Question).`
- `bridge(From, To).`
- `rule(Id, Conditions, Conclusion, Status).`
- `rule(Id, Conditions, Conclusion, Status, Metadata).`
- `dependency(Target, Needs).`
- `negative_constraint(Target, Blocker).`
- `example(Kind, Name, Data).`
- `task(TaskName, Dependencies, purity(pure|effectful), Goal).`

All terms are validated before they are inserted into runtime storage.
