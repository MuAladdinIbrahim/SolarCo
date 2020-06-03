class OfferRatesController < ApiController
  before_action :set_offer_rate, only: [:show, :update, :destroy]

  # GET /offer_rates
  def index

    @offer_rates = (Contractor.find(params[:id])).offer_rates
    # @offer_rates = OfferRate.where(contractor_id: params[:id])

    render json: @offer_rates
  end

  # GET /offer_rates/1
  def show
    render json: @offer_rate
  end

  # POST /offer_rates
  def create
    @offer_rate = OfferRate.new(offer_rate_params)

    if @offer_rate.save
      render json: @offer_rate, status: :created, location: @offer_rate
    else
      render json: @offer_rate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /offer_rates/1
  def update
    if @offer_rate.update(offer_rate_params)
      render json: @offer_rate
    else
      render json: @offer_rate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /offer_rates/1
  def destroy
    @offer_rate.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer_rate
      @offer_rate = OfferRate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def offer_rate_params
      params.require(:offer_rate).permit(:rate, :contractor_id, :offer_id)
    end
end
