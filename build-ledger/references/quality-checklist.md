# Build Record Quality Checklist

Adapted from SOX Section 404 internal control requirements, PCAOB AS 1215, COSO framework, and documentation best practices from Toyota, NASA, and Google SRE.

**Usage:** Run this checklist against any completed Build Record. Target: 80%+ for Decision-grade, 90%+ for Audit-grade.

---

## Documentation Completeness (6 items)

- [ ] Every action has a timestamp, actor identity, and description
- [ ] Every decision records the rationale AND alternatives considered
- [ ] Every data transformation documents input state, logic applied, and output state
- [ ] Every exception/override has a justification and senior review
- [ ] Every handoff between systems/people has transfer documentation
- [ ] Every approval captures who, when, and on what basis

## Audit Trail Integrity (5 items)

- [ ] Records are append-only (no silent modifications to the Build Record)
- [ ] Corrections are documented with date, corrector, and reason
- [ ] File paths reference real, verifiable locations
- [ ] Git commit SHAs anchor the Build Record to immutable state
- [ ] Action timeline has no unexplained gaps

## Chain of Custody (5 items)

- [ ] Data lineage is traceable from source to final output
- [ ] Every transformation step is documented and reproducible
- [ ] No gaps exist in the custody chain
- [ ] Source systems and extraction methods are identified
- [ ] Original requirement text is preserved verbatim (not paraphrased)

## Requirements Coverage (4 items)

- [ ] Requirements traceability matrix exists
- [ ] Every original requirement maps to a deliverable or explicit gap explanation
- [ ] Anti-leak verification completed (compression check + signal words)
- [ ] Coverage percentage is calculated and reported

## Decision Quality (5 items)

- [ ] Every significant decision has the ADR Iron Law applied (rejected alternatives with reasons)
- [ ] Human vs. agent attribution is clear for each decision
- [ ] Confidence levels and assumptions are stated
- [ ] Risks accepted are documented
- [ ] Revisit conditions are specified for reversible decisions

## Readability and Usability (5 items)

- [ ] Executive summary is scannable in 30 seconds
- [ ] Build Record is under 500 lines for standard sessions
- [ ] Every section is self-contained (no "see above" references)
- [ ] Progressive summarization applied (summary -> detail hierarchy)
- [ ] JSONL version parses without errors (if dual-format)

---

## Scoring

**Total items:** 30 (some may be N/A depending on depth tier)

| Score | Grade | Interpretation |
|-------|-------|---------------|
| 27-30 (90%+) | A | Passes experienced auditor standard |
| 24-26 (80-89%) | B | Meets standard with minor gaps |
| 21-23 (70-79%) | C | Borderline -- remediate before archiving |
| 18-20 (60-69%) | D | Significant gaps -- must remediate |
| <18 (<60%) | F | Fails standard -- rebuild record |
