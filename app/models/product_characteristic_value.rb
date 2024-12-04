class ProductCharacteristicValue < ApplicationRecord
  belongs_to :product
  belongs_to :characteristic_value
end
