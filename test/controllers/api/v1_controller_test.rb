require 'test_helper'

class Api::V1ControllerTest < ActionDispatch::IntegrationTest
  test "should get reminders" do
    get api_v1_reminders_url
    assert_response :success
  end

end
