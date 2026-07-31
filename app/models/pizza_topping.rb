class PizzaTopping < ApplicationRecord
  has_many :pizza_ingredients, dependent: :destroy
  has_many :pizzas, through: :pizza_ingredients

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
