---
name: prototype
description: 'Prototype development workflow for fast idea validation. Use when user says "prototype", "prototipo", or "quick validation"'
---

# Prototype Workflow

**Goal:** Validate an idea quickly with minimal code, gather real user feedback, then decide: iterate or promote to production.

---

## Overview

| Step | Agent | Output | Gate |
|------|-------|--------|------|
| 1 | Business Analyst | 1-need.md | ✋ Human |
| 2 | QA Architect | 2-acceptance.md | ✋ Human |
| 3 | Prototype Dev | Working code | ✋ Beta Test |
| 4 | Business Analyst | 4-beta-feedback.md | ✋ Decision |

---

## STEP 1: Need Analysis

**Agent:** Business Analyst
**Input:** Feature request or idea from user
**Output:** `1-need.md`

Load and execute: `steps/step-01-need-analysis.md`

### Human Gate
Present output to user for approval.
- **APPROVED:** Proceed to Step 2
- **REJECTED:** Incorporate feedback, regenerate

---

## STEP 2: Acceptance Criteria

**Agent:** QA Architect
**Input:** Approved 1-need.md
**Output:** `2-acceptance.md` (Gherkin format)

Load and execute: `steps/step-02-acceptance-criteria.md`

### Human Gate
Present output to user for approval.
- **APPROVED:** Proceed to Step 3
- **REJECTED:** Incorporate feedback, regenerate

---

## STEP 3: Prototype Build

**Agent:** Prototype Developer
**Input:** 1-need.md + 2-acceptance.md
**Output:** Working code in `prototype/`

Load and execute: `steps/step-03-prototype-build.md`

### Stack
- Symfony 8 + Twig
- HTMX 2.0
- Tailwind CSS (CDN)
- PostgreSQL

### Human Gate (Beta Test)
Deploy for beta testing with real users.

---

## STEP 4: Beta Feedback

**Agent:** Business Analyst
**Input:** Beta testing results
**Output:** `4-beta-feedback.md`

Load and execute: `steps/step-04-beta-feedback.md`

### Human Gate (Decision)

| Decision | Action |
|----------|--------|
| **ITERATE** | Return to Step 1 with learnings |
| **PROMOTE** | Run `/promote` command |
| **STOP** | Archive feature |

---

## Artifacts Location

All artifacts saved to:
```
{planning_artifacts}/prototype/{feature-slug}/
├── 1-need.md
├── 2-acceptance.md
└── 4-beta-feedback.md
```

---

## Key Rules

1. **Speed over perfection** - Validate the idea, not the code
2. **Minimal viable UI** - Just enough to test the concept
3. **Real user feedback** - Don't assume, test
4. **Code is disposable** - Never refactor prototype to production
