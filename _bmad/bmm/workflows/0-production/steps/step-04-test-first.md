# Step 5: Test First (TDD)

**Agent:** QA + Dev
**Input:** Approved specs + architecture + database design
**Output:** `tests/unit/`, `tests/integration/`

---

## Instructions

Write tests BEFORE implementation. This is TDD - Red → Green → Refactor.

### Test Pyramid

```
         /\
        /  \     E2E (Step 8)
       /----\    5%
      /      \
     /--------\  Integration
    /          \ 15%
   /------------\
  /              \ Unit Tests
 /----------------\ 80%
```

---

## Output Structure

```
tests/
├── Unit/
│   └── Domain/
│       └── {Context}/
│           ├── Entity/
│           │   └── {Entity}Test.php
│           ├── ValueObject/
│           │   └── {VO}Test.php
│           └── Service/
│               └── {Service}Test.php
├── Integration/
│   └── Application/
│       └── {Context}/
│           └── Handler/
│               └── {Handler}Test.php
└── Fixtures/
    └── {Context}/
        ├── {Entity}Mother.php
        └── {Entity}Builder.php
```

---

## Unit Tests (Domain Layer)

### Entity Test Template

```php
<?php

declare(strict_types=1);

namespace App\Tests\Unit\Domain\{Context}\Entity;

use App\Domain\{Context}\Entity\{Entity};
use App\Tests\Fixtures\{Context}\{Entity}Mother;
use PHPUnit\Framework\TestCase;

final class {Entity}Test extends TestCase
{
    public function test_should_create_valid_entity(): void
    {
        // Arrange
        $id = {Entity}Id::generate();
        $data = {Entity}Mother::validData();

        // Act
        $entity = {Entity}::create($id, $data['field1'], $data['field2']);

        // Assert
        $this->assertEquals($id, $entity->id());
        $this->assertEquals($data['field1'], $entity->field1());
    }

    public function test_should_throw_when_invalid_data(): void
    {
        // Arrange
        $this->expectException(Invalid{Entity}Exception::class);

        // Act
        {Entity}::create(
            {Entity}Id::generate(),
            '', // invalid
            'valid'
        );
    }

    public function test_should_update_field(): void
    {
        // Arrange
        $entity = {Entity}Mother::create();
        $newValue = 'updated';

        // Act
        $entity->updateField($newValue);

        // Assert
        $this->assertEquals($newValue, $entity->field());
    }
}
```

### Value Object Test Template

```php
<?php

declare(strict_types=1);

namespace App\Tests\Unit\Domain\{Context}\ValueObject;

use App\Domain\{Context}\ValueObject\{VO};
use PHPUnit\Framework\TestCase;

final class {VO}Test extends TestCase
{
    public function test_should_create_valid_vo(): void
    {
        $vo = new {VO}('valid-value');
        
        $this->assertEquals('valid-value', $vo->value);
    }

    public function test_should_throw_when_invalid(): void
    {
        $this->expectException(\InvalidArgumentException::class);
        
        new {VO}('invalid');
    }

    public function test_should_be_equal_when_same_value(): void
    {
        $vo1 = new {VO}('same');
        $vo2 = new {VO}('same');
        
        $this->assertTrue($vo1->equals($vo2));
    }

    public function test_should_not_be_equal_when_different_value(): void
    {
        $vo1 = new {VO}('one');
        $vo2 = new {VO}('two');
        
        $this->assertFalse($vo1->equals($vo2));
    }
}
```

---

## Integration Tests (Application Layer)

### Handler Test Template

```php
<?php

declare(strict_types=1);

namespace App\Tests\Integration\Application\{Context}\Handler;

use App\Application\{Context}\Command\{Action}{Entity}Command;
use App\Application\{Context}\Handler\{Action}{Entity}Handler;
use App\Domain\{Context}\Repository\{Entity}RepositoryInterface;
use App\Tests\Fixtures\{Context}\{Entity}Mother;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;

final class {Action}{Entity}HandlerTest extends KernelTestCase
{
    private {Entity}RepositoryInterface $repository;
    private {Action}{Entity}Handler $handler;

    protected function setUp(): void
    {
        self::bootKernel();
        $container = self::getContainer();
        
        $this->repository = $container->get({Entity}RepositoryInterface::class);
        $this->handler = $container->get({Action}{Entity}Handler::class);
    }

    public function test_should_create_entity(): void
    {
        // Arrange
        $command = new {Action}{Entity}Command(
            field1: 'value1',
            field2: 'value2'
        );

        // Act
        $id = $this->handler->handle($command);

        // Assert
        $entity = $this->repository->findById($id);
        $this->assertNotNull($entity);
        $this->assertEquals('value1', $entity->field1());
    }

    public function test_should_throw_when_duplicate(): void
    {
        // Arrange
        $existing = {Entity}Mother::create();
        $this->repository->save($existing);
        
        $command = new {Action}{Entity}Command(
            field1: $existing->field1(), // duplicate
            field2: 'different'
        );

        // Assert
        $this->expectException({Entity}AlreadyExistsException::class);

        // Act
        $this->handler->handle($command);
    }
}
```

---

## Fixtures

### Object Mother Template

```php
<?php

declare(strict_types=1);

namespace App\Tests\Fixtures\{Context};

use App\Domain\{Context}\Entity\{Entity};
use App\Domain\{Context}\ValueObject\{Entity}Id;

final class {Entity}Mother
{
    public static function create(
        ?{Entity}Id $id = null,
        ?string $field1 = null,
        ?string $field2 = null,
    ): {Entity} {
        return {Entity}::create(
            id: $id ?? {Entity}Id::generate(),
            field1: $field1 ?? 'default-value-1',
            field2: $field2 ?? 'default-value-2',
        );
    }

    public static function validData(): array
    {
        return [
            'field1' => 'valid-value-1',
            'field2' => 'valid-value-2',
        ];
    }

    public static function invalidData(): array
    {
        return [
            'field1' => '', // invalid
            'field2' => 'valid',
        ];
    }
}
```

---

## Test Coverage Requirements

| Layer | Target | Actual |
|-------|--------|--------|
| Domain | 90%+ | {X}% |
| Application | 80%+ | {X}% |
| Total | 80%+ | {X}% |

---

## Human Gate

Present the test plan and ask:

> "Ho creato i test per **{feature}** seguendo TDD.
>
> **Test creati:**
> - Unit tests: {count}
> - Integration tests: {count}
> - Fixtures: {count}
>
> **Copertura pianificata:** {X}%
>
> **Tutti i test FALLISCONO (RED)** - questo è corretto!
>
> **Vuoi approvare e procedere con l'implementazione?**"

After implementation, all tests must pass (GREEN).
