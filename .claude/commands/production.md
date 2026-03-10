# Production

Avvia direttamente il workflow Production per build scalabile.

## Istruzioni

1. Leggi `docs/constitution.md`
2. Verifica se esistono specs validate da prototype:
   - `0-need-validated.md`
   - `0-acceptance-validated.md`
3. Se mancano, suggerisci di fare prima `/prototype`
4. Crea cartella: `_bmad-output/planning-artifacts/production/{slug}/`
5. Esegui: `_bmad/bmm/workflows/0-production/workflow.md`

## Stack

- PHP 8.4 / Symfony 8 / API Platform
- React 19 + TypeScript + Vite
- PostgreSQL 18 + Redis 7
- Hexagonal Architecture + TDD

## Regole

- TDD obbligatorio (RED → GREEN → REFACTOR)
- Domain layer: zero dipendenze
- Human gates: mai saltare
