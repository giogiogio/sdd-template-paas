---
name: 'promote'
description: 'Promote a validated prototype to production mode. Use when user says "promote", "promuovi", or "passa a produzione"'
---

PROMOTE PROTOTYPE TO PRODUCTION

Follow these steps:

1. Ask user for feature slug (e.g., user-registration)

2. Verify prototype artifacts exist:
   - {project-root}/_bmad-output/planning-artifacts/prototype/{feature-slug}/1-need.md
   - {project-root}/_bmad-output/planning-artifacts/prototype/{feature-slug}/2-acceptance.md
   - {project-root}/_bmad-output/planning-artifacts/prototype/{feature-slug}/4-beta-feedback.md

3. Create production folder:
   - mkdir -p {project-root}/_bmad-output/planning-artifacts/production/{feature-slug}/

4. Copy and rename validated specs:
   - 1-need.md -> 0-need-validated.md
   - 2-acceptance.md -> 0-acceptance-validated.md
   - 4-beta-feedback.md -> 0-beta-learnings.md

5. Confirm promotion complete

6. Ask: "Vuoi avviare il workflow Production per questa feature?"

7. If yes, LOAD the FULL {project-root}/_bmad/bmm/workflows/0-production/workflow.md and follow its directions!
