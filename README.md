# Mixed-Effects Models & Variance Components (SAS)

Analysis of a **two-factor mixed model** (one fixed factor, one random factor) in SAS — estimating variance components by both REML and ML, building correct F-tests from expected mean squares, and testing a variance component with a likelihood-ratio test.

**Tools:** SAS (`PROC MIXED`, `PROC GLM`, `PROC SGPLOT`) · Mixed / Random-Effects Models · Experimental Design

---

## Overview
A study of production **efficiency** under a factorial design with **Factor A** (fixed, 3 levels) and **Factor B** (random, 4 levels), with replication. Because one factor is random, the analysis requires a mixed-model treatment: the correct error term for the fixed effect is the interaction mean square, and the random effect is summarized by its variance component rather than a fixed test.

## Key findings
- **Interaction is negligible** — Factor A × Factor B was not significant (F = 0.06, p = 0.999), supporting an additive model.
- **Both factors matter** — using the correct mixed-model error term (the interaction mean square), Factor A (F = 243.6, p < 0.0001) and Factor B (F = 165.1, p < 0.0001) were both highly significant. (Naively using the residual MS would have given very different, incorrect F-values — a key point of the analysis.)
- **Variance components (REML):** Factor B variance ≈ 3.90; the interaction component estimated at the boundary (≈ 0), consistent with the negligible interaction. Fixed effect of Factor A: F(2, 42) = 18.0, p < 0.0001 (Satterthwaite df).
- **Variance components (ML):** Factor B variance ≈ 2.85; Factor A: F(2, 44) = 18.9, p < 0.0001.
- **Likelihood-ratio test** for H₀: σ²_B = 0 by comparing −2 log-likelihoods of the full vs. reduced ML models (a boundary test, so the p-value is halved), plus confidence intervals for the variance components and Tukey comparisons of Factor A means.

## Methods
- Fixed-vs-random modeling with `PROC GLM ... RANDOM / TEST` (expected mean squares and correct F-tests)
- `PROC MIXED` variance-component estimation by **REML** and **ML** with Satterthwaite denominator degrees of freedom
- Likelihood-ratio test for a variance component (boundary-corrected) and CIs for variance components
- Tukey-adjusted comparisons of fixed-factor means
- Interaction plot via `PROC SGPLOT`

## Repository structure
```
mixed-effects-models-sas/
├── README.md
├── src/
│   └── mixed_effects_efficiency.sas   # original SAS program
└── results/
    └── output.pdf                     # full SAS output (tables + plots)
```

## How to run
Point the `INFILE` path in `src/mixed_effects_efficiency.sas` at the efficiency dataset (`Efficiency FactorA FactorB Replication`) and run in SAS 9.4+ / SAS OnDemand for Academics.

## Skills demonstrated
Mixed and random-effects models · variance-component estimation (REML & ML) · expected mean squares and correct F-test construction · likelihood-ratio testing of variance components · Satterthwaite approximation · multiple comparisons · SAS `PROC MIXED` and `PROC GLM`.

## Why it matters
Getting the error term right in a random/mixed design is exactly the kind of subtlety that separates a correct analysis from a plausible-looking wrong one — the same rigor needed for forecasting, risk, and experimental work in industry.
