---
name: build-ledger
description: SOX-grade audit trails for AI-assisted builds. Automatically captures decisions, reasoning, human approvals, and requirements traceability during build sessions. Produces dual-format Build Records (Markdown + JSONL) that pass the PCAOB "experienced auditor" standard.
version: 1.0.0
---

# Build Ledger Skill

SOX-grade audit trails for AI-assisted builds.

## Purpose

This skill creates comprehensive, auditable documentation of every AI-assisted build session. It captures not just WHAT happened, but WHY -- the reasoning, alternatives considered, human decisions, and requirements traceability that traditional logs miss.

**The quality bar:** PCAOB AS 1215 "experienced auditor" standard -- documentation must be sufficient for a qualified person with no prior connection to understand exactly what was done, why it was done, what data was used, what decisions were made, what alternatives were considered, and what the final output was, without needing to ask anyone or re-run anything.

**Key benefits:**
- Zero tribal knowledge -- anyone can pick up where a session left off
- Requirements traceability -- every deliverable maps back to the original ask
- Decision quality tracking -- document reasoning, not just outcomes
- Dual-format output -- Markdown for humans, JSONL for agents
- Graduated depth -- auto-detects the right documentation tier
- Blueprint-ready -- transferable pattern for clients and students

---

## When to Use This Skill

**Invoke with:** `/build-ledger`

**Automatic triggers (via hooks):**
- Post-tool hook captures significant decisions as they happen
- Pre-commit hook compiles the Build Record at checkpoint time
- Session-end integration adds Build Record compilation step

**Manual invocation:**
- `/build-ledger start` -- Initialize a new Build Record for this session
- `/build-ledger decision` -- Log a significant decision with full context
- `/build-ledger gate` -- Record a human approval/review/redirect gate
- `/build-ledger checkpoint` -- Compile current Build Record without ending session
- `/build-ledger compile` -- Compile and finalize the Build Record
- `/build-ledger eval` -- Run the "Fresh Eyes" eval on the current Build Record

**Use when:**
- Starting any non-trivial build session (more than 50 lines of code or multi-file changes)
- Working on client deliverables or compliance-sensitive work
- Making architectural decisions that will affect future work
- Any time someone might later ask "why did we do it this way?"

**Do NOT use when:**
- Answering a quick question (no build happening)
- Trivial single-file fixes (typos, config tweaks)
- Research-only sessions with no deliverables

---

## The Three Pillars

### 1. CAPTURE (Real-time)

As you work, the skill captures structured entries for significant events:

**Decision entries** -- Every judgment call:
- What was being decided
- What was chosen and why
- What alternatives were considered and why they were rejected
- Who decided (human vs. agent)
- Confidence level and assumptions made

**Action entries** -- Significant operations:
- Timestamped description of what was done
- Target files/systems affected
- Method used (tool, API, manual)
- Justification (why this action, not just what)

**Human gate entries** -- Every human touchpoint:
- Type: approval, review, redirect, override, escalation
- Who (identity of the human)
- What they decided or directed
- Any conditions or modifications they specified

**Context snapshot entries** -- Before major decisions:
- What files/data the agent had access to at decision time
- Active instructions (CLAUDE.md, skills, memory)
- Token usage / context state

### 2. COMPILE (At Checkpoints)

At commits, session end, or manual invocation, the skill compiles all captured entries into a Build Record. The Build Record follows the template at `templates/build-record.md`.

