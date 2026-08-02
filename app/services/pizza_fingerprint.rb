# This service is responsible for generating a unique fingerprint for a given pizza based on its attributes and toppings.
class PizzaFingerprint < ApplicationService
  option :base_pizza_id
  option :size
  option :crust
  option :dough
  option :pizza_ingredients

  def self.from(pizza) = new(
      base_pizza_id: pizza.base_pizza_id,
      size: pizza.size,
      crust: pizza.crust,
      dough: pizza.dough,
      pizza_ingredients: pizza.pizza_ingredients.map do |ingredient|
        { pizza_topping_id: ingredient.pizza_topping_id, quantity: ingredient.quantity }
      end
    )

  attr_reader :base_pizza_id, :size, :crust, :dough, :pizza_ingredients

  def call
    Digest::SHA256.hexdigest(fingerprint_string)
  end

  private

  def list_of_key_attributes
    [ base_pizza_id, size, crust, dough ]
  end

  def list_of_toppings_ids_and_quantities
    pizza_ingredients.map { |ingredient| [ ingredient[:pizza_topping_id], ingredient[:quantity] ] }.sort
  end

  def fingerprint_string
    (list_of_key_attributes + list_of_toppings_ids_and_quantities.flatten).join("-")
  end
end
