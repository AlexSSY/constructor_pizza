# Update the PizzaPriceService to calculate the total price of a pizza based on its base price and the prices of its toppings.
class PizzaPriceService < ApplicationService
  option :pizza

  def call
    base_price = @pizza.base_pizza.price
    toppings_price = @pizza.pizza_ingredients.sum do |ingredient|
      ingredient.pizza_topping.price * ingredient.quantity
    end
    total_price = base_price + toppings_price
    total_price
  end
end
