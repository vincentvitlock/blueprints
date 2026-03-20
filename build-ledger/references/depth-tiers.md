# Build Ledger Depth Tiers

## Overview

Not every build needs SOX-level documentation. The Build Ledger uses a 5-tier depth spectrum that auto-detects the appropriate documentation level based on the work being done. Users can override the auto-detection at any time.

---

## Tier 1: Ephemeral

**Signal:** Quick question, trivial fix, single-line change, research-only session
**Documentation:** None from Build Ledger (normal session log suffices)
**Auto-detect triggers:**
- Session involves fewer than 3 file modifications
- No multi-step decisions made
- No human gates occurred
- Session duration under 15 minutes

**Examples:**
- "What's the Slack channel ID for DocGen?"
- Fix a typo in a README
- Look up a config value

---

## Tier 2: Operational

**Signal:** Standard task, single-file or few-file changes, routine work
**Documentation:** Lightweight Build Record
- Executive Summary
- Actions Timeline
- Outcome
- Next Actions

**Skipped sections:** Plan alternatives, Decision Log (unless non-trivial decisions made), Traceability Matrix, Context Snapshots
**Auto-detect triggers:**
- 3-10 file modifications
- No architecture or design decisions
- Straightforward implementation of clear requirements
- Single-domain work (one system, one repo)

**Examples:**
- Update a skill based on new requirements
- Add a new channel to the YouTube pipeline
- Write a Slack post per existing templates

---

## Tier 3: Decision-grade

**Signal:** Multi-file changes, new features, architecture decisions, choices between alternatives
**Documentation:** Full Build Record with all sections
- All 9 sections populated
- Decision Log with ADR Iron Law (rejected alternatives documented)
- Requirements Traceability Matrix

**Auto-detect triggers:**
- 10+ file modifications or new directory creation
- Multiple decisions with genuine alternatives
- Cross-system or cross-repo work
- New skill, feature, or workflow creation
- Tyler explicitly discussing tradeoffs

**Examples:**
- Building a new skill (like this one)
- Designing a new workflow or pipeline
- Refactoring a multi-file system
- Any work preceded by a planning phase

---

## Tier 4: Audit-grade

**Signal:** Client deliverables, compliance-sensitive work, financial operations, multi-stakeholder decisions
**Documentation:** Full Build Record + enhanced features
- All Decision-grade content PLUS:
- Context Snapshots before every significant decision
- Detailed human gate records
- Anti-leak verification in traceability matrix
- Integrity hashes for critical outputs

**Auto-detect triggers:**
- Work mentions "client," "customer," "deliverable," or "compliance"
- Financial data or credit operations involved
- Multiple human gates (Tyler + Sara + Wade reviewing)
- Work product will be shared externally
- References to legal, security, or regulatory requirements

**Examples:**
- Building a client workflow (Market Garden Mentor)
- Credit ops changes
- Student evaluation system modifications
- Content going to public channels

---

## Tier 5: Regulatory

**Signal:** Actual SOX, HIPAA, GDPR, or legal exposure
**Documentation:** Full Audit-grade + regulatory controls
- All Audit-grade content PLUS:
- WORM-compatible output format
- Retention period specified and enforced
- Segregation of duties verified (producer != validator)
- Immutability controls (signed commits, locked records)
- Full chain of custody with integrity verification at each stage

**Auto-detect triggers:**
- Work involves regulated data (financial statements, PHI, PII)
- Legal review required
- External audit exposure
- Regulatory compliance explicitly mentioned

**Examples:**
- Financial reporting workflows
- Healthcare data processing
- GDPR data subject request handling
- Any work that could be subpoenaed

---

## Overriding Auto-Detection

```
# Force a specific tier
/build-ledger start --tier audit

# Check what tier was auto-detected
/build-ledger tier

# Upgrade mid-session (can only go up, not down)
/build-ledger tier --upgrade audit
```

**Rule:** Tiers can be upgraded mid-session but never downgraded. If you start at Operational and realize the work is more significant, upgrade to Decision-grade. You cannot go from Decision-grade back to Operational to skip documentation.
