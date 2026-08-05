require "test_helper"

class Pizza::PriceCalculatorTest < ActiveSupport::TestCase
  def setup
    @not_persisted_pizza = Pizza.new(
      base_pizza_id: base_pizzas(:pepperoni_base).id,
      size: "small",
      crust: "thin",
      dough: "regular",
      pizza_ingredients: [
        PizzaIngredient.new(pizza_topping_id: pizza_toppings(:alfredo).id, quantity: 1)
      ]
    )
  end

  test "should generate correct price for not persisted pizza" do
    price = Pizza::PriceCalculator.calculate(@not_persisted_pizza)
    assert_equal 12.99 + 1.75, price
  end

  test "should generate correct price for persisted pizza" do
    persisted_pizza = pizzas(:one)
    price = Pizza::PriceCalculator.calculate(persisted_pizza)
    assert_equal 12.99 + 1.75, price
  end
end
