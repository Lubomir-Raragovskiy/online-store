class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :authorize_admin!, only: [ :new, :create, :edit, :update, :destroy ]

  private

  def authorize_admin!
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end
  def index
    @q = Product.ransack(params[:q])

    @parts = Part.all
    @brands = Brand.all
    @engines = Engine.all

    @models = if params[:brand_id].present?
                Model.where(brand_id: params[:brand_id])
    else
                []
    end

    @characteristics = if params[:part_id].present?
                         Characteristic.joins(:part_characteristics)
                                       .where(part_characteristics: { part_id: params[:part_id] })
    else
                         []
    end

    @products = @q.result(distinct: true)

    if params[:brand_id].present?
      brand = Brand.find(params[:brand_id])
      brand_product_ids = brand.products.pluck(:id)
      model_product_ids = Product.joins(models: :brand).where(models: { brand_id: brand.id }).pluck(:id)
      @products = @products.where(id: (brand_product_ids + model_product_ids))
    end

    if params[:model_id].present?
      model = Model.find(params[:model_id])
      @products = @products.joins(:models).where(models: { id: model.id })
    end

    if params[:part_id].present?
      @products = @products.where(part_id: params[:part_id])
    end

    if params[:characteristic_id].present?
      @products = @products.joins(:characteristics).where(characteristics: { id: params[:characteristic_id] })
    end
  end




  def show
    @product = Product.find(params[:id])
  end
end
