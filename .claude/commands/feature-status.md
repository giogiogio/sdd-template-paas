# Feature Status

Mostra lo stato di una feature in sviluppo.

## Sintassi

```
/feature-status {feature-slug}
```

Senza argomento: mostra tutte le feature attive.

## Istruzioni

1. Cerca in `_bmad-output/planning-artifacts/`:
   - `prototype/{slug}/`
   - `production/{slug}/`

2. Leggi `status.json` se presente

3. Analizza gli artifacts presenti

4. Mostra report:

```
Feature: {slug}
Mode: {prototype|production}
Current Step: {n} ({step-name})

Artifacts:
✅ 1-need.md (approved)
✅ 2-acceptance.md (approved)
⏳ 3-prototype (in progress)
⬜ 4-beta-feedback (pending)

Last Updated: {date}
```

## Lista Feature

Se chiamato senza argomenti, elenca tutte le feature:

```
Active Features:

PROTOTYPE:
- user-registration (step 3/4)
- product-catalog (step 2/4)

PRODUCTION:
- checkout-flow (step 5/9)

Use /feature-status {slug} for details.
```
