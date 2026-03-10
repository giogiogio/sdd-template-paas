# Step 3: Prototype Build

**Agent:** Prototype Developer
**Input:** `1-need.md` + `2-acceptance.md`
**Output:** Working code in `prototype/`

---

## Instructions

Build a minimal working prototype to validate the UX and core functionality.

### Stack

| Component | Technology |
|-----------|------------|
| Backend | PHP 8.4+ / Symfony 8 |
| Frontend | Twig + HTMX 2.0 |
| Styling | Tailwind CSS (CDN) |
| Database | PostgreSQL 18 |
| Server | FrankenPHP |

---

## Guidelines

### 1. Speed Over Perfection

- **DO:** Get something working fast
- **DON'T:** Over-engineer, optimize, or abstract

### 2. Minimal Viable UI

- **DO:** Simple, functional UI that tests the concept
- **DON'T:** Polish, animations, perfect responsive

### 3. HTMX Patterns

```html
<!-- Simple form submission -->
<form hx-post="/api/action" hx-target="#result" hx-swap="innerHTML">
  <input name="field" required>
  <button type="submit">Submit</button>
</form>
<div id="result"></div>

<!-- Inline editing -->
<div hx-get="/edit/123" hx-trigger="click" hx-swap="outerHTML">
  Click to edit
</div>

<!-- Lazy loading -->
<div hx-get="/data" hx-trigger="load" hx-indicator="#spinner">
  <span id="spinner" class="htmx-indicator">Loading...</span>
</div>
```

### 4. Database

- Use Doctrine migrations
- Simple schema, optimize later
- UUID for IDs

### 5. No Authentication (unless required)

- Skip auth if not core to the feature
- Use simple session if needed

---

## Directory Structure

```
prototype/
├── config/
├── public/
├── src/
│   ├── Controller/          # Thin controllers
│   ├── Entity/              # Doctrine entities
│   ├── Form/                # Symfony forms
│   └── Repository/          # Doctrine repositories
├── templates/
│   ├── base.html.twig       # Layout with HTMX + Tailwind
│   └── {feature}/           # Feature templates
├── migrations/
└── .env
```

### Base Template

```twig
{# templates/base.html.twig #}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}Prototype{% endblock %}</title>
    <script src="https://unpkg.com/htmx.org@2.0.0"></script>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <main class="container mx-auto px-4 py-8">
        {% block body %}{% endblock %}
    </main>
</body>
</html>
```

---

## Checklist Before Beta

- [ ] Core use case works end-to-end
- [ ] Basic error handling
- [ ] No crashes on invalid input
- [ ] Data persists correctly
- [ ] UI is understandable (not pretty, understandable)

---

## Human Gate (Beta Test)

Deploy the prototype and present to user:

> "Il prototipo per **{feature}** è pronto per il beta test.
>
> Funzionalità implementate:
> - {Feature 1}
> - {Feature 2}
>
> Limitazioni note:
> - {Limitation 1}
> - {Limitation 2}
>
> **Vuoi procedere con il beta test?** (sì/no/modifiche)"

---

## Remember

🚨 **This code will be THROWN AWAY**

Do not:
- Write unit tests (we have acceptance criteria)
- Create perfect architecture
- Optimize performance
- Handle every edge case

Do:
- Validate the UX
- Test the core concept
- Gather real feedback
