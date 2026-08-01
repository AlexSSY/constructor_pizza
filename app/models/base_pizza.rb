class BasePizza < ApplicationRecord
  belongs_to :pizza_category
  has_many :pizzas

  validates :slug, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
