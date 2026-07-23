# Rule Format

Rules are declared as:

- `rule(Id, Conditions, Conclusion, Status).`
- `rule(Id, Conditions, Conclusion, Status, Metadata).`

Where:

- `Id` identifies the rule.
- `Conditions` is a list of prerequisite goals.
- `Conclusion` is the derived goal.
- `Status` is an epistemic label (for example `logically_derived`, `empirical`).
- `Metadata` is a list of auxiliary annotations.

Conflicts are represented at answer time when both `Q` and `not(Q)` are derivable.
