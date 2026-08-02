class IncreaseIngredientService < ApplicationService
  option :pizza_id
  option :topping_id
  option :pizza_synchronizer_class, default: -> { PizzaSynchronizer }

  def call
    Pizza.transaction do
      pizza = Pizza.lock.find(pizza_id)

      @ingredient = pizza.pizza_ingredients.find_or_initialize_by(
        pizza_topping_id: topping_id
      )

      @ingredient.quantity = (@ingredient.quantity || 0) + 1
      @ingredient.save!

      pizza_synchronizer_class.new(pizza).call
    end
    @ingredient
  end
end
