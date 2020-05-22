require 'test_helper'

class CalculationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @calculation = calculations(:one)
  end

  test "should get index" do
    get calculations_url, as: :json
    assert_response :success
  end

  test "should create calculation" do
    assert_difference('Calculation.count') do
      post calculations_url, params: { calculation: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show calculation" do
    get calculation_url(@calculation), as: :json
    assert_response :success
  end

  test "should update calculation" do
    patch calculation_url(@calculation), params: { calculation: {  } }, as: :json
    assert_response 200
  end

  test "should destroy calculation" do
    assert_difference('Calculation.count', -1) do
      delete calculation_url(@calculation), as: :json
    end

    assert_response 204
  end
end
