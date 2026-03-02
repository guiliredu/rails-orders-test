require "test_helper"

class OrderTest < ActiveSupport::TestCase

  test "should start with pending state" do
    order = Order.create!(control_number: "A100", title: "Test", description: "Desc")
    assert_equal "pending", order.state
  end

  test "should transition from pending to in_progress" do
    order = Order.create!(control_number: "A101", title: "Test", description: "Desc")

    order.start_progress!
    assert_equal "in_progress", order.state
  end

  test "should transition from in_progress to completed" do
    order = Order.create!(control_number: "A102", title: "Test", description: "Desc")

    order.start_progress!
    order.complete!

    assert_equal "completed", order.state
  end

  test "should not allow invalid transition from pending to completed" do
    order = Order.create!(control_number: "A103", title: "Test", description: "Desc")

    assert_raises(RuntimeError) do
      order.complete!
    end
  end

end