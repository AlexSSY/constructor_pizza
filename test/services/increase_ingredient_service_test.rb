require "test_helper"

class FakePizzaSynchronizer
  def initialize(pizza)
    @pizza = pizza
  end

  def call
    @pizza.price = 500
    @pizza.fingerprint = "fake_fingerprint"
  end
end

class IncreaseIngredientServiceTest < ActiveSupport::TestCase
  def setup
    @pizza_topping = pizza_toppings(:alfredo)
    @pizza = pizzas(:one)
  end

  test "should increase the quantity of a pizza ingredient" do
    inc = proc { IncreaseIngredientService.call(
      pizza_id: @pizza.id,
      topping_id: @pizza_topping.id
    ) }
    result = inc.call
    assert result.success?
    assert_equal 2, result.value!.quantity
    inc.call
    assert_equal 3, result.value!.quantity
  end

  test "should recalculate the pizza fingerprint after increasing the ingredient" do
    service = IncreaseIngredientService.new(pizza_id: @pizza.id, topping_id: @pizza_topping.id)
    original_fingerprint = @pizza.fingerprint
    service.call
    @pizza.reload
    assert_not_equal original_fingerprint, @pizza.fingerprint
  end
end
