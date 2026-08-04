# Нифига не нужен такой сервис вынести логику в модель, а не в сервис
class PizzaPriceService < ApplicationService
  param :pizza_id

  def call
    find_pizza
    calculate_total_price
  end

  def find_pizza
    @pizza = Pizza.find(pizza_id)
  end

  def calculate_total_price
    base_price = @pizza.base_pizza.price
    toppings_price = @pizza.pizza_ingredients.sum do |ingredient|
      ingredient.pizza_topping.price * ingredient.quantity
    end
    total_price = base_price + toppings_price
    total_price
  end
end
