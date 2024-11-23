class Model < ApplicationRecord
  belongs_to :brand
  has_many :model_products
  has_many :products, through: :model_products
  has_many :model_years
  has_many :years, through: :model_years
end
