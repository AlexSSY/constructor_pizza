class Pizza::FingerprintCalculator
  option :base_pizza_id
  option :size
  option :crust
  option :dough
  option :pizza_ingredients

  def self.calculate(base_pizza_id:, size:, crust:, dough:, pizza_ingredients:)
    new(
      base_pizza_id: base_pizza_id,
      size: size,
      crust: crust,
      dough: dough,
      pizza_ingredients: pizza_ingredients
    ).calculate
  end

  def calculate
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
