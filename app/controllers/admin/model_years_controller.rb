class Admin::ModelYearsController < Admin::SessionController
  before_action :set_model
  before_action :set_model_year, only: [ :edit, :update, :destroy ]

  def index
    @model_years = @model.model_years.includes(:year)
  end

  def new
    @model_year = @model.model_years.new
  end

  def create
    @model_year = @model.model_years.new(model_year_params)
    if @model_year.save
      redirect_to admin_model_model_years_path(@model), notice: "Рік моделі успішно створено."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @model_year.update(model_year_params)
      redirect_to admin_model_model_years_path(@model), notice: "Рік моделі успішно оновлено."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @model_year.destroy
    redirect_to admin_model_model_years_path(@model), notice: "Рік моделі успішно видалено."
  end

  private

  def set_model
    @model = Model.find(params[:model_id])
  end

  def set_model_year
    @model_year = @model.model_years.find(params[:id])
  end

  def model_year_params
    params.require(:model_year).permit(:year_id, :model_id)
  end
end
