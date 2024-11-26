class Admin::ProductsController < Admin::SessionController
  before_action :set_product, only: [ :edit, :update, :destroy ]
  before_action :load_dependencies, only: [ :new, :edit, :create, :update ]

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: "Product was successfully created."
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: "Product was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "Product was successfully deleted."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :image,
      :price,
      :stock,
      :part_id,
      :brand_id,
      :model_year_id,
      :engine_id
    )
  end
end
