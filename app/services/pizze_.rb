class PizzaFetcher < ApplicationService
  option :requested_pizza

  def call
    step validate_pizza(requested_pizza)
    fingerprint = step calculate_fingerprint(requested_pizza)
    step anyway_pizza(fingerprint)
  end

  def validate_pizza(pizza)
    pizza.validate!
  end

  def calculate_fingerprint(pizza)
    Success(Pizza::FingerprintCalculator.calculate(pizza))
  end

  def anyway_pizza(fingerprint)
    existing = Pizza.find_by(fingerprint: fingerprint)

    unless existing
      pizza.save!
    end
  end
end
