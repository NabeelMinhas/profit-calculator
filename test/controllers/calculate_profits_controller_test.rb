require "test_helper"

class CalculateProfitsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get calculate_profits_new_url
    assert_response :success
  end

  test "should get create" do
    get calculate_profits_create_url
    assert_response :success
  end

  test "should get show" do
    get calculate_profits_show_url
    assert_response :success
  end
end