**Build Record sections:**
1. Executive Summary (3-5 sentences, scannable in 30 seconds)
2. Trigger (what kicked this off, verbatim original requirement)
3. Plan (approach taken, alternatives considered and rejected)
4. Actions Timeline (timestamped significant actions)
5. Decision Log (every judgment call with full context)
6. Human Gates (every human review/approval point)
7. Requirements Traceability Matrix (requirement -> deliverable -> status -> evidence)
8. Outcome (what was delivered, what wasn't, why)
9. Next Actions (remaining work, owners)

**Output formats:**
- `BR-YYYYMMDD-NNN.md` -- Markdown for bridge system and human review
- `BR-YYYYMMDD-NNN.jsonl` -- JSONL for machine consumption and compliance tooling

**Output location:** `bridge/build-records/`

### 3. CERTIFY (Quality Assurance)

After compilation, an auditor subagent evaluates the Build Record quality using the eval criteria at `evals/eval-criteria.md`.

---

## Depth Tiers (Auto-Detection)

The skill auto-detects the appropriate documentation depth based on the work being done:

| Tier | Signal | Documentation Level |
|------|--------|-------------------|
| **Ephemeral** | Quick question, trivial fix, single-line change | Skip Build Record (normal session log suffices) |
| **Operational** | Standard task, single-file change, routine work | Lightweight Build Record: summary + actions timeline |
| **Decision-grade** | Multi-file changes, new skills/features, architecture decisions | Full Build Record with decision log and alternatives |
| **Audit-grade** | Client work, compliance-sensitive, financial operations | Full Build Record + traceability matrix + context snapshots |
| **Regulatory** | Actual SOX/HIPAA/legal exposure | Full SOX-level with retention controls and immutability verification |

**Override:** User can force a tier with `/build-ledger start --tier audit` or `/build-ledger start --tier operational`

---

## Integration Points

| System | Relationship |
|--------|-------------|
| **session-end skill** | Build Ledger EXTENDS session-end by adding Build Record compilation as a step |
| **Activity log hook** | Build Ledger CONSUMES activity log data as input for action timeline |
| **bridge/context/decisions.md** | Build Ledger EXTENDS the D-YYYYMMDD-NNN format with richer structure |
| **bridge/session-logs/learnings/** | Build Ledger FEEDS learnings extracted from decision outcomes |
| **Grand Central** | Build Ledger auto-creates review task for completed Build Records |
| **PUNCH_CARD_SPEC** | Build Ledger IS the fix for the requirements leak pattern |

---

## The 10 Governing Principles

These principles govern how the Build Ledger operates. They are drawn from SOX compliance standards, Architecture Decision Records, Toyota Production System, military After-Action Reviews, and Google SRE postmortems.

1. **Documentation IS the control** -- A well-executed process with no documentation is indistinguishable from a process that never happened. (SOX Principle 10)
2. **Always document rejected alternatives** -- An ADR without rejected alternatives is an announcement, not a decision record. The depth of rejection rationale must be proportional to how plausible the alternative was. (ADR Iron Law, Michael Nygard)
3. **Contemporaneous recording** -- Document as the work happens, not after the fact. Reconstructed documentation is inherently less reliable. (SOX / PCAOB)
4. **Evidence over assertion** -- "We checked this" is an assertion. "Here is the check, its inputs, outputs, and conclusion" is evidence. (SOX Principle 3)
5. **Match depth to stakes** -- Not everything needs full SOX treatment. Quick fixes get minimal docs. Client builds get full traceability. (5-tier spectrum)
6. **Embed in workflow, not beside it** -- Documentation that lives separately from work gets abandoned. The Build Record is produced as a byproduct of work, not as a separate task. (Stripe, Toyota)
7. **Checklists under 90 seconds** -- Quality checks must be brief enough to actually get used. (Atul Gawande, The Checklist Manifesto)
8. **Self-contained sections** -- Every section works in isolation. No "see above" references. Agents receiving chunks without surrounding context cannot resolve backward references. (Promptless.ai)
9. **Blameless and non-punitive** -- Focus on "what about our system allowed this" not "who made this mistake." Document failures with the same rigor as successes. (Google SRE)
10. **Close the feedback loop** -- Every documented insight needs an owner and a follow-up check. Documentation without review and application cycles is dead knowledge. (Military AARs, Google SRE)

---

## Agents

### Recorder Agent (`agents/recorder-agent.md`)
Runs during the build session. Monitors for significant events (decisions, human gates, exceptions) and captures structured entries. Lightweight -- designed to observe, not interfere with the build flow.

### Auditor Agent (`agents/auditor-agent.md`)
Runs after Build Record compilation. Evaluates the record against the "experienced auditor" standard using 5 eval dimensions. Returns a quality score and specific gaps to address.

---

## Templates

- `templates/build-record.md` -- The Build Record template with all 9 sections
- `templates/decision-record.md` -- Individual decision entry template
- `templates/traceability-matrix.md` -- Requirements-to-deliverables mapping template

---

## References

- `references/sox-benchmark.md` -- SOX documentation standards adapted for AI builds
- `references/quality-checklist.md` -- 25-item quality checklist for Build Record completeness
- `references/depth-tiers.md` -- Detailed guide on when to use which documentation tier

---

## Evals

- `evals/eval-criteria.md` -- All 5 eval definitions with scoring criteria and pass thresholds

---

## Quick Start

```
# Start a new Build Record for this session
/build-ledger start

# Log a significant decision
/build-ledger decision

# Record a human approval gate
/build-ledger gate

# Compile the Build Record at a checkpoint
/build-ledger checkpoint

# Run the quality eval
/build-ledger eval

# Compile and finalize
/build-ledger compile
```
