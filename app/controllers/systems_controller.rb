class SystemsController < ApiController
  before_action :set_system, only: [:show, :update, :destroy]

  # GET /systems
  def index
    @system = System.new()
    @systems = @system.getCalculationsId(System.where(user_id: current_user.id).order(created_at: :desc)) 

    render json: @systems
  end

  # GET /systems/1
  def show
    render json: @system
  end

  # POST /systems
  def create
    @system = System.new(system_params)
    @system.user = current_user

    if @system.save
      @calculation = createCalculation(@system)
      render json: @calculation, status: :created
    else
      render json: @system.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /systems/1
  def update
    if @system.update(system_params)
      render json: @system
    else
      render json: @system.errors, status: :unprocessable_entity
    end
  end

  # DELETE /systems/1
  def destroy
    @system.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system
      @system = System.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def system_params
      params.require(:system).permit(:id, :latitude, :longitude, :city, :country, :consumption)
    end

    def createCalculation(system)
      @calculation = Calculation.new()

      panel = @calculation.panel_Calculate(system.consumption, system.latitude)
      battery = @calculation.battery_Calculate(panel['wh_per_day'], system.latitude)
      componets = @calculation.inverter_mppt_Calculate()
  
      @calculation = Calculation.create(system_id: system.id, system_circuits: componets['inverters_num'], panels_num: panel['panels_no'], panel_watt: panel['panel_watt'], battery_Ah: battery['battery_amp'], batteries_num: battery['batteries_num'], inverter_watt: componets['inverter_watt'], mppt_amp: componets['mppt_amp'])
    end

end
