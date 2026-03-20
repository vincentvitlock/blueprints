# Build Ledger Eval Criteria

## Overview

Five evaluation dimensions for Build Record quality. The primary eval (Fresh Eyes) is the gate -- everything else is supplementary.

---

## Eval 1: Fresh Eyes Test (PRIMARY -- The Experienced Auditor Eval)

**Purpose:** Validate that the Build Record is self-sufficient for someone with zero context.

**Process:**
1. Spin up a fresh subagent with NO session context
2. Provide ONLY the Build Record (no CLAUDE.md, no memory, no session history)
3. Ask the subagent to answer 10 questions from the Build Record alone

**Questions:**
1. What was the original requirement or task?
2. What approach was taken and why was it chosen?
3. What alternatives were considered and why were they rejected?
4. What files were created or modified?
5. Which decisions were made by the human vs. the agent?
6. Were there any exceptions to normal process? If so, what justified them?
7. What is the current state of all deliverables?
8. What work remains to be done?
9. Can you trace each deliverable back to its original requirement?
10. What risks or known concerns exist?

**Scoring:**
- 0 = Cannot answer from the record (information is missing)
- 1 = Partial answer (some information present but incomplete)
- 2 = Complete answer (fully answerable from the record alone)

**Pass threshold:** 16/20 (80%)

**Grading:**
| Score | Grade | Meaning |
|-------|-------|---------|
| 18-20 | A | Exemplary -- passes with flying colors |
| 16-17 | B | Passes with minor gaps |
| 14-15 | C | Borderline -- needs remediation |
| 12-13 | D | Significant gaps -- must remediate |
| <12 | F | Fails -- rebuild the record |

---

## Eval 2: Completeness Checklist

**Purpose:** Automated structural check against the 30-item quality checklist.

**Process:** Walk through every item in `references/quality-checklist.md` and mark present/absent.

**Scoring:** Percentage of applicable items present. Items marked N/A (e.g., regulatory controls for Operational-tier records) are excluded from the denominator.

**Pass threshold:** 80% for Decision-grade, 90% for Audit-grade

---

## Eval 3: Machine Readability

**Purpose:** Verify the JSONL output is valid and parseable.

**Checks:**
- [ ] JSONL file parses without errors (every line is valid JSON)
- [ ] Every entry has required fields: `timestamp`, `entry_type`, `description`
- [ ] Timestamps are valid ISO 8601 with timezone offset
- [ ] File paths are absolute (start with `/`)
- [ ] `entry_type` is one of: `decision`, `action`, `human_gate`, `context_snapshot`, `metadata`
- [ ] Related entries share correlation IDs where applicable
- [ ] No duplicate entry IDs

**Scoring:** Pass/Fail (all checks must pass)

---

## Eval 4: Signal-to-Noise (Gawande Test)

**Purpose:** Ensure documentation is concise enough to actually get used.

**Named for:** Atul Gawande's insight that checklists over 9 items or 90 seconds get ignored. Documentation that's too long doesn't get read.

**Checks:**
- [ ] Build Record is under 500 lines (for standard sessions; scale for long sessions)
- [ ] Executive summary is under 100 words
- [ ] Key decisions are findable within 2 minutes of scanning
- [ ] No redundant or duplicate entries
- [ ] No boilerplate sections with zero content (remove empty sections rather than leave placeholders)
- [ ] Progressive summarization applied (executive summary -> section headers -> detail)

**Scoring:** Pass/Fail with notes

---

## Eval 5: A/B Comparison (Skills 2.0 Compatible)

**Purpose:** Validate that the Build Ledger skill actually improves documentation quality vs. baseline.

**Process:**
1. Run the same build task twice (use a standardized test task)
2. Run A: WITHOUT Build Ledger skill active (baseline Claude Code behavior)
3. Run B: WITH Build Ledger skill active
4. Give both sessions' outputs to a fresh "auditor" subagent
5. Run the Fresh Eyes Test on both
6. Compare scores

**Expected result:** Build Ledger version scores at least 4 points higher on the Fresh Eyes Test (20% improvement).

**When to run:** During skill development and after major skill updates. Not needed for every build session.

---

## Running Evals

### Quick Eval (Eval 1 only -- under 2 minutes)
```
/build-ledger eval
```
Runs the Fresh Eyes Test on the current Build Record and returns the score.

### Full Eval (All 5 dimensions)
```
/build-ledger eval --full
```
Runs all eval dimensions and produces a comprehensive quality report.

### A/B Eval (Skills 2.0 style)
```
/build-ledger eval --ab "test task description"
```
Runs the A/B comparison with the specified test task.
