class DecreaseIngredientService < ApplicationService
  option :pizza_id
  option :topping_id
  option :pizza_synchronizer_class, default: -> { PizzaSynchronizer }

  def call
    Pizza.transaction do
      pizza = Pizza.lock.find(pizza_id)

      @ingredient = pizza.pizza_ingredients.find_by(
        pizza_topping_id: topping_id
      )

      if @ingredient.present? && @ingredient.quantity > 1
        @ingredient.quantity -= 1
        @ingredient.save!
      elsif @ingredient.present? && @ingredient.quantity == 1
        @ingredient.destroy!
      end

      pizza_synchronizer_class.new(pizza).call
    end
    @ingredient
  end
end
