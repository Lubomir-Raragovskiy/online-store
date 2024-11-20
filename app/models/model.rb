class Model < ApplicationRecord
  belongs_to :brand
  has_many :model_products
  has_many :products, through: :model_products
end
