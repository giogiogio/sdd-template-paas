# Step 2: Acceptance Criteria

**Agent:** QA Architect
**Input:** Approved `1-need.md`
**Output:** `2-acceptance.md`

---

## Instructions

Transform the need analysis into testable acceptance criteria using Gherkin format.

### Guidelines

1. **One scenario per behavior** - Keep scenarios focused
2. **Use business language** - No technical jargon
3. **Include edge cases** - Think about what could go wrong
4. **Be specific** - Avoid vague terms like "quickly" or "easily"

---

## Output Template

```markdown
# Acceptance Criteria: {Feature Name}

## Feature Overview
{Brief description from need analysis}

---

## Scenarios

### Happy Path

#### Scenario: {Primary use case}
```gherkin
Feature: {Feature Name}
  As a {user type}
  I want to {action}
  So that {benefit}

  Scenario: {Scenario name}
    Given {initial context}
    And {additional context if needed}
    When {action is performed}
    Then {expected outcome}
    And {additional outcome if needed}
```

### Validation Scenarios

#### Scenario: {Validation rule 1}
```gherkin
  Scenario: {Invalid input handling}
    Given {context}
    When {invalid action}
    Then {error handling}
```

### Edge Cases

#### Scenario: {Edge case 1}
```gherkin
  Scenario: {Edge case description}
    Given {unusual context}
    When {action}
    Then {expected behavior}
```

---

## Test Coverage Matrix

| Business Rule | Scenario | Priority |
|--------------|----------|----------|
| BR-01 | Scenario X | High |
| BR-02 | Scenario Y | Medium |

---

## Out of Scope for Prototype
- {What we're NOT testing in prototype}
- {Deferred to production}
```

---

## Gherkin Best Practices

### DO ✅
```gherkin
Scenario: User registers with valid email
  Given I am on the registration page
  When I enter "user@example.com" as my email
  And I enter "SecurePass123!" as my password
  And I click "Register"
  Then I should see "Welcome! Please check your email"
  And I should receive a confirmation email
```

### DON'T ❌
```gherkin
Scenario: Registration
  Given I am a user
  When I register
  Then it works
```

---

## Human Gate

Present the completed 2-acceptance.md to the user and ask:

> "Ho definito i criteri di accettazione per **{feature}**.
>
> Scenari inclusi:
> - Happy path: {count} scenari
> - Validazioni: {count} scenari  
> - Edge case: {count} scenari
>
> **Approvi questi criteri?** (sì/no/feedback)"

If rejected, incorporate feedback and regenerate.
