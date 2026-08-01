class PizzaFetcher < ApplicationService
  def initialize(pizza)
    @pizza = pizza
  end

  def call
    fetch_pizzas
  end

  private

  attr_reader :pizza

  def fetch_pizzas
    fingerprint = PizzaFingerprint.new(pizza).call
    existing = Pizza.where(fingerprint: fingerprint).first

    unless existing
      pizza.fingerprint = fingerprint
      pizza.save!
    end
  end
end
