class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :pizza
  belongs_to :cart_itemable, polymorphic: true

  validates :quantity, numericality: { greater_than: 0 }
end
