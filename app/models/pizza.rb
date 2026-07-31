class Pizza < ApplicationRecord
  has_many :pizza_ingredients, dependent: :destroy
  has_many :pizza_toppings, through: :pizza_ingredients
  belongs_to :base_pizza

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :pizza_ingredients, allow_destroy: true
end
