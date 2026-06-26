# Test Generator Prompt

A structured prompt for generating comprehensive, production-quality test suites that cover happy paths, edge cases, failure modes, and integration boundaries with clear naming, meaningful assertions, and practical mocking strategies.

**Difficulty:** Beginner

## Naive vs. Engineered

Most people paste a function and type something like:

> **Naive prompt:** "Write tests for this code."

**What you get:** Three or four happy-path tests with vague assertions and generic names. Something like:

> ```python
> def test_1(self):
>     result = create_order(user_id="user-123", cart=[{"sku": "A", "quantity": 1, "price": 10}])
>     assert result is not None
>
> def test_2(self):
>     result = create_order(user_id="user-456", cart=[{"sku": "B", "quantity": 2, "price": 20}])
>     assert result.status is not None
>
> def test_3(self):
>     result = create_order(user_id="user-789", cart=[{"sku": "C", "quantity": 5, "price": 5}])
>     assert len(result.line_items) > 0
> ```

No edge cases. No error path coverage. No boundary values. Assertions just check that something exists instead of checking that it is correct. These tests pass even when the code is broken. They also mock internal functions instead of external dependencies, so they shatter every time you refactor.

**This prompt** produces a categorized test suite covering happy paths, boundary values, error handling, integration points, and state transitions, with descriptive names, specific assertions, and mocks applied at the right boundaries. Instead of `test_1` asserting `result is not None`, you get `test_create_order_with_empty_cart_raises_validation_error` asserting `pytest.raises(ValidationError, match="Cart must not be empty")` and `test_create_order_when_inventory_service_down_raises_service_error` mocking the inventory client at the boundary.

## When to use

- Adding tests to existing code that has little or no test coverage and you need a solid starting point
- Expanding test coverage for edge cases and error handling on code that already has basic happy-path tests
- Writing tests in a language or testing framework you are less experienced with
- Bootstrapping a test suite for a new module or service before the first code review
- Generating regression tests after fixing a bug, to ensure the bug does not come back
- You need a starting point for tests and plan to review and refine them before committing
- Preparing for a refactor by establishing a test safety net around the code you plan to change

## When NOT to use

- The code has complex stateful behavior that requires integration tests against real infrastructure (databases, message queues, external APIs with specific state). Write those tests manually with proper test fixtures and test environments.
- You need performance, load, or stress tests. Those require different tooling, test environments, and a fundamentally different approach from unit and functional tests.
- The code is a thin wrapper or pass-through function with no logic (no conditionals, no transformations, no error handling). Testing pass-through code adds maintenance cost without value.
- You need to verify visual UI rendering. Use visual regression testing tools for that, not generated unit tests.

## Prompt

````
You are a senior QA engineer writing a comprehensive test suite for the code provided below. Your goal is to produce tests that are correct, readable, and maintainable, covering not just the happy path but also the boundaries, error paths, and integration points where bugs are most likely to hide.

Context:
- Testing framework: [TEST_FRAMEWORK]
- Language: [LANGUAGE]
- Dependencies the code interacts with (databases, APIs, file system, message queues, etc.): [DEPENDENCIES_OR_NONE]
- Any existing test conventions or patterns used in this project: [TEST_CONVENTIONS_OR_NONE]
- Specific areas of concern the author wants tested thoroughly: [SPECIFIC_CONCERNS_OR_NONE]

Code under test:

[CODE]

Generate a complete set of test cases organized into these categories:

**1. Happy Path**
Tests that verify the primary intended behavior with valid, typical inputs. These establish the baseline: "does the code do what it is supposed to do in the normal case?"

**2. Edge Cases and Boundary Values**
Tests at the limits of valid input. Consider:
- Empty inputs (empty strings, empty lists, empty dicts)
- Single-element collections
- Maximum and minimum allowed values
- Boundary values (0, -1, MAX_INT, the exact limit)
- Unicode strings, special characters, whitespace-only strings
- Very large inputs (if the code does not enforce a limit, test what happens at scale)
- Null, None, nil, or undefined values where the type system allows them

**3. Error Handling and Failure Modes**
Tests that verify the code fails correctly. Consider:
- Invalid inputs (wrong types, missing required fields, out-of-range values)
- Malformed data (invalid JSON, truncated payloads, unexpected data types)
- Inputs that should trigger validation errors, and verify the error messages are correct and useful
- Duplicate operations (creating something that already exists)
- Operations on resources that do not exist

