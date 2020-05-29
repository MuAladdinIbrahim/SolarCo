require 'test_helper'

class OffersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @offer = offers(:one)
  end

  test "should get index" do
    get offers_url, as: :json
    assert_response :success
  end

  test "should create offer" do
    assert_difference('Offer.count') do
      post offers_url, params: { offer: { contractor_id: @offer.contractor_id, post_id: @offer.post_id, price: @offer.price, proposal: @offer.proposal, status: @offer.status } }, as: :json
    end

    assert_response 201
  end

  test "should show offer" do
    get offer_url(@offer), as: :json
    assert_response :success
  end

  test "should update offer" do
    patch offer_url(@offer), params: { offer: { contractor_id: @offer.contractor_id, post_id: @offer.post_id, price: @offer.price, proposal: @offer.proposal, status: @offer.status } }, as: :json
    assert_response 200
  end

  test "should destroy offer" do
    assert_difference('Offer.count', -1) do
      delete offer_url(@offer), as: :json
    end

    assert_response 204
  end
end
