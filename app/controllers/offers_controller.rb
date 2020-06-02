class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :update, :destroy]


  # GET /offers/post/1  -> end-point to retrieve all offer from specific post
  def getOffers
    @offers = Offer.where(post_id: params[:post_id]).all

    render json: @offers.as_json(include: {contractor: { methods: [:avatar_url] }})
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
    if can?(:create, Offer)
      @offer = Offer.new(offer_params)
      @offer.contractor =  Contractor.find(current_contractor.id)
      @offer.post = Post.find(offer_params['post_id'])
      if @offer.save
        render json: @offer, status: :created, location: @offer
      else
        render json: @offer.errors, status: :unprocessable_entity
      end
    else
      render json: {:error => "You are not authorized to create offer"}, status: :unauthorized
    end
  end

  # PATCH/PUT /offers/1
  def update
    if can?(:update, @offer)
      if @offer.update(offer_params)
        render json: @offer
      else
        render json: @offer.errors, status: :unprocessable_entity
      end
    else
      render json: {:error => "You are not authorized to update this offer"}, status: :unauthorized
    end
  end

  # DELETE /offers/1
  def destroy
    if can?(:destroy, @offer)
      @offer.destroy
    else
      render json: {:error => "You are not authorized to delete this offer"}, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def offer_params
      params.require(:offer).permit(:proposal,:price, :post_id)
    end
end
