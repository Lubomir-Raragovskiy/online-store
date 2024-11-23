class Engine < ApplicationRecord
  has_many :engine_products
  has_many :products, through: :engine_products
  has_many :model_year_engines, dependent: :destroy
  has_many :model_years, through: :model_year_engines
end
