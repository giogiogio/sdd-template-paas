---
name: start-feature
description: 'Main orchestrator for feature development. Use when user says "start feature", "nuova feature", "new feature", "inizia", or "crea feature"'
---

# Feature Orchestrator

**Goal:** Guide the user through the complete feature development lifecycle, from idea to production.

---

## OVERVIEW

This orchestrator manages two development modes:

| Mode | When to Use | Stack |
|------|-------------|-------|
| **PROTOTYPE** | Validate idea fast, uncertain requirements | Symfony + HTMX |
| **PRODUCTION** | Build for scale, validated requirements | API Platform + React |

---

## WORKFLOW

```
                    START
                      │
                      ▼
              ┌───────────────┐
              │ Choose Mode   │
              └───────┬───────┘
                      │
         ┌────────────┴────────────┐
         │                         │
         ▼                         ▼
┌─────────────────┐      ┌─────────────────┐
│   PROTOTYPE     │      │   PRODUCTION    │
│                 │      │                 │
│ 1. Need         │      │ 1. Design       │
│ 2. Acceptance   │      │ 2. Estimation   │
│ 3. Build        │      │ 3. Architecture │
│ 4. Beta Test    │      │ 4. Database     │
│                 │      │ 5. Tests (TDD)  │
└────────┬────────┘      │ 6. Backend      │
         │               │ 7. Frontend     │
         ▼               │ 8. E2E Tests    │
   ┌───────────┐         │ 9. Code Review  │
   │ Validated?│         └────────┬────────┘
   └─────┬─────┘                  │
         │                        │
    YES  │                        │
         ▼                        ▼
   ┌───────────┐            ┌───────────┐
   │  PROMOTE  │───────────▶│   DONE    │
   └───────────┘            └───────────┘
```

---

## INITIALIZATION

### 1. Load Configuration

Load from {project-root}/_bmad/bmm/config.yaml:
- project_name
- user_name
- communication_language
- planning_artifacts path

### 2. Load Constitution

Read and internalize: {project-root}/docs/constitution.md

### 3. Ask Feature Name

Ask user:
- Feature name (slug format, e.g., user-registration)
- One-sentence description

### 4. Create Feature Folder

Create: {planning_artifacts}/{mode}/{feature-slug}/

---

## MODE SELECTION

Present options to user:

```
Quale modalita vuoi usare per questa feature?

[P] PROTOTYPE
    - Validazione veloce dell'idea
    - Analisi completa + build minimale
    - Stack: Symfony + Twig + HTMX
    - Tempo: ore/giorni
    - Ideale per: idee nuove, requisiti incerti

[R] PRODUCTION
    - Build scalabile e mantenibile
    - TDD + Hexagonal Architecture
    - Stack: API Platform + React
    - Tempo: giorni/settimane
    - Ideale per: requisiti validati, feature critiche

[I] INFO
    - Mostra differenze dettagliate

Scelta:
```

---

## PROTOTYPE MODE

When user selects [P]:

### Execute Workflow

Read and follow: {project-root}/_bmad/bmm/workflows/0-prototype/workflow.md

### Steps

1. Need Analysis (step-01-need-analysis.md)
   - Output: 1-need.md
   - HUMAN GATE

2. Acceptance Criteria (step-02-acceptance-criteria.md)
   - Output: 2-acceptance.md
   - HUMAN GATE

3. Prototype Build (step-03-prototype-build.md)
   - Output: working code in prototype/
   - HUMAN GATE

4. Beta Feedback (step-04-beta-feedback.md)
   - Output: 4-beta-feedback.md
   - DECISION: Iterate or Promote

### After Prototype

If user chooses PROMOTE:
- Execute promotion command
- Copy validated specs to production folder
- Start Production workflow from Step 1 (Design)

---

## PRODUCTION MODE

When user selects [R]:

### Check Prerequisites

If coming from Prototype promotion:
- Load 0-need-validated.md
- Load 0-acceptance-validated.md
- Load 0-beta-learnings.md
- Skip to Step 1 (Design)

If starting fresh:
- Warn: "Production mode works best with validated requirements"
- Offer: Run Prototype first, or continue with Production
- If continue: Need manual need.md and acceptance.md creation

### Execute Workflow

Read and follow: {project-root}/_bmad/bmm/workflows/0-production/workflow.md

### Steps

1. UX Design (BMAD: create-ux-design)
   - Output: 1-design.md
   - HUMAN GATE

2. Estimation (step-02-estimation.md)
   - Output: 2-estimation.md
   - HUMAN GATE: Approve costs

3. Architecture (BMAD: create-architecture)
   - Output: architecture.md
   - HUMAN GATE

4. Database Design (step-03b-database-design.md)
   - Output: database-design.md
   - HUMAN GATE

5. Readiness Check (BMAD: check-implementation-readiness)
   - Output: readiness-checklist.md

6. Test First (step-04-test-first.md)
   - Output: tests/unit/, tests/integration/
   - HUMAN GATE

7. Backend Implementation (BMAD: dev-story)
   - Context: PHP 8.4, Symfony 8, Hexagonal, API Platform
   - Output: backend/src/

8. Frontend Implementation (BMAD: dev-story)
   - Context: React 19, TypeScript, Vite
   - Output: frontend/src/

9. E2E Tests (step-07-e2e-tests.md)
   - Output: tests/e2e/
   - HUMAN GATE

10. Code Review (BMAD: code-review)
    - Output: PR approved

---

## PROMOTION COMMAND

When promoting from Prototype to Production:

```
/promote {feature-slug}
```

Actions:
1. Verify prototype artifacts exist
2. Copy specs to production folder:
   - 1-need.md -> 0-need-validated.md
   - 2-acceptance.md -> 0-acceptance-validated.md
   - 4-beta-feedback.md -> 0-beta-learnings.md
3. Mark prototype as promoted
4. Initialize production workflow

---

## STATUS COMMAND

Check feature status:

```
/status {feature-slug}
```

Output:
```
Feature: user-registration
Mode: prototype
Current Step: 3 (Prototype Build)
Steps Completed: [1, 2]
Steps Remaining: [3, 4]

Artifacts:
- 1-need.md ✅ approved
- 2-acceptance.md ✅ approved
- 3-code/ ⏳ in progress
```

---

## RESUME COMMAND

Resume interrupted feature:

```
/resume {feature-slug}
```

Actions:
1. Load feature status.json
2. Identify last completed step
3. Resume from next step

---

## COMMANDS SUMMARY

| Command | Description |
|---------|-------------|
| /start-feature | Start new feature (this orchestrator) |
| /prototype {slug} | Start prototype mode directly |
| /production {slug} | Start production mode directly |
| /promote {slug} | Promote prototype to production |
| /status {slug} | Show feature status |
| /resume {slug} | Resume interrupted feature |

---

## TRACKING

For each feature, maintain status in:
{planning_artifacts}/{mode}/{feature-slug}/status.json

```json
{
  "feature": "user-registration",
  "mode": "prototype",
  "currentStep": 3,
  "stepsCompleted": [1, 2],
  "history": [
    {"step": 1, "status": "approved", "date": "2026-03-08"},
    {"step": 2, "status": "approved", "date": "2026-03-08"}
  ],
  "promoted": false
}
```

---

## ERROR HANDLING

If user is lost:
- Show current status
- Offer to resume or restart
- Point to /status command

If artifacts missing:
- Identify which are missing
- Offer to regenerate or provide manually

If mode unclear:
- Default to asking mode selection
- Explain differences briefly
