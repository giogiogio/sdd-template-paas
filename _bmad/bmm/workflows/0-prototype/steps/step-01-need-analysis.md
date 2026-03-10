# Step 1: Need Analysis

**Agent:** Business Analyst
**Output:** `1-need.md`

---

## Instructions

Analyze the feature request and produce a comprehensive need document.

### Questions to Answer

1. **What problem are we solving?**
   - Pain point description
   - Who experiences this problem?
   - How severe is it?

2. **Who are the stakeholders?**
   - Primary users
   - Secondary users
   - Business stakeholders

3. **What are the use cases?**
   - Primary flow (happy path)
   - Alternative flows
   - Edge cases

4. **What are the business rules?**
   - Constraints
   - Validations
   - Dependencies

5. **What does success look like?**
   - Key metrics
   - Expected outcomes
   - Definition of done

---

## Output Template

```markdown
# Need Analysis: {Feature Name}

## Problem Statement
{Clear description of the problem we're solving}

## Stakeholders

### Primary Users
- {User type 1}: {Their need}
- {User type 2}: {Their need}

### Business Stakeholders
- {Stakeholder}: {Their interest}

## Use Cases

### UC-01: {Primary Use Case Name}
**Actor:** {Who performs this}
**Precondition:** {What must be true before}
**Flow:**
1. {Step 1}
2. {Step 2}
3. {Step 3}
**Postcondition:** {What is true after}

### UC-02: {Alternative Use Case}
...

## Business Rules

| ID | Rule | Rationale |
|----|------|-----------|
| BR-01 | {Rule description} | {Why this rule exists} |
| BR-02 | {Rule description} | {Why this rule exists} |

## Success Criteria

- [ ] {Measurable outcome 1}
- [ ] {Measurable outcome 2}
- [ ] {Measurable outcome 3}

## Out of Scope
- {What we're NOT building}
- {What we're deferring}

## Open Questions
- {Question 1}
- {Question 2}
```

---

## Human Gate

Present the completed 1-need.md to the user and ask:

> "Ho completato l'analisi del bisogno per la feature **{name}**.
>
> Punti chiave:
> - Problema: {summary}
> - Utenti principali: {users}
> - Use case primario: {main UC}
>
> **Approvi questa analisi?** (sì/no/feedback)"

If rejected, incorporate feedback and regenerate.
