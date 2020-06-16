class OffersController < ApiController
  before_action :set_offer, only: [:show, :update, :destroy]
  before_action :authenticate_contractor!, only: [:create , :update, :destroy]


  # GET /offers/post/1  -> end-point to retrieve all offer from specific post
  def getOffers
    offers_per_post = Offer.where(post_id: params[:post_id])
    @offers = offers_per_post.order(created_at: :asc).limit(10)

    render json: @offers.as_json(include: [{contractor: { methods: [:avatar_url] }}, :post,])
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
    # if can?(:create, Offer.new)
      @offer = Offer.new(offer_params)
      post = Post.find(offer_params['post_id'])
      if contractor_has_mulitble_offers_validation(post.offers) && !after_closing_post_validation(post) #validate if the contractor has offer in the same post & after cloing post validation
        @offer.contractor = Contractor.find(current_contractor.id)
        @offer.post = post
        if @offer.save
          render json: @offer, status: :created, location: @offer
        else
          render json: @offer.errors, status: :unprocessable_entity
        end
      else
        render json: {:error => "You can't create more than one offer on the same post"}, status: :unauthorized
      end
    # else
    #   render json: {:error => "You are not authorized to create offer"}, status: :unauthorized
    # end
  end

  # PATCH/PUT /offers/1
  def update
    # if can?(:update, @offer)
    post = Post.find(offer_params['post_id'])
    if !after_closing_post_validation(post)
      if @offer.update(offer_params)
        render json: @offer
      else
        render json: @offer.errors, status: :unprocessable_entity
      end
    else
      render json: {:error => "You are not authorized to update this offer"}, status: :unauthorized
    end
      # else
    #   render json: {:error => "You are not authorized to update this offer"}, status: :unauthorized
    # end
  end

  # DELETE /offers/1
  def destroy
    # if can?(:destroy, @offer)
    if !after_closing_post_validation(@offer.post)
      @offer.destroy
    else
      render json: {:error => "You are not authorized to delete this offer"}, status: :unauthorized
    end
    # else
      # render json: {:error => "You are not authorized to delete this offer"}, status: :unauthorized
    # end
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

    def contractor_has_mulitble_offers_validation(offers) #check if the contractor has offer on this post
      for offer in offers do
        if offer.contractor == current_contractor 
          return false #the contractor has offer on this post
        end
      end
    end

    def after_closing_post_validation(post)
      # puts post.closed.inspect 
      if post.closed == true
        # puts post.closed.inspect
        return false #cant make crud on closed post
      end
    end
end
