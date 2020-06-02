require 'test_helper'

class OfferReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @offer_review = offer_reviews(:one)
  end

  test "should get index" do
    get offer_reviews_url, as: :json
    assert_response :success
  end

  test "should create offer_review" do
    assert_difference('OfferReview.count') do
      post offer_reviews_url, params: { offer_review: { offer_id: @offer_review.offer_id, review: @offer_review.review, contractor_id: @offer_review.contractor_id } }, as: :json
    end

    assert_response 201
  end

  test "should show offer_review" do
    get offer_review_url(@offer_review), as: :json
    assert_response :success
  end

  test "should update offer_review" do
    patch offer_review_url(@offer_review), params: { offer_review: { offer_id: @offer_review.offer_id, review: @offer_review.review, contractor_id: @offer_review.contractor_id } }, as: :json
    assert_response 200
  end

  test "should destroy offer_review" do
    assert_difference('OfferReview.count', -1) do
      delete offer_review_url(@offer_review), as: :json
    end

    assert_response 204
  end
end
