class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @parts = Part.all
    @brands = Brand.all
    @models = params[:brand_id].present? ? Model.where(brand_id: params[:brand_id]) : []
    @years = params[:model_id].present? ? Year.joins(model_years: :model).where(models: { id: params[:model_id] }) : []
    @engines = params[:year_id].present? ? Engine.joins(model_year_engines: { model_year: :year }).where(years: { id: params[:year_id] }) : []

    @selected_part = params[:part_id].present? ? Part.find_by(id: params[:part_id]) : nil

    if @selected_part
      @characteristics = @selected_part.characteristics.distinct
    else
      @characteristics = []
    end

    if params[:characteristic_id].present?
      @characteristic_values = Characteristic.where(id: params[:characteristic_id]).pluck(:value).uniq
    else
      @characteristic_values = []
    end

    @products = @q.result(distinct: true)
    @products = filter_products(@products)
    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def filter_products(products)
    # Фільтр за брендом
    products = products.by_brand(params[:brand_id]) if params[:brand_id].present?

    # Фільтр за моделлю
    products = products.by_model(params[:model_id]) if params[:model_id].present?

    # Фільтр за роком
    products = products.joins(models: { model_years: :year }).where(years: { id: params[:year_id] }) if params[:year_id].present?

    # Фільтр за двигуном
    products = products.by_engine(params[:engine_id]) if params[:engine_id].present?

    # Фільтр за деталлю
    products = products.by_part(params[:part_id]) if params[:part_id].present?

    # Фільтр за характеристиками
    if params[:characteristics].present?
      params[:characteristics].each do |characteristic_id, value|
        products = products.by_characteristic(characteristic_id, value) if value.present?
      end
    end

    products.distinct
  end
end
