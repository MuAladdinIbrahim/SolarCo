class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :update, :destroy]


  # GET /offers/post/1  -> end-point to retrieve all offer from specific post
  def getOffers
    @offers = Offer.where(post_id: params[:post_id]).all

    render json: @offers.as_json(include: [:contractor])
  end

  # GET /offers
  def index
    @offers = Offer.where(contractor_id: current_contractor.id).all

    render json: @offers.as_json(include: [:post])
  end

  # GET /offers/1
  def show
    render json: @offer.as_json(include: [:post])
  end

  # POST /offers
  def create
    @offer = Offer.new(offer_params)
    @offer.contractor =  Contractor.find(current_contractor.id)
    @offer.post = Post.find(offer_params['post_id'])
    if @offer.save
      render json: @offer, status: :created, location: @offer
    else
      render json: @offer.errors, status: :unprocessable_entity
    end 
  end

  # PATCH/PUT /offers/1
  def update
    if @offer.update(offer_params)
      render json: @offer
    else
      render json: @offer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /offers/1
  def destroy
    @offer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def offer_params
      params.require(:offer).permit(:proposal,:price, :post_id, :status)
    end
end
