# SOX Documentation Benchmark (Summary)

> Full research at: `research/sox-documentation-benchmark.md` (649 lines, compiled 2026-03-13)

## The Standard We Hold

**PCAOB AS 1215 "Experienced Auditor" Test:**
Documentation must be sufficient for an experienced auditor, having no previous connection with the engagement, to understand:
- The nature, timing, and extent of procedures performed
- The evidence obtained
- The conclusions reached

## The 10 Translatable Principles

1. **Contemporaneous Recording** -- Document as the work happens, not after
2. **Sufficient Detail for Independent Reproduction** -- The "experienced auditor" standard
3. **Evidence Over Assertion** -- Show the check, not just claim it happened
4. **Unbroken Chain of Custody** -- Every handoff documented, no gaps
5. **Immutability with Transparency** -- Never silently alter records; corrections are appended
6. **Segregation of Responsibilities** -- Producer should not be sole validator
7. **Exception Documentation is Non-Negotiable** -- Bypasses increase the documentation burden
8. **Continuous Monitoring Over Periodic Testing** -- Ongoing, not just annual
9. **Deficiency Tracking and Remediation** -- Document it, fix it, verify the fix, document the verification
10. **Documentation IS the Control** -- No documentation = no control = it didn't happen

## The Five W's + H (Per Auditable Action)

| Dimension | What to Record |
|-----------|---------------|
| **WHO** | Identity, role, authorization level |
| **WHAT** | Specific action, data/records affected |
| **WHEN** | Timestamp with timezone |
| **WHERE** | System, environment, location |
| **WHY** | Business justification |
| **HOW** | Method, tool, process used |

## Chain of Custody Stages

| Stage | Required Documentation |
|-------|----------------------|
| **Collection** | Source, method, completeness check, timestamp, collector |
| **Transformation** | Input state, logic applied, output state, validation, transformer |
| **Analysis** | Method, assumptions, data quality, analyst, intermediate results |
| **Conclusion** | Final output, derivation, confidence, alternatives, reviewer |
| **Handoff** | Method, recipient, integrity check, acceptance |

## SOX-to-Agent Translation Table

| SOX Concept | Agent Equivalent |
|-------------|----------------|
| Financial transaction | Any discrete agent action |
| Internal control | Validation step, quality check |
| CEO/CFO certification | Human review/approval of agent output |
| Audit workpapers | Session logs, reasoning traces, tool call records |
| Segregation of duties | Human-in-the-loop, separate validation agent |
| Material misstatement | Incorrect output affecting downstream work |
| Change management | Modification to prompts, tools, workflows, configs |
| WORM storage | Append-only logs, git commits (immutable SHA) |
| Exception documentation | When agent deviates from expected behavior |
