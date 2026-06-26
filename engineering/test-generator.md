# Test Generator Prompt

A prompt for generating comprehensive test cases that cover happy paths, edge cases, and failure modes.

## Prompt

```
You are a senior QA engineer writing tests for the code below. Generate a complete set of test cases organized into these categories:

1. **Happy Path**: Tests that verify the primary intended behavior works correctly with valid inputs.
2. **Edge Cases**: Boundary values, empty inputs, maximum lengths, zero values, single-element collections, Unicode strings, and other inputs at the limits of what is valid.
3. **Error Handling**: Invalid inputs, missing required fields, null/None values, type mismatches, and any scenario that should produce a clear error or exception.
4. **Integration Points**: If the code calls external services, databases, or APIs, write tests that mock those dependencies and verify behavior when they succeed, fail, return slowly, or return unexpected data.

For each test:
- Give it a clear, descriptive name that states what is being tested and the expected outcome (for example, `test_create_order_with_empty_cart_returns_validation_error`).
- Include the test body with setup, execution, and assertions.
- Add a brief comment explaining why this test matters if it is not obvious from the name.

Use this testing framework: [TEST_FRAMEWORK]
Language: [LANGUAGE]
Code under test:

[CODE]
```

## Usage Tips

- Replace `[TEST_FRAMEWORK]` with your specific framework, such as "pytest", "JUnit 5", "Go testing with testify", or "Jest with TypeScript."
- Replace `[LANGUAGE]` with the programming language.
- Replace `[CODE]` with the function, class, or module you want tested.
- If the code has dependencies (database connections, HTTP clients, config objects), mention them so the model generates appropriate mocks or fixtures.
- For large modules, focus on one function at a time. Ask the model to generate tests for the most critical or complex function first.
- After generating, review the tests for correctness before adding them to your test suite. AI-generated tests sometimes assert the wrong expected value, especially for math-heavy or stateful code.

## Example Output

```python
import pytest
from unittest.mock import Mock, patch
from orders.service import create_order


class TestCreateOrder:
    """Tests for the create_order function."""

    # --- Happy Path ---

    def test_create_order_with_valid_items_returns_order_id(self):
        """A standard order with valid items should succeed and return an order ID."""
        cart = [{"sku": "WIDGET-01", "quantity": 2, "price": 9.99}]
        result = create_order(user_id="user-123", cart=cart)
        assert result.order_id is not None
        assert result.status == "created"

    def test_create_order_calculates_total_correctly(self):
        cart = [
            {"sku": "WIDGET-01", "quantity": 2, "price": 10.00},
            {"sku": "WIDGET-02", "quantity": 1, "price": 5.00},
        ]
        result = create_order(user_id="user-123", cart=cart)
        assert result.total == 25.00

    # --- Edge Cases ---

    def test_create_order_with_max_quantity_succeeds(self):
        """Orders at the quantity limit (9999) should still be accepted."""
        cart = [{"sku": "WIDGET-01", "quantity": 9999, "price": 0.01}]
        result = create_order(user_id="user-123", cart=cart)
        assert result.status == "created"

    def test_create_order_with_unicode_sku_is_handled(self):
        cart = [{"sku": "WIDGET-éè", "quantity": 1, "price": 5.00}]
        result = create_order(user_id="user-123", cart=cart)
        assert result.order_id is not None

    # --- Error Handling ---

    def test_create_order_with_empty_cart_raises_validation_error(self):
        with pytest.raises(ValidationError, match="Cart must not be empty"):
            create_order(user_id="user-123", cart=[])

    def test_create_order_with_negative_price_raises_validation_error(self):
        cart = [{"sku": "WIDGET-01", "quantity": 1, "price": -5.00}]
        with pytest.raises(ValidationError, match="Price must be positive"):
            create_order(user_id="user-123", cart=cart)

    def test_create_order_with_missing_user_id_raises_error(self):
        cart = [{"sku": "WIDGET-01", "quantity": 1, "price": 9.99}]
        with pytest.raises(TypeError):
            create_order(user_id=None, cart=cart)

    # --- Integration Points ---

    @patch("orders.service.inventory_client")
    def test_create_order_when_inventory_unavailable_raises_service_error(
        self, mock_inventory
    ):
        """If the inventory service is down, we should get a clear error, not a hang."""
        mock_inventory.check_stock.side_effect = ConnectionError("timeout")
        cart = [{"sku": "WIDGET-01", "quantity": 1, "price": 9.99}]
        with pytest.raises(ServiceUnavailableError):
            create_order(user_id="user-123", cart=cart)

    @patch("orders.service.inventory_client")
    def test_create_order_when_item_out_of_stock_returns_failure(
        self, mock_inventory
    ):
        mock_inventory.check_stock.return_value = {"WIDGET-01": 0}
        cart = [{"sku": "WIDGET-01", "quantity": 1, "price": 9.99}]
        result = create_order(user_id="user-123", cart=cart)
        assert result.status == "failed"
        assert "out of stock" in result.reason.lower()
```
