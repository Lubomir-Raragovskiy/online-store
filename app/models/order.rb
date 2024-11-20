class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :name, :email, :phone, presence: true, unless: -> { user.present? }
  belongs_to :address
end
