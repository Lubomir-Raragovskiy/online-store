class Admin::ModelsController < Admin::SessionController
  before_action :set_brand, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_model, only: [ :edit, :update, :destroy ]

  def index
    @brands = Brand.includes(:models).all
  end

  def new
    @model = Model.new
  end

  def create
    @model = Model.new(model_params)
    if @model.save
      redirect_to admin_models_path(@brand), notice: "Модель успішно створена."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @model.update(model_params)
      redirect_to admin_models_path, notice: "Модель успішно оновлена."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @model.destroy
    redirect_to admin_models_path, notice: "Модель успішно видалена."
  end

  private

  def set_brand
    @brand = Brand.find(params[:brand_id]) if params[:brand_id]
  end

  def set_model
    @model = Model.find(params[:id])
  end

  def model_params
    params.require(:model).permit(:name, :brand_id)
  end
end
