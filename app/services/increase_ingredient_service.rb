class IncreaseIngredientService < ApplicationService
  option :pizza_id
  option :topping_id

  def call
    transaction do
      pizza = step find_pizza
      pizza_topping = step find_pizza_topping
      ingredient = step increase_quantity(pizza, pizza_topping)
      step update_pizza(pizza)
      ingredient
    end
  end

  def find_pizza
    pizza = Pizza.find_by(pizza_id)
    pizza.present? ? Success(pizza) : Failure(:pizza_not_found)
  end

  def find_pizza_topping
    pizza_topping = PizzaTopping.find_by(topping_id)
    pizza_topping.present? ? Success(pizza_topping) : Failure(:pizza_topping_not_found)
  end

  def increase_quantity(pizza, pizza_topping)
    ingredient = pizza.pizza_ingredients.find_or_initialize_by(pizza_topping:)
    ingredient.quantity = ingredient.quantity.to_i + 1
    ingredient.save!
    Success(ingredient)
  end

  def update_pizza(pizza)
    pizza.recalculate!
    Success(pizza)
  end
end
