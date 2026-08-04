# Keep consistent the price and fingerprint of a pizza when it is created or updated.
# The price and fingerprint are calculated using the PizzaPriceService and PizzaFingerprint classes, respectively.
# This service is called after a pizza is created or updated to ensure that the price and fingerprint are always up to date.
class PizzaSynchronizer < ApplicationService
  param :pizza
  option :pizza_price_service_class, default: -> { PizzaPriceService }
  option :pizza_fingerprint_service_class, default: -> { PizzaFingerprint }

  def call
    @pizza.price = pizza_price_service_class.new(pizza.id).call
    @pizza.fingerprint = pizza_fingerprint_service_class.from(pizza).call
    @pizza.save!
  end
end
