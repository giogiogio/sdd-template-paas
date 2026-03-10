# Promote

Promuovi una feature da Prototype a Production.

## Sintassi

```
/promote {feature-slug}
```

## Istruzioni

1. Verifica che esistano gli artifacts prototype:
   - `_bmad-output/planning-artifacts/prototype/{slug}/1-need.md`
   - `_bmad-output/planning-artifacts/prototype/{slug}/2-acceptance.md`
   - `_bmad-output/planning-artifacts/prototype/{slug}/4-beta-feedback.md`

2. Crea cartella production:
   - `_bmad-output/planning-artifacts/production/{slug}/`

3. Copia e rinomina:
   ```
   1-need.md          → 0-need-validated.md
   2-acceptance.md    → 0-acceptance-validated.md
   4-beta-feedback.md → 0-beta-learnings.md
   ```

4. Aggiorna status prototype come "promoted"

5. Conferma all'utente:
   ```
   ✅ Feature "{slug}" promossa a Production!
   
   Specs copiate:
   - 0-need-validated.md
   - 0-acceptance-validated.md
   - 0-beta-learnings.md
   
   Prossimo step: /production {slug}
   ```

## Importante

🗑️ Il codice in `prototype/` NON viene copiato. Verrà riscritto da zero in Production seguendo TDD e Hexagonal Architecture.
