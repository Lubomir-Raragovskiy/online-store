class Admin::ProductsController < ProductsController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_product, only: [ :edit, :update, :destroy ]
  before_action :load_dependencies, only: [ :new, :edit, :create, :update ]

  def new
    @product = Product.new
  end

  def edit
    @product_characteristics = @product.part ? @product.part.characteristics : []
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      save_characteristics(@product)
      render :edit
    else
      render :new
    end
  end

  def update
    @product_characteristics = @product.part ? @product.part.characteristics : []
    if @product.update(product_params)
      save_characteristics(@product)
      render :edit, notice: "Product was successfully updated."
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
      :price,
      :stock,
      :image,
      :part_id,
      brand_ids: [], model_ids: [], engine_ids: [], model_year_ids: [],
    )
  end


  def load_dependencies
    @parts = Part.all
    @brands = Brand.all
    @models = Model.all
    @engines = Engine.all
    @years = ModelYear.all
  end

  def authorize_admin!
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end
end
