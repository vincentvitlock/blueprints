# Build Ledger Blueprint

SOX-grade audit trails for AI-assisted build sessions.

## What It Does

Build Ledger creates comprehensive, auditable documentation of every AI-assisted build session. It captures not just **what** happened, but **why** — the reasoning, alternatives considered, human decisions, and requirements traceability that traditional logs miss.

**Quality bar:** PCAOB AS 1215 "experienced auditor" standard — documentation sufficient for a qualified person with no prior connection to understand exactly what was done, why, what data was used, what decisions were made, what alternatives were considered, and what the final output was.

## Install as a Claude Code Skill

Copy the `build-ledger/` folder into your superpowers skills directory:

```bash
cp -r build-ledger ~/.claude/plugins/cache/claude-plugins-official/superpowers/<version>/skills/build-ledger
```

Replace `<version>` with the installed superpowers version (find it with `ls ~/.claude/plugins/cache/claude-plugins-official/superpowers/`).

## Usage

```
/build-ledger start              # Initialize a Build Record for this session
/build-ledger decision           # Log a significant decision with full context
/build-ledger gate               # Record a human approval/review/redirect gate
/build-ledger checkpoint         # Compile mid-session without ending
/build-ledger compile            # Finalize the Build Record
/build-ledger eval               # Run the "Fresh Eyes" quality eval
```

Force a depth tier:

```
/build-ledger start --tier audit
/build-ledger start --tier operational
```

## Depth Tiers

| Tier | Signal | Documentation Level |
|---|---|---|
| **Ephemeral** | Quick fix, single-line change | Skip — not used |
| **Operational** | Standard task, single-file change | Summary + actions timeline |
| **Decision-grade** | Multi-file changes, new features, architecture | Full Build Record + decision log |
| **Audit-grade** | Client work, compliance-sensitive, financial ops | + traceability matrix + context snapshots |
| **Regulatory** | Actual SOX/HIPAA/legal exposure | + integrity hashes + immutability verification |

## Three Pillars

### 1. Capture (Real-time)

The **Recorder Agent** (`agents/recorder-agent.md`) observes the session and writes structured entries to `/tmp/build-ledger/session-{timestamp}.jsonl`:

- **Decision entries** — what was chosen, why, alternatives rejected, who decided, confidence level
- **Action entries** — file writes/edits/commands with justification (why, not just what)
- **Human gate entries** — every approval, review, redirect, or override with actor identity
- **Context snapshots** — active files, instructions, and token state before major decisions

### 2. Compile (At Checkpoints)

At commits, session end, or manual invocation, all captured entries compile into a **Build Record** (`BR-YYYYMMDD-NNN.md` + `.jsonl`), saved to `bridge/build-records/`.

Build Record sections:
1. Executive Summary
2. Trigger (verbatim original requirement)
3. Plan (approach + rejected alternatives)
4. Actions Timeline (timestamped)
5. Decision Log
6. Human Gates
7. Requirements Traceability Matrix
8. Outcome
9. Next Actions

### 3. Certify (Quality Assurance)

The **Auditor Agent** (`agents/auditor-agent.md`) evaluates the Build Record on 4 dimensions:

| Dimension | Pass Threshold |
|---|---|
| Fresh Eyes (10 questions) | 16/20 (80%) |
| Completeness Checklist | 80%+ of applicable items |
| Machine Readability (JSONL) | All fields valid |
| Signal-to-Noise | Under 500 lines, key decisions findable in 2 min |

**Grading:** A (18-20 fresh eyes, 90%+ completeness) → F (<12, <60%)

## File Structure

```
build-ledger/
├── SKILL.md                          # Entry point — skill definition and commands
├── agents/
│   ├── recorder-agent.md             # Real-time capture agent
│   └── auditor-agent.md              # Post-compile quality evaluator
├── templates/
│   ├── build-record.md               # Full 9-section Build Record template
│   ├── decision-record.md            # Individual decision entry template
│   └── traceability-matrix.md        # Requirements-to-deliverables mapping
├── references/
│   ├── sox-benchmark.md              # SOX standards adapted for AI builds
│   ├── quality-checklist.md          # 25-item completeness checklist
│   └── depth-tiers.md                # When to use which tier
└── evals/
    └── eval-criteria.md              # All 5 eval definitions with scoring
```

## The 10 Governing Principles

1. **Documentation IS the control** — A well-executed process with no documentation is indistinguishable from one that never happened.
2. **Always document rejected alternatives** — An ADR without rejected alternatives is an announcement, not a decision record.
3. **Contemporaneous recording** — Document as work happens, not after the fact.
4. **Evidence over assertion** — "We checked this" is an assertion. "Here is the check, its inputs, outputs, and conclusion" is evidence.
5. **Match depth to stakes** — Not everything needs full SOX treatment.
6. **Embed in workflow, not beside it** — The Build Record is a byproduct of work, not a separate task.
7. **Checklists under 90 seconds** — Quality checks must be brief enough to actually get used.
8. **Self-contained sections** — Every section works in isolation. No "see above" references.
9. **Blameless and non-punitive** — Focus on "what about our system allowed this," not "who made this mistake."
10. **Close the feedback loop** — Every documented insight needs an owner and a follow-up check.

## Sources

Standards drawn from: SOX/PCAOB AS 1215, Architecture Decision Records (Michael Nygard), Toyota Production System, Military After-Action Reviews, Google SRE Postmortems, Atul Gawande's *The Checklist Manifesto*.
