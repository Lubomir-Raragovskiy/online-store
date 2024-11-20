class Brand < ApplicationRecord
  has_many :models, dependent: :destroy
  has_many :brand_products
  has_many :products, through: :brand_products
end
