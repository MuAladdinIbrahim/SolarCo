require 'test_helper'

class GeocoderControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get geocoder_show_url
    assert_response :success
  end

end
