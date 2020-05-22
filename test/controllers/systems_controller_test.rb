require 'test_helper'

class SystemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @system = systems(:one)
  end

  test "should get index" do
    get systems_url, as: :json
    assert_response :success
  end

  test "should create system" do
    assert_difference('System.count') do
      post systems_url, params: { system: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show system" do
    get system_url(@system), as: :json
    assert_response :success
  end

  test "should update system" do
    patch system_url(@system), params: { system: {  } }, as: :json
    assert_response 200
  end

  test "should destroy system" do
    assert_difference('System.count', -1) do
      delete system_url(@system), as: :json
    end

    assert_response 204
  end
end