**4. Integration Points and Dependency Behavior**
If the code calls external services, databases, or APIs, write tests that mock those dependencies and verify behavior under these conditions:
- The dependency succeeds and returns expected data
- The dependency fails (connection error, timeout, HTTP 500)
- The dependency returns unexpected data (wrong type, missing fields, extra fields)
- The dependency is slow (if there are timeout configurations to verify)
- The dependency returns empty results

**5. State and Sequence**
If the code has state or if the order of operations matters:
- Test the state transitions (e.g., created -> processing -> completed)
- Test invalid state transitions (e.g., attempting to complete an already-cancelled order)
- Test concurrent operations if the code is expected to handle them
- Test idempotency if the operation should be idempotent

For each test, follow these conventions:
- **Naming**: Use a descriptive name that states the scenario and expected outcome. Examples:
  `test_create_order_with_valid_items_returns_order_id`
  `test_create_order_with_empty_cart_raises_validation_error`
  `test_create_order_when_inventory_unavailable_returns_service_error`
- **Structure**: Use the Arrange-Act-Assert pattern. Separate setup, execution, and assertion with blank lines or comments.
- **Assertions**: Assert specific values, not just that something is "not None." If the function returns a specific status code, assert the exact code. If it returns an error message, assert the message content.
- **Comments**: Add a brief docstring or comment explaining why the test matters if it is not obvious from the name. Do not add comments that restate the code.
- **Independence**: Each test must be independent. Do not rely on test execution order or shared mutable state between tests.
- **Mocking**: Mock at the boundary (external services, databases, clocks), not internal implementation details. If you mock an internal function, the tests will break every time the internal structure is refactored.

Self-critique checklist (apply before presenting the test suite):
- [ ] Did I include at least one test for every public method or function in the code under test?
- [ ] Did I test the error paths, not just the happy path?
- [ ] Did I test boundary values (zero, empty, maximum, minimum)?
- [ ] Are my assertions specific (exact values, exact error messages), not vague (not None, truthy)?
- [ ] Are my test names clear enough that a failing test name alone tells you what broke?
- [ ] Did I avoid testing implementation details that would make the tests brittle?
- [ ] Did I mock external dependencies, not internal functions?
- [ ] Are the expected values in my assertions actually correct, or did I just copy the current behavior (which might be buggy)?
- [ ] Did I test what happens when required inputs are missing, not just when they are wrong?
- [ ] Would these tests catch the bug if someone broke this code tomorrow?

Anti-patterns to avoid:
1. Do not write tests that just verify the code "does not throw." Assert the actual return value or side effect.
2. Do not assert on `is not None` when you know the expected value. Assert the specific value.
3. Do not write a single test that tests five things. Each test should verify one behavior.
4. Do not mock the function under test. Mock its dependencies, not the function itself.
5. Do not hardcode magic numbers without explaining what they represent. Use named constants or clear variable names.
6. Do not write tests that pass when the code is broken (e.g., asserting that a list "has items" without checking what the items are).
7. Do not skip testing error messages. If the code raises a ValidationError, assert the message text so that unhelpful error messages get caught in review.

Edge case handling:
- If the code uses randomness, test with a fixed seed or mock the random source to make tests deterministic.
- If the code depends on the current time, mock the clock. Do not use `time.sleep()` in tests.
- If the code reads from the file system, use temporary files or in-memory fixtures, not paths that only exist on your machine.
- If the code has optional parameters with defaults, test both with and without the optional parameters.
- If the code truncates or rounds values, test the boundary where truncation occurs.
- If the code is in a language or framework you are unfamiliar with, state that clearly and produce tests using the conventions you know, flagging areas where project-specific patterns may differ.
- If a placeholder is left unfilled (e.g., [TEST_FRAMEWORK] still reads "[TEST_FRAMEWORK]"), stop and ask the user to provide it. Tests generated for the wrong framework are worse than no tests at all.
- If the code under test has no clear inputs or outputs (e.g., it only produces side effects like logging or metrics), focus on verifying the side effects with appropriate spies or mock assertions rather than skipping the test entirely.
- If the code is tightly coupled to a specific runtime (GPU-bound code, browser APIs, OS-specific syscalls), note which tests can run in CI without that runtime and which require the real environment.
````

## Why This Works

This prompt uses structured categorization and explicit quality standards to produce tests that actually catch bugs:

