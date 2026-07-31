class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :pizzas, through: :cart_items

  def total_price
    cart_items.includes(:pizza).sum { |item| item.pizza.price * item.quantity }
  end
end
