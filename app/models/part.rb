class Part < ApplicationRecord
  has_many :part_characteristics
  has_many :characteristics, through: :part_characteristics
  has_many :products
end
