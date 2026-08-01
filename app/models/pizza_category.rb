class PizzaCategory < ApplicationRecord
  has_many :base_pizzas

  validates :name, presence: true, uniqueness: true
end
