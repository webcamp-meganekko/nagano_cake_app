class Public::OrdersController < ApplicationController
  
  def index
    @order_products = current_customer.orders
  end

  def show
  end

  def new
    @order = Order.new
    @addresses = Address.all
  end

  def confirm
  end

  def create
  end

  def complete
  end

  private


  def order_params
    params.require(:order).permit(:postal_code, :total_price, :payment_method, :address, :receve_name, :order_status, :customer_id)
  end
end