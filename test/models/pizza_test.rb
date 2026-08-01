require "test_helper"

class PizzaTest < ActiveSupport::TestCase
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
end
