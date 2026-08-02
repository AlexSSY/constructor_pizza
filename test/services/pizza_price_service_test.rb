require "test_helper"

class PizzaPriceServiceTest < ActiveSupport::TestCase
  def setup
    @pizza_topping1 = PizzaTopping.new(name: "Topping 1", slug: "topping-1", price: "2.0")
    @pizza_topping1.save!
    @pizza_topping2 = PizzaTopping.new(name: "Topping 2", slug: "topping-2", price: "3.0")
    @pizza_topping2.save!

    @base_pizza = BasePizza.new(name: "JFK Base", slug: "jfk-base", price: "10.0", pizza_category: pizza_categories(:summer_taste))
    @base_pizza.save!

    @pizza = Pizza.new(
      size: "medium",
      crust: "thin",
      dough: "regular",
      base_pizza: @base_pizza,
      price: "10.0", # ignore
      pizza_ingredients: [
        PizzaIngredient.new(pizza_topping: @pizza_topping1, quantity: 1),
        PizzaIngredient.new(pizza_topping: @pizza_topping2, quantity: 2)
      ]
    )
    @pizza.save!

    @expected_price = "18.00".to_d
  end

  test "should calculate the total price of a pizza" do
    service = PizzaPriceService.new(pizza: @pizza)
    total_price = service.call
    assert_equal @expected_price, total_price
  end
end
