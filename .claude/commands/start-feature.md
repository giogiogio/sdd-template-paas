# Start Feature

Avvia il workflow per una nuova feature.

## Istruzioni

1. Leggi `docs/constitution.md`
2. Leggi `_bmad/bmm/config.yaml` per il contesto progetto
3. Chiedi all'utente:
   - Nome feature (slug: `user-registration`)
   - Descrizione breve (1 frase)
4. Chiedi modalità:
   ```
   Quale modalità vuoi usare?
   
   [P] PROTOTYPE - Validazione veloce (Symfony + HTMX)
   [R] PRODUCTION - Build scalabile (API Platform + React)
   ```
5. Crea cartella: `_bmad-output/planning-artifacts/{mode}/{slug}/`
6. Esegui il workflow appropriato:
   - Prototype: `_bmad/bmm/workflows/0-prototype/workflow.md`
   - Production: `_bmad/bmm/workflows/0-production/workflow.md`

## Output

Avvia il primo step del workflow selezionato.
