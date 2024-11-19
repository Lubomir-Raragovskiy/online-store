class Product < ApplicationRecord
  belongs_to :part
  has_many :car_products
  has_many :cars, through: :car_products
  has_many :brand_products
  has_many :brands, through: :brand_products
  has_many :model_products
  has_many :models, through: :model_products
  has_many :engine_products
  has_many :engines, through: :engine_products
end
