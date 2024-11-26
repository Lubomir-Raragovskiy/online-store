class ModelYear < ApplicationRecord
  belongs_to :model
  belongs_to :year
  has_many :model_year_engines, dependent: :destroy
  has_many :engines, through: :model_year_engines
  has_many :model_year_products, dependent: :destroy
  has_many :products, through: :model_year_products
end
