require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = Order.create!(control_number: "CTRL-1", title: "Test")
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should create order with pending state" do
    assert_difference("Order.count", 1) do
      post orders_url, params: {
        order: { control_number: "CTRL-2" }
      }
    end

    order = Order.last
    assert_equal "pending", order.state
  end

  test "should start progress" do
    get start_progress_order_url(@order)

    @order.reload
    assert_equal "in_progress", @order.state
  end

  test "should complete order" do
    @order.start_progress!

    get complete_order_url(@order)

    @order.reload
    assert_equal "completed", @order.state
  end

  test "should not allow invalid transition" do
    assert_raises(RuntimeError) do
      @order.complete!
    end
  end
end