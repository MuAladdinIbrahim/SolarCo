class CalculationsController < ApiController
  before_action :set_calculation, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :index, :update, :destroy]

  # GET /calculations
  def index
    @systems = System.where(user_id: current_user.id).order(created_at: :desc)

    render json: @systems.as_json(include: [:calculation], methods: :cost)
  end

  # GET /calculations/1
  def show
    if (@calculation && (can?(:read, @calculation) && @calculation.system.user == current_user) ||  current_contractor) 
        @calculatSys = getDetails()
        render json: @calculatSys
    else
      render json: {:error => "You are not authorized to view this system"}, status: :unauthorized
    end
  end

  # POST /calculations
  def create    
    @calculations = Calculation.new(calculation_params)

    if @calculations.save
      render json: @calculations, status: :created, location: @calculations
    else
      render json: @calculations.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /calculations/1
  def update
    if @calculation.system.user == current_user
      if @calculation.update(calculation_params)
        render json: @calculation
      else
        render json: @calculation.errors, status: :unprocessable_entity
      end
    else
      render json: {:error => "You are not authorized to update this system"}, status: :unauthorized
    end
  end

  # DELETE /calculations/1
  def destroy
    if can?(:destroy, @calculation) && @calculation.system.user == current_user
      @calculation.destroy
    else
      render json: {:error => "You are not authorized to delete this system"}, status: :unauthorized
    end
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

    def getDetails
      position = @calculation.position_Calculate(@calculation.system.latitude, @calculation.system.longitude)
      cables_protections = @calculation.cables_protections_Calculate(@calculation)
      published = @calculation.system.published? (@calculation.system.id) || false

      @calc = {"system" => @calculation.system, "calculation" => @calculation, "cables_protections" => cables_protections, "installations" => position, "published" => published, "cost" => @calculation.system.cost}
    end

end
