---
name: 'feature-status'
description: 'Show current status of a feature. Use when user says "status", "stato feature", or "dove siamo"'
---

SHOW FEATURE STATUS

1. Ask user for feature slug if not provided

2. Check both folders:
   - {project-root}/_bmad-output/planning-artifacts/prototype/{feature-slug}/
   - {project-root}/_bmad-output/planning-artifacts/production/{feature-slug}/

3. List all artifacts found with their status:
   - File exists: ✅
   - File missing: ❌

4. Determine current mode (prototype or production)

5. Identify current step based on existing artifacts

6. Show summary:
   ```
   Feature: {feature-slug}
   Mode: {prototype|production}
   Current Step: {n}
   
   Artifacts:
   - 1-need.md: ✅/❌
   - 2-acceptance.md: ✅/❌
   - ...
   
   Next Action: {what to do next}
   ```

7. Offer to resume: "Vuoi continuare da dove eri rimasto?"
