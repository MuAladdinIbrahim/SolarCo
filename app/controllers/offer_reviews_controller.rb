class OfferReviewsController < ApplicationController
  before_action :set_offer_review, only: [:show, :update, :destroy]

  # GET /offer_reviews
  def index
    # @offer_reviews = OfferReview.where(contractor_id: params[:id])
    @offer_reviews = (Contractor.find(params[:id])).offer_reviews

    render json: @offer_reviews
  end

  # GET /offer_reviews/1
  def show
    render json: @offer_review
  end

  # POST /offer_reviews
  def create
    @offer_review = OfferReview.new(offer_review_params)

    if @offer_review.save
      render json: @offer_review, status: :created, location: @offer_review
    else
      render json: @offer_review.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /offer_reviews/1
  def update
    if @offer_review.update(offer_review_params)
      render json: @offer_review
    else
      render json: @offer_review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /offer_reviews/1
  def destroy
    @offer_review.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer_review
      @offer_review = OfferReview.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def offer_review_params
      params.require(:offer_review).permit(:review, :contractor_id, :offer_id)
    end
end
