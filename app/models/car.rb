class Car < ApplicationRecord
  belongs_to :brand
  belongs_to :model
  belongs_to :year
  belongs_to :engine
end