- **Five-category test organization** (happy path, edge cases, error handling, integration points, state and sequence): Forces the model to think about the code from five different angles instead of just testing the obvious path. Most bugs hide in edge cases and error paths, which are exactly the categories a naive prompt skips entirely.
- **Boundary value enumeration** (empty inputs, single-element collections, MAX_INT, null values, Unicode strings): Providing a concrete checklist of boundary types to consider prevents the model from testing only with "normal" values. This is where the highest-value test cases live.
- **Naming and assertion conventions** (descriptive names stating scenario and outcome, specific value assertions): Requiring `test_create_order_with_empty_cart_raises_validation_error` instead of `test_3` means a failing test name alone tells you what broke. Requiring exact value assertions instead of `is not None` means the test actually catches regressions.
- **Anti-pattern avoidance** (seven rules including "do not mock the function under test" and "do not write a single test that tests five things"): These block the most common AI-generated test failures. Without them, the model produces tests that pass when the code is broken, mock the wrong things, and combine too many assertions into a single test.
- **Self-critique checklist**: Makes the model verify coverage completeness before presenting the suite. The question "would these tests catch the bug if someone broke this code tomorrow?" is the ultimate test quality check, and forcing the model to answer it improves output significantly.
- **Arrange-Act-Assert structure**: Requiring this pattern makes every test readable and consistent, which matters because tests are documentation. A reviewer can scan the test suite and understand the code's behavior without reading the implementation.

The core improvement is that the naive prompt generates tests that prove the code works. This prompt generates tests that would catch it if the code stopped working.

## Usage Tips

- Replace `[TEST_FRAMEWORK]` with your specific framework and version, such as "pytest 7.x with pytest-mock", "JUnit 5 with Mockito", "Go testing with testify/assert", or "Jest 29 with TypeScript."
- Replace `[LANGUAGE]` with the programming language and version.
- Replace `[DEPENDENCIES_OR_NONE]` with a list of external dependencies the code interacts with (e.g., "PostgreSQL via SQLAlchemy, Redis for caching, Stripe API for payments"). Write "None" if the code has no external dependencies.
- Replace `[TEST_CONVENTIONS_OR_NONE]` with any patterns your team follows (e.g., "we use factory_boy for test data, conftest.py for shared fixtures, and organize tests in a tests/ directory mirroring the src/ structure"). Write "None" if you do not have established conventions.
- Replace `[CODE]` with the function, class, or module you want tested.
- For large modules, focus on one function or class at a time. Ask for the most complex or highest-risk function first, then expand.
- After generating, review the tests for correctness before adding them to your test suite. Pay special attention to the expected values in assertions, especially for math-heavy or stateful code. AI-generated tests sometimes assert what the code currently does, not what it should do.
- If the generated tests reveal that the code does not handle a case you expected it to handle, that is a real finding. Add the test and fix the code.
- **Slash command connection:** If you use `ai-bu-claude-commands`, pair this with the `/blog-from-pr` slash command to document the tests and the code they cover in a blog post.

## Example Output

