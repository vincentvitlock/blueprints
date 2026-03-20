# Requirements Traceability Matrix

> **Build Record:** BR-YYYYMMDD-NNN
> **Original Source:** [Where the requirements came from -- voice memo, Slack, ticket, conversation]
> **Date:** YYYY-MM-DD

---

## Requirements Extraction

Original requirement text (verbatim):

> [Paste the full original request exactly as stated]

### Decomposed Requirements

| # | Requirement | Source Reference | Priority | Category |
|---|------------|-----------------|----------|----------|
| R1 | [Specific, testable requirement] | [Line/timestamp in source] | P0-P3 | Feature / Fix / Config / Doc |
| R2 | [Specific, testable requirement] | [Line/timestamp in source] | P0-P3 | Feature / Fix / Config / Doc |

---

## Traceability Map

| Req # | Requirement | Deliverable(s) | Status | Verification Method | Evidence |
|-------|------------|----------------|--------|-------------------|----------|
| R1 | [Requirement text] | [File path or artifact] | DONE | [How to verify: file exists / test passes / manual check] | [Link or command] |
| R2 | [Requirement text] | [File path or artifact] | PARTIAL | [What's done, what's missing] | [Link or command] |
| R3 | [Requirement text] | -- | NOT BUILT | -- | Reason: [why not addressed] |

---

## Coverage Summary

- **Total requirements:** N
- **Fully addressed:** X (Y%)
- **Partially addressed:** X (Y%)
- **Not addressed:** X (Y%)

### Gaps and Justifications

| Req # | Gap Description | Reason | Recommended Action |
|-------|----------------|--------|-------------------|
| R3 | [What's missing] | [Out of scope / Blocked / Deferred / Needs human input] | [What should happen next] |

---

## Anti-Leak Verification

<!-- This section directly addresses the lossy compression problem identified in LEAK_ANALYSIS_AND_PUNCH_CARD_SPEC.md -->

**Compression check:** Compare the number of distinct requirements in the original ask vs. the number tracked in this matrix.

- Original ask contained approximately **N** distinct requirements/expectations
- This matrix tracks **M** requirements
- **Delta:** [If M < N, explain what was compressed or lost and why]

**Signal words check:** Scan original requirement for signal words that often get dropped:
- Specific numbers/thresholds mentioned: [list]
- Named individuals or systems: [list]
- Time constraints or deadlines: [list]
- Quality standards or benchmarks: [list]
- Edge cases or exceptions mentioned: [list]

All signal words accounted for in the matrix: Yes / No (if no, explain)
