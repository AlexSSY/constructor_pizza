class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  has_secure_password
  has_one :cart, dependent: :destroy
end
