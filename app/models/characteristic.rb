class Characteristic < ApplicationRecord
  has_many :part_characteristics
  has_many :parts, through: :part_characteristics
  has_many :characteristic_values
end
