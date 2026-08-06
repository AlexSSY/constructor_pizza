class Pizza < ApplicationRecord
  has_many :pizza_ingredients, dependent: :destroy
  has_many :pizza_toppings, through: :pizza_ingredients
  belongs_to :base_pizza

  enum :size, { small: "small", medium: "medium", large: "large" }
  enum :crust, { thin: "thin", thick: "thick" }
  enum :dough, { regular: "regular", whole_wheat: "whole_wheat" }

  accepts_nested_attributes_for :pizza_ingredients, allow_destroy: true

  before_save :set_fingerprint
  before_save :set_price

  def recalculate!
    set_fingerprint
    set_price
    save!
  end

  private

  def set_fingerprint
    self.fingerprint = FingerprintCalculator.calculate(
      base_pizza_id: self.base_pizza_id,
      size: self.size,
      crust: self.crust,
      dough: self.dough,
      pizza_ingredients: self.pizza_ingredients
    )
  end

  def set_price
    self.price = PriceCalculator.calculate(self)
  end
end
