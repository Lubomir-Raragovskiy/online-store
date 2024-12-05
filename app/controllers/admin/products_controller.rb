class Admin::ProductsController < ProductsController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_product, only: [ :edit, :update, :destroy ]
  before_action :load_dependencies, only: [ :new, :edit, :create, :update ]

  def new
    @product = Product.new
    @product_characteristics = []
  end

  def edit
    @product_characteristics = @product.part&.characteristics || []
  end

  def create
    @product = Product.new(product_params.except(:characteristic_values))
    if @product.save
      update_characteristics
      redirect_to edit_admin_product_path(@product), notice: "Продукт успішно створений."
    else
      @product_characteristics = @product.part&.characteristics || []
      render :new
    end
  end

  def update
    @product_characteristics = @product.part&.characteristics || []
    if @product.update(product_params.except(:characteristic_values))
      update_characteristics
      redirect_to productS_path, notice: "Продукт успішно оновлений."
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Продукт успішно видалений."
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
      brand_ids: [],
      model_ids: [],
      engine_ids: [],
      model_year_ids: [],
      characteristic_values: []
    )
  end

  def load_dependencies
    @parts = Part.all
    @brands = Brand.all
    @models = Model.all
    @engines = Engine.all
    @years = Year.all
    @model_years = ModelYear.all
    @characteristics = Characteristic.all
  end

  def update_characteristics
    if params[:product][:characteristic_values].present?
      @product.product_characteristic_values.destroy_all
      params[:product][:characteristic_values].each do |value_id|
        next if value_id.blank?
        @product.product_characteristic_values.create(characteristic_value_id: value_id)
      end
    end
  end

  def authorize_admin!
    redirect_to root_path, alert: "Доступ заборонено!" unless current_user&.admin?
  end
end
