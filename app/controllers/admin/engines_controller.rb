class Admin::EnginesController < Admin::SessionController
  before_action :set_model_year
  before_action :set_model
  before_action :set_engine, only: [ :edit, :update, :destroy ]

  def index
    @engines = @model_year.engines
  end

  def new
    @engine = @model_year.engines.build
  end

  def create
    @engine = @model_year.engines.build(engine_params)
    if @engine.save
      ModelYearEngine.create!(model_year: @model_year, engine: @engine)
      redirect_to admin_model_model_year_engines_path(@model, @model_year), notice: "Двигун успішно створено."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @engine.update(engine_params)
      redirect_to admin_model_model_year_engines_path(@model, @model_year), notice: "Двигун успішно оновлено."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @engine.destroy
    redirect_to admin_model_model_year_engines_path(@model, @model_year), notice: "Двигун успішно видалено."
  end

  private

  def set_model_year
    @model_year = ModelYear.find(params[:model_year_id])
  end

  def set_model
    @model = Model.find(params[:model_id])
  end

  def set_engine
    @engine = @model_year.engines.find(params[:id])
  end

  def engine_params
    params.require(:engine).permit(:name)
  end
end
