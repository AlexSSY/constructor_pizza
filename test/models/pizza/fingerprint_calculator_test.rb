require "test_helper"

class Pizza::FingerprintCalculatorTest < ActiveSupport::TestCase
  def setup
    @mariana_id = pizza_toppings(:mariana).id
    @alfredo_id = pizza_toppings(:alfredo).id

    @pizza_model = Pizza.new(
      size: "medium",
      crust: "thin",
      dough: "regular",
      base_pizza: base_pizzas(:pepperoni_base),
      price: 10.0,
      pizza_ingredients: [
        PizzaIngredient.new(pizza_topping: pizza_toppings(:mariana), quantity: 1),
        PizzaIngredient.new(pizza_topping: pizza_toppings(:alfredo), quantity: 1)
      ]
    )

    @pizza = {
      size: "medium",
      crust: "thin",
      dough: "regular",
      base_pizza_id: base_pizzas(:pepperoni_base).id,
      pizza_ingredients: [
        { pizza_topping_id: @mariana_id, quantity: 1 },
        { pizza_topping_id: @alfredo_id, quantity: 1 }
      ]
    }

    @another_pizza = {
      size: "medium",
      crust: "thin",
      dough: "regular",
      base_pizza_id: base_pizzas(:pepperoni_base).id,
      pizza_ingredients: [
        { pizza_topping_id: @alfredo_id, quantity: 1 },
        { pizza_topping_id: @mariana_id, quantity: 1 }
      ]
    }

    @different_pizza = {
      size: "medium",
      crust: "thin",
      dough: "regular",
      base_pizza_id: base_pizzas(:pepperoni_base).id,
      pizza_ingredients: [
        { pizza_topping_id: @alfredo_id, quantity: 1 },
        { pizza_topping_id: @mariana_id, quantity: 2 }
      ]
    }
  end

  test "should generate a unique fingerprint for a pizza" do
    fingerprint = Pizza::FingerprintCalculator.calculate(**@pizza)
    assert_not_nil fingerprint
    assert_equal 64, fingerprint.length
  end

  test "should generate the same fingerprint for identical pizzas" do
    fingerprint1 = Pizza::FingerprintCalculator.calculate(**@pizza)
    fingerprint2 = Pizza::FingerprintCalculator.calculate(**@another_pizza)

    assert_equal fingerprint1, fingerprint2
  end

  test "should generate different fingerprints for different pizzas" do
    fingerprint1 = Pizza::FingerprintCalculator.calculate(**@pizza)
    fingerprint2 = Pizza::FingerprintCalculator.calculate(**@different_pizza)

    assert_not_equal fingerprint1, fingerprint2
  end
end
