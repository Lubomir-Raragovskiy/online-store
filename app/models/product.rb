class Product < ApplicationRecord
  # Асоціації
  belongs_to :part
  has_many :brand_products, dependent: :destroy
  has_many :brands, through: :brand_products
  has_many :model_products, dependent: :destroy
  has_many :models, through: :model_products
  has_many :engine_products, dependent: :destroy
  has_many :engines, through: :engine_products
  has_many :reviews, dependent: :destroy
  has_many :product_characteristic_values, dependent: :destroy
  has_many :characteristic_values, through: :product_characteristic_values
  has_many :model_year_products, dependent: :destroy
  has_many :model_years, through: :model_year_products

  has_one_attached :image

  validates :name, presence: true
  validates :part_id, presence: true

  # Scope'и для фільтрації
  scope :by_brand, ->(brand_id) { joins(:brands).where(brands: { id: brand_id }) if brand_id.present? }
  scope :by_model, ->(model_id) { joins(:models).where(models: { id: model_id }) if model_id.present? }
  scope :by_year, ->(year_id) { joins(models: { model_years: :year }).where(years: { id: year_id }) if year_id.present? }
  scope :by_engine, ->(engine_id) { joins(:engines).where(engines: { id: engine_id }) if engine_id.present? }
  scope :by_part, ->(part_id) { where(part_id: part_id) if part_id.present? }

  # Scope для фільтрації за характеристиками
  scope :by_characteristic_value, ->(characteristic_id, value) {
  joins(product_characteristic_values: { characteristic_value: :characteristic })
    .where(characteristics: { id: characteristic_id }, characteristic_values: { id: value }) if characteristic_id.present? && value.present?
  }

  # Ransackable (для фільтрації через Ransack)
  def self.ransackable_attributes(_auth_object = nil)
    %w[name part_id brands.id models.id engines.id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[brands models engines characteristic_values]
  end

  after_save :associate_with_models_from_brands

  private

  def associate_with_models_from_brands
    brands.each do |brand|
      brand.models.each do |model|
        ModelProduct.find_or_create_by!(model: model, product: self)
      end
    end
  end
end
