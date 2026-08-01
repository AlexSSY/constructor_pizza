class Pizza < ApplicationRecord
  has_many :pizza_ingredients, dependent: :destroy
  has_many :pizza_toppings, through: :pizza_ingredients
  belongs_to :base_pizza

  validates :price, numericality: { greater_than_or_equal_to: 0 }

  enum :size, { small: "small", medium: "medium", large: "large" }
  enum :crust, { thin: "thin", thick: "thick" }
  enum :dough, { regular: "regular", whole_wheat: "whole_wheat" }

  accepts_nested_attributes_for :pizza_ingredients, allow_destroy: true

  before_save :generate_fingerprint

  private

  def generate_fingerprint
    self.fingerprint = PizzaFingerprint.from(self).call
  end
end
