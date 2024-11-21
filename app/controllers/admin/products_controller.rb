# app/controllers/admin/products_controller.rb
class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_product, only: [ :edit, :update, :destroy ]


  def new
    @product = Product.new
    load_dependencies
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: "Product was successfully created."
    else
      render :new
    end
  end

  def edit
    load_dependencies
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product), notice: "Product was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product was successfully deleted."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def load_dependencies
    @parts = Part.all
    @brands = Brand.all
    @models = Model.all
    @engines = Engine.all
  end

  def product_params
    params.require(:product).permit(:name, :description, :image, :price, :stock, :part_id)
  end

  def authorize_admin!
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end
end
