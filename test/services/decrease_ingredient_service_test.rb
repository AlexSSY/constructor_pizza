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

class DecreaseIngredientServiceTest < ActiveSupport::TestCase
  def setup
    @pizza_topping = pizza_toppings(:alfredo)
    @pizza = pizzas(:two)
  end

  test "should decrease the quantity of a pizza ingredient" do
    service = DecreaseIngredientService.new(pizza_id: @pizza.id, topping_id: @pizza_topping.id, pizza_synchronizer_class: FakePizzaSynchronizer)
    @pizza_ingredient = service.call
    assert_equal true, @pizza_ingredient.persisted?
    assert_equal 1, @pizza_ingredient.quantity
  end

  test "should destroy the pizza ingredient if quantity reaches zero" do
    service = DecreaseIngredientService.new(pizza_id: @pizza.id, topping_id: @pizza_topping.id, pizza_synchronizer_class: FakePizzaSynchronizer)
    @pizza_ingredient = service.call
    @pizza_ingredient = service.call
    assert_equal false, @pizza_ingredient.persisted?
  end
end
