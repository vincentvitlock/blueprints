# Build Record: BR-YYYYMMDD-NNN

> **Session:** #NNN | **Date:** YYYY-MM-DD | **Agent:** model-name | **Tier:** Decision-grade
> **Status:** Complete | Partial | Blocked

---

## Executive Summary

<!-- 3-5 sentences. A busy person should understand the entire session from this alone. -->

[What was built/fixed/changed. Why. Key decisions made. Current state. What's next.]

---

## 1. Trigger

**Type:** user_request | scheduled | event_driven | continuation
**Source:** [Voice memo | Slack message | ticket | auto | conversation]
**Original Requirement (verbatim):**

> [Paste the exact original request here. Do not paraphrase. This is the anchor for the traceability matrix.]

**Interpreted Scope:** [How the agent understood the requirement, including any clarifying questions asked]

---

## 2. Plan

### Chosen Approach

[Description of the approach taken and why it was selected]

### Alternatives Considered

<!-- ADR Iron Law: NEVER document a decision without documenting the rejected alternatives. -->

| # | Alternative | Why Rejected |
|---|------------|-------------|
| 1 | [Option A] | [Specific reason] |
| 2 | [Option B] | [Specific reason] |

### Acceptance Criteria

- [ ] [What success looks like, criterion 1]
- [ ] [What success looks like, criterion 2]
- [ ] [What success looks like, criterion 3]

---

## 3. Actions Timeline

| Time (CST) | Actor | Action | Target | Why |
|-----------|-------|--------|--------|-----|
| HH:MM | Agent | [What was done] | [File/system] | [Justification] |
| HH:MM | Human | [Direction given] | -- | [Context] |
| HH:MM | Agent | [What was done] | [File/system] | [Justification] |

---

## 4. Decision Log

### D-YYYYMMDD-001: [Decision Title]

| Field | Value |
|-------|-------|
| **Question** | What was being decided |
| **Decision** | What was chosen |
| **Rationale** | Why this was chosen |
| **Decided by** | Human / Agent / Collaborative |
| **Confidence** | High / Medium / Low |

**Alternatives:**
1. [Option A] -- Rejected because: [specific reason]
2. [Option B] -- Rejected because: [specific reason]

**Assumptions:** [What we assumed to be true]
**Risks accepted:** [Known risks of this decision]

---

## 5. Human Gates

| # | Time | Type | Actor | Context | Action | Conditions |
|---|------|------|-------|---------|--------|------------|
| HG-001 | HH:MM | Approval | [Name] | [What was reviewed] | [Approved / Redirected / Overridden] | [Any conditions] |

---

## 6. Requirements Traceability Matrix

<!-- Maps every original requirement to a deliverable. This is the fix for the requirements leak pattern. -->

| # | Requirement (source) | Deliverable | Status | Evidence |
|---|---------------------|-------------|--------|----------|
| 1 | "[Verbatim from trigger]" | [File or artifact] | DONE / PARTIAL / NOT BUILT | [How to verify] |
| 2 | "[Verbatim from trigger]" | [File or artifact] | DONE / PARTIAL / NOT BUILT | [How to verify] |

**Coverage:** X/Y requirements addressed (Z%)
**Gaps:** [List any requirements not addressed, with reason]

---

## 7. Outcome

**Deliverables produced:**
- [File/artifact 1] -- [Description]
- [File/artifact 2] -- [Description]

**What was NOT delivered (and why):**
- [Item] -- [Reason: out of scope / blocked / deferred / requires human action]

**Quality assessment:**
- [Self-assessment of output quality]
- [Any known issues or limitations]

---

## 8. Next Actions

| # | Action | Owner | Priority | Blocking? |
|---|--------|-------|----------|-----------|
| 1 | [What needs to happen] | [Human/Agent] | P0-P3 | Yes/No |

---

## 9. Audit Metadata

| Field | Value |
|-------|-------|
| **Build Record ID** | BR-YYYYMMDD-NNN |
| **Session ID** | [Session number or identifier] |
| **Agent Model** | [e.g., claude-opus-4.6] |
| **Duration** | [Session duration] |
| **Files Modified** | [Count] |
| **Decisions Made** | [Count] |
| **Human Gates** | [Count] |
| **Depth Tier** | [Ephemeral / Operational / Decision-grade / Audit-grade / Regulatory] |
| **Eval Score** | [If eval was run: e.g., "A (18/20 fresh eyes, 92% completeness)"] |
| **Compiled** | [Timestamp of Build Record compilation] |
