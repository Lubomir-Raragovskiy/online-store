class CarProduct < ApplicationRecord
  belongs_to :car
  belongs_to :product
end
