require "test_helper"

class PizzaFingerprintTest < ActiveSupport::TestCase
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
    pizza_fingerprint = PizzaFingerprint.new(**@pizza)
    fingerprint = pizza_fingerprint.call
    assert_not_nil fingerprint
    assert_equal 64, fingerprint.length
  end

  test "should generate the same fingerprint for identical pizzas" do
    pizza_fingerprint1 = PizzaFingerprint.new(**@pizza)
    fingerprint1 = pizza_fingerprint1.call

    pizza_fingerprint2 = PizzaFingerprint.new(**@another_pizza)
    fingerprint2 = pizza_fingerprint2.call

    assert_equal fingerprint1, fingerprint2
  end

  test "should generate different fingerprints for different pizzas" do
    pizza_fingerprint1 = PizzaFingerprint.new(**@pizza)
    fingerprint1 = pizza_fingerprint1.call

    pizza_fingerprint2 = PizzaFingerprint.new(**@different_pizza)
    fingerprint2 = pizza_fingerprint2.call

    assert_not_equal fingerprint1, fingerprint2
  end

  test "should generate the same fingerprint for identical pizzas independent from method" do
    pizza_fingerprint1 = PizzaFingerprint.from(@pizza_model)
    fingerprint1 = pizza_fingerprint1.call

    pizza_fingerprint2 = PizzaFingerprint.new(**@another_pizza)
    fingerprint2 = pizza_fingerprint2.call

    assert_equal fingerprint1, fingerprint2
  end
end
