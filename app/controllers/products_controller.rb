class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])  # Пошук продуктів
    @parts = Part.all                  # Список усіх деталей
    @brands = Brand.all                # Список брендів
    @engines = Engine.all              # Список двигунів
    @models = params[:brand_id].present? ? Model.where(brand_id: params[:brand_id]) : [] # Моделі для обраного бренду

    # Вибрана деталь (якщо обрана)
    @selected_part = params[:part_id].present? ? Part.find_by(id: params[:part_id]) : nil

    # Характеристики для вибраної деталі через таблицю part_characteristics
    if @selected_part
      @characteristics = @selected_part.characteristics.distinct
    else
      @characteristics = []
    end

    # Значення характеристик (якщо вибрана характеристика)
    if params[:characteristic_id].present?
      @characteristic_values = Characteristic.where(id: params[:characteristic_id]).pluck(:value).uniq
    else
      @characteristic_values = []
    end

    # Фільтрація продуктів
    @products = @q.result(distinct: true)
    filter_products
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def filter_products
    # Фільтр за брендом
    if params[:brand_id].present?
      brand = Brand.find(params[:brand_id])
      brand_product_ids = brand.products.pluck(:id)
      model_product_ids = Product.joins(models: :brand).where(models: { brand_id: brand.id }).pluck(:id)
      @products = @products.where(id: (brand_product_ids + model_product_ids))
    end

    # Фільтр за моделлю
    if params[:model_id].present?
      model = Model.find(params[:model_id])
      @products = @products.joins(:models).where(models: { id: model.id })
    end

    # Фільтр за деталлю
    if params[:part_id].present?
      @products = @products.where(part_id: params[:part_id])
    end

    # Фільтр за двигуном
    if params[:engine_id].present?
      @products = @products.where(engine_id: params[:engine_id])
    end

    # Фільтр за характеристиками
    if params[:characteristic_values].present?
      # Отримуємо всі значення характеристик
      characteristic_conditions = params[:characteristic_values].map do |key, value|
        [ "characteristics.name = ? AND characteristics.value = ?", key, value ]
      end

      # Застосовуємо умови для фільтрації
      @products = @products.joins(part: :characteristics)
      characteristic_conditions.each do |condition|
        @products = @products.where(condition)
      end
    end
  end
end
