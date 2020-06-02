require 'test_helper'

class OfferRatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @offer_rate = offer_rates(:one)
  end

  test "should get index" do
    get offer_rates_url, as: :json
    assert_response :success
  end

  test "should create offer_rate" do
    assert_difference('OfferRate.count') do
      post offer_rates_url, params: { offer_rate: { offer_id: @offer_rate.offer_id, rate: @offer_rate.rate, contractor_id: @offer_rate.contractor_id } }, as: :json
    end

    assert_response 201
  end

  test "should show offer_rate" do
    get offer_rate_url(@offer_rate), as: :json
    assert_response :success
  end

  test "should update offer_rate" do
    patch offer_rate_url(@offer_rate), params: { offer_rate: { offer_id: @offer_rate.offer_id, rate: @offer_rate.rate, contractor_id: @offer_rate.contractor_id } }, as: :json
    assert_response 200
  end

  test "should destroy offer_rate" do
    assert_difference('OfferRate.count', -1) do
      delete offer_rate_url(@offer_rate), as: :json
    end

    assert_response 204
  end
end
