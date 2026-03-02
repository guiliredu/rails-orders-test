class OrdersController < ApplicationController
  before_action :set_order, only: %i[start_progress complete]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to orders_path, notice: "Order created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def start_progress
    @order.start_progress!
    redirect_to orders_path
  rescue => e
    redirect_to orders_path, alert: e.message
  end

  def complete
    @order.complete!
    redirect_to orders_path
  rescue => e
    redirect_to orders_path, alert: e.message
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:control_number, :title)
  end
end