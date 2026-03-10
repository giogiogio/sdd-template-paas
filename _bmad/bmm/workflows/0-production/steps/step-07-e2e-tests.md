# Step 8: E2E Tests

**Agent:** QA
**Input:** Working backend + frontend
**Output:** `tests/e2e/`

---

## Instructions

Write end-to-end tests using Playwright for critical user flows.

---

## Output Structure

```
tests/e2e/
├── {feature}/
│   ├── {feature}.spec.ts
│   └── pages/
│       └── {Page}Page.ts
├── fixtures/
│   └── test-data.ts
└── playwright.config.ts
```

---

## Playwright Config

```typescript
// playwright.config.ts
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    baseURL: 'http://localhost:5173',
    trace: 'on-first-retry',
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:5173',
    reuseExistingServer: !process.env.CI,
  },
});
```

---

## Page Object Pattern

### Page Object Template

```typescript
// tests/e2e/{feature}/pages/{Feature}Page.ts
import { Page, Locator, expect } from '@playwright/test';

export class {Feature}Page {
  readonly page: Page;
  readonly heading: Locator;
  readonly submitButton: Locator;
  readonly fieldInput: Locator;
  readonly errorMessage: Locator;
  readonly successMessage: Locator;

  constructor(page: Page) {
    this.page = page;
    this.heading = page.getByRole('heading', { name: '{Feature}' });
    this.submitButton = page.getByRole('button', { name: 'Submit' });
    this.fieldInput = page.getByLabel('Field');
    this.errorMessage = page.getByRole('alert');
    this.successMessage = page.getByText('Success');
  }

  async goto() {
    await this.page.goto('/{feature}');
  }

  async fillForm(data: { field: string }) {
    await this.fieldInput.fill(data.field);
  }

  async submit() {
    await this.submitButton.click();
  }

  async expectSuccess() {
    await expect(this.successMessage).toBeVisible();
  }

  async expectError(message: string) {
    await expect(this.errorMessage).toContainText(message);
  }
}
```

---

## Test Templates

### Happy Path Test

```typescript
// tests/e2e/{feature}/{feature}.spec.ts
import { test, expect } from '@playwright/test';
import { {Feature}Page } from './pages/{Feature}Page';

test.describe('{Feature}', () => {
  let featurePage: {Feature}Page;

  test.beforeEach(async ({ page }) => {
    featurePage = new {Feature}Page(page);
    await featurePage.goto();
  });

  test('should complete {action} successfully', async () => {
    // Arrange
    const testData = {
      field: 'valid-value',
    };

    // Act
    await featurePage.fillForm(testData);
    await featurePage.submit();

    // Assert
    await featurePage.expectSuccess();
  });
});
```

### Validation Test

```typescript
test('should show error for invalid input', async () => {
  // Arrange
  const invalidData = {
    field: '',
  };

  // Act
  await featurePage.fillForm(invalidData);
  await featurePage.submit();

  // Assert
  await featurePage.expectError('Field is required');
});
```

### Edge Case Test

```typescript
test('should handle {edge case}', async () => {
  // Arrange
  // Setup edge case conditions

  // Act
  // Perform action

  // Assert
  // Verify correct behavior
});
```

---

## Test Coverage Matrix

| Acceptance Criteria | E2E Test | Status |
|--------------------|----------|--------|
| {AC-01} Happy path | {feature}.spec.ts:10 | ✅ |
| {AC-02} Validation | {feature}.spec.ts:25 | ✅ |
| {AC-03} Edge case | {feature}.spec.ts:40 | ✅ |

---

## Running Tests

```bash
# Run all E2E tests
npx playwright test

# Run specific feature
npx playwright test {feature}

# Run with UI
npx playwright test --ui

# Run in headed mode
npx playwright test --headed

# Generate report
npx playwright show-report
```

---

## CI Integration

```yaml
# .github/workflows/e2e.yml
name: E2E Tests

on: [push, pull_request]

jobs:
  e2e:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: 22
          
      - name: Install dependencies
        run: npm ci
        
      - name: Install Playwright
        run: npx playwright install --with-deps
        
      - name: Run E2E tests
        run: npx playwright test
        
      - name: Upload report
        uses: actions/upload-artifact@v4
        if: always()
        with:
          name: playwright-report
          path: playwright-report/
```

---

## Human Gate

Present the E2E tests and ask:

> "Ho creato i test E2E per **{feature}**.
>
> **Test creati:** {count}
> **Copertura acceptance criteria:** {X}%
>
> **Risultati:**
> - ✅ Passed: {count}
> - ❌ Failed: {count}
>
> **Vuoi approvare la copertura E2E?**"

All tests must pass before proceeding to Code Review.
