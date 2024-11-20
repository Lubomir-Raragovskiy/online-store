class Engine < ApplicationRecord
  has_many :cars
  has_many :engine_products
  has_many :products, through: :engine_products
end
