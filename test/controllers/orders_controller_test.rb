require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get order" do
    get orders_order_url
    assert_response :success
  end
end
