# Research Methods

MNN research mode produces bounded outputs with explicit labels:

- Correlation candidates (`candidate`).
- Pseudoprime behaviour findings (`pseudoprime_behaviour`).
- Candidate-status transitions via `classify_candidate/3` into `verified`, `empirical`, or `refuted`.

Outputs are never promoted to proven conclusions unless separately verified.
