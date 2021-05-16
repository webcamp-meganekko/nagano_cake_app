class Public::OrdersController < ApplicationController
  
  def index
    @order_products = current_customer.orders
  end

  def show
  end

  def new
    @order = Order.new
    @addresses = Address.where(customer: current_customer)
  end

  def confirm
    @order = Order.new(order_params)
    @cart = current_customer.cart
    @order.payment_method = params[:order][:payment_method]
    
    if params[:order][:address_option] == "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.receve_name = full_name(current_customer)

    elsif params[:order][:address_option] == "1"
    @order_address = Address.find(params[:order][:address_id])
    @order.postal_code = @order_address.postal_code
    @order.address = @order_address.address
    @order.receve_name = @order_address.name

    elsif params[:order][:address_option] == "2"
    @order.postal_code = params[:order][:postal_code]
    @order.address = params[:order][:address]
    @order.receve_name = params[:order][:receve_name]
    end
  end

  def create
  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :total_price, :payment_method,
                                  :address, :receve_name, :order_status, :customer_id)
  end
end