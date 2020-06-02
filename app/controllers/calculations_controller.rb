class CalculationsController < ApplicationController
  before_action :set_calculation, only: [:show, :update, :destroy]

  # GET /calculations
  def index
    @systems = (System.all).where(user_id: current_user.id)
    @calculations = (Calculation.new).getCalculationsByUser(@systems)
    
    render json: @calculations
  end

  # GET /calculations/1
  def show
    if @calculation
      position = @calculation.position_Calculate(@calculation.system.latitude, @calculation.system.longitude)
      cables_protections = @calculation.cables_protections_Calculate(@calculation)
      published = @calculation.system.published? (@calculation.system.id)

      @calc = {"system" => @calculation.system, "calculation" => @calculation, "cables_protections" => cables_protections, "installations" => position, "published" => published}

      render json: @calc
    end
  end

  # POST /calculations
  def create    
    @system = createSystem
    puts @system.errors if @system.errors

    @calculation = Calculation.new()
    panel = @calculation.panel_Calculate(@system.consumption, @system.latitude)
    battery = @calculation.battery_Calculate(panel['wh_per_day'], @system.latitude)
    componets = @calculation.inverter_mppt_Calculate()

    @calculation = Calculation.create(system_id: @system.id, system_circuits: componets['inverters_num'], panels_num: panel['panels_no'], panel_watt: panel['panel_watt'], battery_Ah: battery['battery_amp'], batteries_num: battery['batteries_num'], inverter_watt: componets['inverter_watt'], mppt_amp: componets['mppt_amp'])

    unless @calculation.nil?
      render json: @calculation
    else
      render json: @calculation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /calculations/1
  def update
    if @calculation.update(calculation_params)
      render json: @calculation
    else
      render json: @calculation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /calculations/1
  def destroy
    @calculation.destroy
    # @calculation.system.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calculation
      @calculation = Calculation.find(params[:id]) if Calculation.exists?(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def calculation_params
      params.fetch(:calculation, {}).permit(:id)
    end

end
