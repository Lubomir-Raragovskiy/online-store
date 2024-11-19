require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  test "should get order" do
    get orders_order_url
=======
  test "should get new" do
    get orders_new_url
    assert_response :success
  end

  test "should get create" do
    get orders_create_url
    assert_response :success
  end

  test "should get show" do
    get orders_show_url
>>>>>>> 828d59f (Added cart and order pages, created users and orders tables in db)
    assert_response :success
  end
end
