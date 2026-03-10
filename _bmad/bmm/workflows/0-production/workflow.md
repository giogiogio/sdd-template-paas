---
name: production
description: 'Production development workflow for scalable features. Use when user says "production", "produzione", or "full development"'
---

# Production Workflow

**Goal:** Build scalable, maintainable, well-tested features following Hexagonal Architecture and TDD.

---

## Overview

| Step | Type | Output | Gate |
|------|------|--------|------|
| 1 | BMAD | 1-design.md (UX) | ✋ Human |
| 2 | Custom | 2-estimation.md | ✋ Human |
| 3a | BMAD | architecture.md | ✋ Human |
| 3b | Custom | database-design.md | ✋ Human |
| 4 | BMAD | readiness-checklist.md | Auto |
| 5 | Custom | tests/ (TDD) | ✋ Human |
| 6 | BMAD | backend/src/ | ✋ Review |
| 7 | BMAD | frontend/src/ | ✋ Review |
| 8 | Custom | tests/e2e/ | ✋ Human |
| 9 | BMAD | PR approved | ✋ Human |

---

## Prerequisites

Check for validated specs from Prototype:
- `0-need-validated.md`
- `0-acceptance-validated.md`
- `0-beta-learnings.md`

If missing, warn user and suggest running Prototype first.

---

## STEP 1: UX Design

**Workflow:** BMAD `create-ux-design`
**Output:** `1-design.md`

Execute the BMAD UX Design workflow with these constraints:
- Desktop-first (mobile responsive)
- Component-based design
- Accessibility (WCAG 2.1 AA)

### Human Gate
Present design specs for approval.

---

## STEP 2: Estimation

**Agent:** Architect + PM
**Output:** `2-estimation.md`

Load and execute: `steps/step-02-estimation.md`

Includes:
- Complexity analysis
- Token estimation per step
- Cost per AI model
- Time estimate
- GO/NO-GO recommendation

### Human Gate
Approve budget and timeline before proceeding.

---

## STEP 3a: Architecture

**Workflow:** BMAD `create-architecture`
**Output:** `architecture.md`

Must follow Constitution rules:
- Hexagonal Architecture
- Domain Layer: zero dependencies
- CQRS pattern
- Repository interfaces in Domain

### Human Gate
Approve architecture decisions.

---

## STEP 3b: Database Design

**Agent:** Architect
**Output:** `database-design.md`

Load and execute: `steps/step-03b-database-design.md`

Includes:
- ERD diagram (Mermaid)
- Table definitions
- Indexes
- Doctrine mappings

### Human Gate
Approve database schema.

---

## STEP 4: Readiness Check

**Workflow:** BMAD `check-implementation-readiness`
**Output:** `readiness-checklist.md`

Verify all specs are complete before coding.

### Auto Gate
If all checks pass, proceed automatically.

---

## STEP 5: Test First (TDD)

**Agent:** QA + Dev
**Output:** `tests/unit/`, `tests/integration/`

Load and execute: `steps/step-04-test-first.md`

Write tests BEFORE implementation:
- Unit tests for Domain
- Integration tests for Application
- Object Mothers / Fixtures

### Human Gate
Approve test coverage plan.

---

## STEP 6: Backend Implementation

**Workflow:** BMAD `dev-story`
**Context:** PHP 8.4, Symfony 8, Hexagonal, API Platform
**Output:** `backend/src/`

Implementation order:
1. Domain Layer (Entities, VOs, Repository interfaces)
2. Application Layer (Commands, Queries, Handlers)
3. Infrastructure Layer (Doctrine, Controllers)

Tests must pass after each layer.

### Human Gate
Code review checkpoint.

---

## STEP 7: Frontend Implementation

**Workflow:** BMAD `dev-story`
**Context:** React 19, TypeScript, Vite
**Output:** `frontend/src/`

Implementation:
1. Types/Interfaces
2. API client
3. Components
4. Integration

### Human Gate
Code review checkpoint.

---

## STEP 8: E2E Tests

**Agent:** QA
**Output:** `tests/e2e/`

Load and execute: `steps/step-07-e2e-tests.md`

Playwright tests for:
- Critical user flows
- Happy paths
- Error handling

### Human Gate
Approve E2E coverage.

---

## STEP 9: Code Review

**Workflow:** BMAD `code-review`
**Output:** PR approved

Final review checklist:
- [ ] All tests pass
- [ ] Code follows Constitution
- [ ] No security issues
- [ ] Documentation complete

### Human Gate
Approve PR for merge.

---

## Artifacts Location

All artifacts saved to:
```
{planning_artifacts}/production/{feature-slug}/
├── 0-need-validated.md       # From prototype
├── 0-acceptance-validated.md # From prototype
├── 0-beta-learnings.md       # From prototype
├── 1-design.md
├── 2-estimation.md
├── architecture.md
├── database-design.md
├── readiness-checklist.md
└── ...
```

---

## Key Rules

1. **TDD is mandatory** - RED → GREEN → REFACTOR
2. **Domain is pure** - Zero external dependencies
3. **Human gates are checkpoints** - Never skip
4. **Quality over speed** - This code will be maintained
