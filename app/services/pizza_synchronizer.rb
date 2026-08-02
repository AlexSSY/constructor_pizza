class PizzaSynchronizer < ApplicationService
  param :pizza
  option :pizza_price_service_class, default: -> { PizzaPriceService }
  option :pizza_fingerprint_service_class, default: -> { PizzaFingerprint }

  def call
    @pizza.price = pizza_price_service_class.new(@pizza).call
    @pizza.fingerprint = pizza_fingerprint_service_class.from(@pizza).call
    @pizza.save!
  end
end
