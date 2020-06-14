class SystemsController < ApiController
  before_action :set_system, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /systems
  def index
    @systems = System.where(user_id: current_user.id).order(created_at: :desc) 

    render json: @systems.as_json(include: [calculation: {only: :id}], methods: :cost)
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
      @calculation = createCalculation()
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
    if !@system.onOffer? (@system)
      @system.destroy
    else
    render json: {"error" => "This System under Offer..!!"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system
      @system = System.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def system_params
      params.require(:system).permit(:id, :latitude, :address, :longitude, :city, :country, :consumption, :backup)
    end

    def createCalculation
      @calculation = Calculation.new()

      panel = @calculation.panel_Calculate(@system)
      battery = @calculation.battery_Calculate(panel['wh_per_day'], @system.latitude)
      componets = @calculation.inverter_mppt_Calculate()
  
      @calculation = Calculation.create(system_id: @system.id, system_circuits: componets['inverters_num'], panels_num: panel['panels_no'], panel_watt: panel['panel_watt'], battery_Ah: battery['battery_amp'], batteries_num: battery['batteries_num'], inverter_watt: componets['inverter_watt'], mppt_amp: componets['mppt_amp'])
    end

end
