require "test_helper"

class IncreaseIngredientServiceTest < ActiveSupport::TestCase
  def setup
    @pizza_topping = pizza_toppings(:alfredo)
    @pizza = pizzas(:one)
  end

  test "should increase the quantity of a pizza ingredient" do
    result = IncreaseIngredientService.call(pizza_id: @pizza.id, topping_id: @pizza_topping.id)
    assert result.success?
    assert_equal 2, result.value!.quantity
    result = IncreaseIngredientService.call(pizza_id: @pizza.id, topping_id: @pizza_topping.id)
    assert_equal 3, result.value!.quantity
  end

  test "should recalculate the pizza's fingerprint after increasing the ingredient" do
    original_fingerprint = @pizza.fingerprint
    result = IncreaseIngredientService.call(pizza_id: @pizza.id, topping_id: @pizza_topping.id)
    assert result.success?
    @pizza.reload
    assert_not_equal original_fingerprint, @pizza.fingerprint
  end

  test "should recalculate the pizza's price after increasing the ingredient" do
    price_before = @pizza.price
    result = IncreaseIngredientService.call(pizza_id: @pizza.id, topping_id: @pizza_topping.id)
    assert result.success?
    @pizza.reload
    assert_equal price_before + @pizza_topping.price, @pizza.price
  end
end
