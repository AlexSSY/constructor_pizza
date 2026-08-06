class Pizza::PriceCalculator < ModelCalculator
  param :pizza

  def calculate
    pizza.base_pizza.price + toppings_price
  end

  private

  def toppings_price
    pizza.pizza_ingredients.sum do |ingredient|
      ingredient.pizza_topping.price * ingredient.quantity
    end
  end
end
