class Year < ApplicationRecord
  has_many :model_years
  has_many :models, through: :model_years
end
