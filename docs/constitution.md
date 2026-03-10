# Constitution

> Regole architetturali non negoziabili per questo progetto.
> Questo documento deve essere letto da ogni agente AI prima di generare codice.

---

## 1. Architettura

### 1.1 Hexagonal Architecture (Production Mode)

```
Domain ← Application ← Infrastructure
  │          │              │
  │          │              └── Può dipendere da Application e Domain
  │          └── Può dipendere solo da Domain
  └── NON dipende da nulla (zero import esterni)
```

### 1.2 Layer Rules

**Domain Layer** (`backend/src/Domain/`)
- Contiene: Entity, ValueObject, Repository (interfacce), Service, Event, Exception
- ZERO dipendenze esterne (no Symfony, no Doctrine, no vendor)
- Logica di business pura

**Application Layer** (`backend/src/Application/`)
- Contiene: Command, Query, Handler, DTO, Port
- Dipende SOLO dal Domain
- Orchestrazione use cases

**Infrastructure Layer** (`backend/src/Infrastructure/`)
- Contiene: Persistence, Http/Controller, External services
- Implementa le interfacce del Domain e Application
- Può dipendere da tutto

---

## 2. TDD (Test-Driven Development)

### 2.1 Ciclo Obbligatorio

```
RED → GREEN → REFACTOR
```

1. Scrivi test che FALLISCE
2. Scrivi codice MINIMO per passare
3. Refactora mantenendo test GREEN

### 2.2 Copertura Target

| Layer | Tipo Test | Target |
|-------|-----------|--------|
| Domain | Unit | 90%+ |
| Application | Unit + Integration | 80%+ |
| Infrastructure | Integration | 70%+ |
| E2E | Playwright | Critical paths |

### 2.3 Pattern

- **Object Mother**: factory per fixtures riutilizzabili
- **Builder Pattern**: costruzione entità complesse nei test
- **In-Memory Repository**: per unit test Domain senza DB

---

## 3. SOLID Principles

### 3.1 Single Responsibility (S)
- Una classe = una ragione per cambiare
- Handler fa UNA cosa

### 3.2 Open/Closed (O)
- Estendi con nuove classi, non modificare esistenti
- Usa Strategy pattern per variazioni

### 3.3 Liskov Substitution (L)
- Sottoclassi sostituibili senza rompere comportamento
- Evita ereditarietà profonda

### 3.4 Interface Segregation (I)
- Interfacce piccole e specifiche
- Client non deve dipendere da metodi che non usa

### 3.5 Dependency Inversion (D)
- Dipendi da astrazioni, non implementazioni
- Inietta dipendenze via constructor

---

## 4. Convenzioni PHP

### 4.1 Stile

```php
<?php

declare(strict_types=1);

namespace App\Domain\User\Entity;

final class User
{
    public function __construct(
        private readonly UserId $id,
        private Email $email,
        private \DateTimeImmutable $createdAt,
    ) {}
}
```

### 4.2 Regole

- `declare(strict_types=1);` SEMPRE
- Classi `final` by default (apri solo se necessario)
- `readonly` per proprietà immutabili
- Constructor Property Promotion
- Named arguments per >3 parametri
- Return type SEMPRE esplicito
- PSR-12 + Symfony Standards

### 4.3 Naming

| Tipo | Pattern | Esempio |
|------|---------|---------|
| Entity | Noun | `User`, `Order` |
| ValueObject | Noun | `Email`, `Money` |
| Event | PastTense | `UserRegistered`, `OrderPlaced` |
| Command | Verb + Noun | `RegisterUser`, `PlaceOrder` |
| Query | Get/Find + Noun | `GetUserById`, `FindActiveOrders` |
| Handler | Command/Query + Handler | `RegisterUserHandler` |
| Exception | Cannot + Verb | `CannotRegisterUser` |
| Interface | Noun + Interface | `UserRepositoryInterface` |
| Implementation | Prefix + Interface | `DoctrineUserRepository` |

---

## 5. Database

### 5.1 Naming

- Tabelle: `snake_case` plurale → `users`, `order_items`
- Colonne: `snake_case` → `created_at`, `user_id`
- Primary Key: `id` (UUID v7)
- Foreign Key: `{entity}_id` → `user_id`, `order_id`

### 5.2 Colonne Standard

```sql
id UUID PRIMARY KEY,
-- ... campi specifici ...
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
deleted_at TIMESTAMP NULL  -- solo se soft delete necessario
```

### 5.3 Migrations

- Una migration = una modifica atomica
- Nome descrittivo: `Version20260310_AddUserSubscriptionTable`
- MAI modificare migration già deployata

---

## 6. API (Production Mode)

### 6.1 REST Conventions

```
GET    /api/v1/users          # List
GET    /api/v1/users/{id}     # Show
POST   /api/v1/users          # Create
PUT    /api/v1/users/{id}     # Update (full)
PATCH  /api/v1/users/{id}     # Update (partial)
DELETE /api/v1/users/{id}     # Delete
```

### 6.2 Response Format

```json
{
  "data": { ... },
  "meta": {
    "timestamp": "2026-03-10T12:00:00Z",
    "version": "1.0.0"
  }
}
```

### 6.3 Error Format

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input",
    "details": [
      { "field": "email", "message": "Invalid email format" }
    ]
  }
}
```

---

## 7. Frontend (Production Mode)

### 7.1 Struttura

```
frontend/src/
├── components/       # UI components riutilizzabili
├── features/         # Feature modules (domain-driven)
├── hooks/           # Custom hooks
├── services/        # API clients
├── stores/          # State management
├── types/           # TypeScript types
└── utils/           # Utilities
```

### 7.2 Regole

- TypeScript strict mode
- Functional components only
- Custom hooks per logica riutilizzabile
- Colocate test con componenti

---

## 8. Git

### 8.1 Conventional Commits

```
feat: add user registration
fix: correct email validation
refactor: extract payment service
docs: update API documentation
test: add subscription tests
chore: update dependencies
perf: optimize database queries
breaking: change API response format
```

### 8.2 Branch Naming

```
feature/{slug}    # Nuova feature
fix/{slug}        # Bug fix
hotfix/{slug}     # Fix urgente production
release/v{x.y.z}  # Preparazione release
```

---

## 9. Prototype Mode

### 9.1 Stack Semplificato

- Symfony + Twig + HTMX
- NO API separata
- NO React
- Server-side rendering

### 9.2 Scopo

- Validare UX velocemente
- Testare con utenti reali
- Raccogliere feedback

### 9.3 Regola Fondamentale

**Il codice prototype viene BUTTATO.**
Solo specs e learnings migrano a Production.

---

## 10. Human Gates

Punti dove l'approvazione umana è OBBLIGATORIA:

| Step | Gate |
|------|------|
| Need Analysis | ✋ Approva prima di procedere |
| Acceptance Criteria | ✋ Approva Gherkin specs |
| Architecture | ✋ Approva decisioni tecniche |
| Database Design | ✋ Approva schema |
| Test Plan | ✋ Approva copertura |
| Code Review | ✋ Approva PR |
| Deploy | ✋ Approva release |

**MAI saltare un Human Gate.**
