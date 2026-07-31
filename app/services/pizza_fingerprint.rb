# This service is responsible for generating a unique fingerprint for a given pizza based on its attributes and toppings.
class PizzaFingerprint
  # Initializes the service with a pizza object.
  # @param pizza [Pizza] The pizza object for which the fingerprint will be generated.
  def initialize(pizza)
    @pizza = pizza
  end

  attr_reader :pizza

  # Generates the fingerprint for the pizza.
  # @return [String] The generated fingerprint as a hexadecimal string.
  def call
    Digest::SHA256.hexdigest(fingerprint_string)
  end

  private

  def list_of_key_attributes
    [ pizza.pizza_base_id, pizza.size, pizza.crust, pizza.dough ]
  end

  def list_of_toppings_ids_and_quantities
    pizza.pizza_ingredients.map { |ingredient| [ ingredient.pizza_topping_id, ingredient.quantity ] }.sort
  end

  def fingerprint_string
    (list_of_key_attributes + list_of_toppings_ids_and_quantities.flatten).join("-")
  end
end
