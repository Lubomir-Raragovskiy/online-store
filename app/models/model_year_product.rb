class ModelYearProduct < ApplicationRecord
  belongs_to :model_year
  belongs_to :product
end
