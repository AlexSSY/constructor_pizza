require "test_helper"

class PizzaTest < ActiveSupport::TestCase
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

    @expected_price = "18.00".to_d
  end

  test "pizza should be valid with valid attributes" do
    pizza = Pizza.new(
      size: "medium",
      crust: "thin",
      dough: "regular",
      base_pizza: base_pizzas(:pepperoni_base),
      price: 10.0
    )
    assert pizza.valid?
  end

  test "fingerprint should be generated before saving" do
    pizza = Pizza.new(
      size: "medium",
      crust: "thin",
      dough: "regular",
      base_pizza: base_pizzas(:pepperoni_base),
      price: 10.0
    )
    assert_nil pizza.fingerprint
    pizza.save
    assert_not_nil pizza.fingerprint
  end

  test "fingerprint should be re-generated when pizza attributes change" do
    pizza = Pizza.create(
      size: "medium",
      crust: "thin",
      dough: "regular",
      base_pizza: base_pizzas(:pepperoni_base),
      price: 10.0
    )
    pizza.save
    original_fingerprint = pizza.fingerprint
    assert_not_nil original_fingerprint

    pizza.update(size: Pizza.sizes[:large])
    assert_not_nil pizza.fingerprint
    assert_not_equal original_fingerprint, pizza.fingerprint
  end

  test "should calculate the total price of a pizza" do
    assert_equal @expected_price, @pizza.total_price
  end
end
