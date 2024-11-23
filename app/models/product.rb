class Product < ApplicationRecord
  belongs_to :part
  has_many :car_products
  has_many :cars, through: :car_products
  has_many :brand_products
  has_many :brands, through: :brand_products
  has_many :model_products
  has_many :models, through: :model_products
  has_many :engine_products
  has_many :engines, through: :engine_products
  has_many :reviews, dependent: :destroy
  has_many :characteristics, through: :part
  has_one_attached :image

  def self.ransackable_attributes(_auth_object = nil)
    [ "name", "part_id", "brands.id", "models.id", "engines.id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[brands models engines]
  end
end
