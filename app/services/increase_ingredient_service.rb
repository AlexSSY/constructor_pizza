class IncreaseIngredientService < ApplicationService
  option :pizza_id
  option :topping_id

  def call
    Pizza.transaction do
      pizza = step find_pizza
      ingredient = step increase_quantity(pizza)
      step update_pizza(pizza)
      ingredient
    end
  end

  def find_pizza
    pizza Pizza.lock.find!(pizza_id)
    Success(pizza)
  end

  def increase_quantity(pizza)
    ingredient = pizza.pizza_ingredients.find_or_initialize_by(
      pizza_topping_id: topping_id
    )
    ingredient.quantity = ingredient.quantity.to_i + 1
    ingredient.save ? Success(ingredient) : Failure(ingredient.errors)
  end

  def update_pizza(pizza)
    # trigger before_save callbacks
    pizza.save ? Success(pizza) : Failure(pizza.errors)
  end
end
