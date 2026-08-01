class PizzaIngredient < ApplicationRecord
  belongs_to :pizza
  belongs_to :pizza_topping

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