```python
import pytest
from unittest.mock import Mock, patch, MagicMock
from decimal import Decimal
from orders.service import create_order
from orders.exceptions import ValidationError, ServiceUnavailableError


class TestCreateOrderHappyPath:
    """Tests that verify create_order works correctly with valid inputs."""

    def test_create_order_with_single_item_returns_order_with_created_status(self):
        """The most basic success case: one valid item in the cart."""
        cart = [{"sku": "WIDGET-01", "quantity": 2, "price": Decimal("9.99")}]

        result = create_order(user_id="user-123", cart=cart)

        assert result.order_id is not None
        assert result.status == "created"
        assert len(result.order_id) == 36  # UUID format

    def test_create_order_calculates_total_from_quantity_and_price(self):
        cart = [
            {"sku": "WIDGET-01", "quantity": 2, "price": Decimal("10.00")},
            {"sku": "WIDGET-02", "quantity": 1, "price": Decimal("5.00")},
        ]

        result = create_order(user_id="user-123", cart=cart)

        assert result.total == Decimal("25.00")

    def test_create_order_with_multiple_items_includes_all_line_items(self):
        cart = [
            {"sku": "WIDGET-01", "quantity": 1, "price": Decimal("10.00")},
            {"sku": "WIDGET-02", "quantity": 3, "price": Decimal("5.00")},
            {"sku": "WIDGET-03", "quantity": 2, "price": Decimal("7.50")},
        ]

        result = create_order(user_id="user-123", cart=cart)

        assert len(result.line_items) == 3


class TestCreateOrderEdgeCases:
    """Tests at the boundaries of valid input."""

    def test_create_order_with_quantity_at_max_limit_succeeds(self):
        """Orders at the quantity limit (9999) should be accepted."""
        cart = [{"sku": "WIDGET-01", "quantity": 9999, "price": Decimal("0.01")}]

        result = create_order(user_id="user-123", cart=cart)

        assert result.status == "created"
        assert result.total == Decimal("99.99")

    def test_create_order_with_quantity_of_one_succeeds(self):
        cart = [{"sku": "WIDGET-01", "quantity": 1, "price": Decimal("5.00")}]

        result = create_order(user_id="user-123", cart=cart)

        assert result.status == "created"

    def test_create_order_with_unicode_sku_is_accepted(self):
        """SKUs with non-ASCII characters should not cause encoding errors."""
        cart = [{"sku": "WIDGET-éè", "quantity": 1, "price": Decimal("5.00")}]

        result = create_order(user_id="user-123", cart=cart)

        assert result.order_id is not None

    def test_create_order_with_price_at_one_cent_succeeds(self):
        """The minimum meaningful price should work."""
        cart = [{"sku": "WIDGET-01", "quantity": 1, "price": Decimal("0.01")}]

        result = create_order(user_id="user-123", cart=cart)

        assert result.total == Decimal("0.01")


class TestCreateOrderErrorHandling:
    """Tests that verify the code fails correctly with clear errors."""

    def test_create_order_with_empty_cart_raises_validation_error(self):
        with pytest.raises(ValidationError, match="Cart must not be empty"):
            create_order(user_id="user-123", cart=[])

    def test_create_order_with_negative_price_raises_validation_error(self):
        cart = [{"sku": "WIDGET-01", "quantity": 1, "price": Decimal("-5.00")}]

        with pytest.raises(ValidationError, match="Price must be positive"):
            create_order(user_id="user-123", cart=cart)

    def test_create_order_with_zero_quantity_raises_validation_error(self):
        cart = [{"sku": "WIDGET-01", "quantity": 0, "price": Decimal("9.99")}]

        with pytest.raises(ValidationError, match="Quantity must be at least 1"):
            create_order(user_id="user-123", cart=cart)

    def test_create_order_with_none_user_id_raises_type_error(self):
        cart = [{"sku": "WIDGET-01", "quantity": 1, "price": Decimal("9.99")}]

        with pytest.raises(TypeError):
            create_order(user_id=None, cart=cart)

    def test_create_order_with_missing_sku_raises_validation_error(self):
        cart = [{"quantity": 1, "price": Decimal("9.99")}]

        with pytest.raises(ValidationError, match="SKU is required"):
            create_order(user_id="user-123", cart=cart)

    def test_create_order_with_quantity_exceeding_max_raises_validation_error(self):
        cart = [{"sku": "WIDGET-01", "quantity": 10000, "price": Decimal("9.99")}]

        with pytest.raises(ValidationError, match="Quantity must not exceed 9999"):
            create_order(user_id="user-123", cart=cart)


class TestCreateOrderIntegrationPoints:
    """Tests that verify behavior when external dependencies succeed, fail, or misbehave."""

    @patch("orders.service.inventory_client")
    def test_create_order_when_inventory_service_down_raises_service_error(
        self, mock_inventory
    ):
        """If the inventory service is unreachable, we should get a clear error, not a hang."""
        mock_inventory.check_stock.side_effect = ConnectionError("Connection refused")
        cart = [{"sku": "WIDGET-01", "quantity": 1, "price": Decimal("9.99")}]

        with pytest.raises(ServiceUnavailableError, match="Inventory service"):
            create_order(user_id="user-123", cart=cart)

    @patch("orders.service.inventory_client")
    def test_create_order_when_item_out_of_stock_returns_failed_status(
        self, mock_inventory
    ):
        mock_inventory.check_stock.return_value = {"WIDGET-01": 0}
        cart = [{"sku": "WIDGET-01", "quantity": 1, "price": Decimal("9.99")}]

        result = create_order(user_id="user-123", cart=cart)

        assert result.status == "failed"
        assert "out of stock" in result.reason.lower()

    @patch("orders.service.inventory_client")
    def test_create_order_when_inventory_returns_unexpected_format_raises_error(
        self, mock_inventory
    ):
        """Guard against the inventory service changing its response format."""
        mock_inventory.check_stock.return_value = "unexpected string instead of dict"
        cart = [{"sku": "WIDGET-01", "quantity": 1, "price": Decimal("9.99")}]

        with pytest.raises(ServiceUnavailableError):
            create_order(user_id="user-123", cart=cart)

    @patch("orders.service.inventory_client")
    def test_create_order_when_inventory_times_out_raises_service_error(
        self, mock_inventory
    ):
        from requests.exceptions import Timeout
        mock_inventory.check_stock.side_effect = Timeout("Read timed out")
        cart = [{"sku": "WIDGET-01", "quantity": 1, "price": Decimal("9.99")}]

        with pytest.raises(ServiceUnavailableError, match="timed out"):
            create_order(user_id="user-123", cart=cart)
```
