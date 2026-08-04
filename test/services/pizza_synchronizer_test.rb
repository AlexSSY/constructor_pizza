require "test_helper"

class FakePizza
  attr_accessor :price, :fingerprint

  def save!
    true
  end
end

class FakePizzaPriceService
  def initialize(pizza)
    @pizza = pizza
  end

  def call
    500
  end
end

class FakePizzaFingerprintService
  def initialize(pizza)
    @pizza = pizza
  end

  def self.from(pizza)
    self.new(pizza)
  end

  def call
    "fake_fingerprint"
  end
end

class PizzaSynchronizerTest < ActiveSupport::TestCase
  def setup
    @pizza = FakePizza.new
  end

  test "should calculate all" do
    service = PizzaSynchronizer.new(
      @pizza.id,
      pizza_price_service_class: FakePizzaPriceService,
      pizza_fingerprint_service_class: FakePizzaFingerprintService
    )
    service.call
    assert_equal 500, @pizza.price
    assert_equal "fake_fingerprint", @pizza.fingerprint
  end
end
