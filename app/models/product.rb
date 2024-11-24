class Product < ApplicationRecord
  # Асоціації
  belongs_to :part
  has_many :brand_products
  has_many :brands, through: :brand_products
  has_many :model_products
  has_many :models, through: :model_products
  has_many :engine_products
  has_many :engines, through: :engine_products
  has_many :reviews, dependent: :destroy
  has_many :characteristics, through: :part
  has_many :model_year_products
  has_many :model_years, through: :model_year_products

  # Active Storage
  has_one_attached :image

  # Валідації
  validates :name, presence: true
  validates :part_id, presence: true

  # Scope'и для фільтрації
  scope :by_brand, ->(brand_id) { joins(:brands).where(brands: { id: brand_id }) if brand_id.present? }
  scope :by_model, ->(model_id) { joins(:models).where(models: { id: model_id }) if model_id.present? }
  scope :by_year, ->(year_id) { joins(models: { model_years: :year }).where(years: { id: year_id }) if year_id.present? }
  scope :by_engine, ->(engine_id) { joins(:engines).where(engines: { id: engine_id }) if engine_id.present? }
  scope :by_part, ->(part_id) { where(part_id: part_id) if part_id.present? }

  # Scope для фільтрації за характеристиками
  scope :by_characteristic, ->(characteristic_id, value) {
    joins(part: :characteristics)
    .where("characteristics.id = ? AND characteristics.value = ?", characteristic_id, value) if characteristic_id.present? && value.present?
  }

  # Ransackable (для фільтрації через Ransack)
  def self.ransackable_attributes(_auth_object = nil)
    %w[name part_id brands.id models.id engines.id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[brands models engines]
  end
end
