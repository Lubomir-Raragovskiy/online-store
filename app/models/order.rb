class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :name, :email, :phone, presence: true, unless: -> { user.present? }
  has_one :address

  validates :payment_method, inclusion: { in: %w[card cash], message: "Недійсний спосіб оплати" }

  def total_price_cents
    order_items.sum { |item| item.price * item.quantity }
  end

  accepts_nested_attributes_for :address

  attr_accessor :card_number, :card_expiry_month, :card_expiry_year, :card_cvc, :from_button
end
