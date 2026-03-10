# Step 2: Estimation

**Agent:** Architect + PM
**Output:** `2-estimation.md`

---

## Instructions

Analyze the feature complexity and provide detailed estimates including AI costs.

---

## Output Template

```markdown
# Estimation: {Feature Name}

## Complexity Analysis

### Domain Complexity
| Aspect | Score (1-5) | Notes |
|--------|-------------|-------|
| Entities | {score} | {count} entities |
| Business Rules | {score} | {count} rules |
| Integrations | {score} | {list} |
| Data Model | {score} | {notes} |

**Overall Domain Complexity:** {Low / Medium / High}

### Technical Complexity
| Aspect | Score (1-5) | Notes |
|--------|-------------|-------|
| Architecture | {score} | {notes} |
| Security | {score} | {notes} |
| Performance | {score} | {notes} |
| Testing | {score} | {notes} |

**Overall Technical Complexity:** {Low / Medium / High}

---

## Token Estimation

| Step | Est. Input Tokens | Est. Output Tokens | Iterations |
|------|-------------------|-------------------|------------|
| 1. UX Design | {X}K | {X}K | {n} |
| 2. Estimation | {X}K | {X}K | {n} |
| 3a. Architecture | {X}K | {X}K | {n} |
| 3b. Database | {X}K | {X}K | {n} |
| 5. Test First | {X}K | {X}K | {n} |
| 6. Backend | {X}K | {X}K | {n} |
| 7. Frontend | {X}K | {X}K | {n} |
| 8. E2E Tests | {X}K | {X}K | {n} |
| 9. Code Review | {X}K | {X}K | {n} |
| **TOTAL** | **{X}K** | **{X}K** | **{n}** |

---

## Cost Estimation by Model

| Model | Input Cost | Output Cost | Total |
|-------|------------|-------------|-------|
| Claude Opus 4 | ${X} (@$15/1M) | ${X} (@$75/1M) | **${X}** |
| Claude Sonnet 4 | ${X} (@$3/1M) | ${X} (@$15/1M) | **${X}** |
| Claude Haiku 4 | ${X} (@$0.25/1M) | ${X} (@$1.25/1M) | **${X}** |
| GPT-4o | ${X} (@$2.50/1M) | ${X} (@$10/1M) | **${X}** |
| GPT-4o-mini | ${X} (@$0.15/1M) | ${X} (@$0.60/1M) | **${X}** |

### Recommended Model Strategy

| Step | Recommended Model | Rationale |
|------|-------------------|-----------|
| Architecture | Opus 4 | Complex reasoning |
| Backend/Frontend | Sonnet 4 | Good balance |
| Tests | Sonnet 4 | Structured output |
| Code Review | Haiku 4 | Fast, pattern-based |

**Estimated Total Cost:** ${X} - ${X}

---

## Time Estimation

| Step | Best Case | Expected | Worst Case |
|------|-----------|----------|------------|
| Design & Planning | {X}h | {X}h | {X}h |
| Backend Dev | {X}h | {X}h | {X}h |
| Frontend Dev | {X}h | {X}h | {X}h |
| Testing & QA | {X}h | {X}h | {X}h |
| Review & Deploy | {X}h | {X}h | {X}h |
| **TOTAL** | **{X}h** | **{X}h** | **{X}h** |

---

## Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| {Risk 1} | High/Med/Low | High/Med/Low | {Action} |
| {Risk 2} | High/Med/Low | High/Med/Low | {Action} |

---

## Recommendation

### ✅ GO
{Conditions for proceeding}

### ⚠️ GO WITH ADJUSTMENTS
{What to adjust}

### ❌ NO-GO
{Why to stop or reduce scope}

---

## Decision Required

**Estimated Cost:** ${X} - ${X}
**Estimated Time:** {X}h - {X}h
**Risk Level:** {Low / Medium / High}

**Recommendation:** {GO / GO WITH ADJUSTMENTS / NO-GO}
```

---

## Human Gate

Present the estimation and ask:

> "Ho completato la stima per **{feature}**.
>
> **Costo stimato:** ${min} - ${max}
> **Tempo stimato:** {min}h - {max}h
> **Complessità:** {level}
>
> **Raccomandazione:** {GO / ADJUST / NO-GO}
>
> **Vuoi procedere con questa stima?** (sì/no/riduci scope)"

Options:
- **YES:** Proceed to Step 3a
- **REDUCE SCOPE:** Re-estimate with reduced features
- **NO:** Stop or return to Prototype
