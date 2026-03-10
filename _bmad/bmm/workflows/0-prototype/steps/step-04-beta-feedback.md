# Step 4: Beta Feedback

**Agent:** Business Analyst
**Input:** Beta testing results
**Output:** `4-beta-feedback.md`

---

## Instructions

Collect and analyze feedback from beta testing to inform the next decision.

### Data Collection

Interview users or analyze usage data:

1. **What worked well?**
2. **What was confusing?**
3. **What's missing?**
4. **Would they use this?**
5. **Would they pay for this?** (if relevant)

---

## Output Template

```markdown
# Beta Feedback: {Feature Name}

## Test Summary

| Metric | Value |
|--------|-------|
| Test Duration | {days} |
| Testers | {count} |
| Sessions | {count} |
| Completion Rate | {%} |

---

## What Worked ✅

### {Positive Finding 1}
- **Observation:** {What we saw}
- **User Quote:** "{Direct quote if available}"
- **Impact:** {Why this matters}

### {Positive Finding 2}
...

---

## Issues Found ❌

### {Issue 1}: {Short description}
- **Severity:** Critical / High / Medium / Low
- **Frequency:** {How often it occurred}
- **User Impact:** {What users couldn't do}
- **Observation:** {Details}

### {Issue 2}
...

---

## Missing Features 🔍

| Feature | User Requests | Priority |
|---------|--------------|----------|
| {Feature 1} | {count} | High/Med/Low |
| {Feature 2} | {count} | High/Med/Low |

---

## Pivot Signals 🔄

{Any indication that the core concept needs rethinking?}

- [ ] Users don't understand the value proposition
- [ ] Core problem assumption was wrong
- [ ] Target users are different than expected
- [ ] Competitive solution is "good enough"

---

## Recommendation

### Option A: ITERATE
{Why we should iterate and what to change}

Next iteration focus:
1. {Change 1}
2. {Change 2}

### Option B: PROMOTE
{Why we should promote to production}

Validated assumptions:
1. {Assumption 1}
2. {Assumption 2}

### Option C: STOP
{Why we should stop}

Learnings to preserve:
1. {Learning 1}
2. {Learning 2}

---

## Decision

**Recommended:** {ITERATE / PROMOTE / STOP}

**Rationale:** {Brief explanation}
```

---

## Human Gate (Decision)

Present the analysis and ask:

> "Ho analizzato il feedback del beta test per **{feature}**.
>
> **Risultati chiave:**
> - ✅ {What worked}
> - ❌ {Main issue}
> - 🔍 {Missing feature}
>
> **Raccomandazione:** {ITERATE / PROMOTE / STOP}
>
> **Quale decisione vuoi prendere?**
> - [I] ITERATE - Torna allo Step 1 con i feedback
> - [P] PROMOTE - Promuovi a Production (/promote)
> - [S] STOP - Archivia la feature"

---

## Next Steps by Decision

### If ITERATE
1. Update 1-need.md with learnings
2. Restart from Step 1
3. Focus on top issues

### If PROMOTE
1. Run `/promote {feature-slug}`
2. Copy validated specs to production
3. Start Production workflow

### If STOP
1. Document learnings
2. Archive feature folder
3. Move on
