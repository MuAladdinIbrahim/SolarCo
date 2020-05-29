class CalculationsController < ApplicationController
  before_action :set_calculation, only: [:show, :update, :destroy]

  # GET /calculations
  def index
    @calculation = Calculation.all
    render json: @calculations
  end

  # GET /calculations/1
  def show
        
    position = @calculation.position_Calculate(lat, @system.longitude)
    cables_protections = @calculation.cables_protections_Calculate(@calculation)

    @calc = {"system" => @calculation.system, "calculation" => @calculation, "calculations_details" => {"cables_protections" => cables_protections, "Installations" => position}}

    # render json: @calculation
    render json: @calc
  end

  # POST /calculations
  def create    
    @system = System.find(calculation_params[:id]) 

    @calculation = Calculation.new()
    panel = @calculation.panel_Calculate(@system.consumption, @system.latitude)
    battery = @calculation.battery_Calculate(panel['wh_per_day'], @system.latitude)
    componets = @calculation.inverter_mppt_Calculate()
    
    if @calculation.update(system_id: @system.id, system_circuits: componets['inverters_num'], panels_num: panel['panels_num'], panel_watt: panel['panel_watt'], battery_Ah: battery['battery_Ah'], batteries_num: battery['batteries_num'], inverter_watt: componets['inverter_watt'], mppt_amp: componets['mppt_amp'])
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
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calculation
      @calculation = Calculation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def calculation_params
      params.require(:calculation).permit(:id, :ip, :lat, :long, :consump)
    end

end
