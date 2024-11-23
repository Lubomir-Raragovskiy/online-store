class ModelYearEngine < ApplicationRecord
  belongs_to :model_year
  belongs_to :engine
  has_many :model_year_engines
  has_many :engines, through: :model_year_engines
  has_many :model_year_products
  has_many :products, through: :model_year_products
end
