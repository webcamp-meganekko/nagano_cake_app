class Public::OrdersController < ApplicationController
  before_action :cart_is_empty, only: [:new, :confirm]
  
  
  # カートの中身が空かどうかチェックするメソッド
  def cart_is_empty
    if current_customer.carts.empty?
      flash[:notice] = "カートに商品がありません。"
      redirect_to carts_path
    end
  end
  
  PER = 10
  
  def top
    @order_products = current_customer.orders
  end
  
  def index
    @orders = current_customer.orders.all
  end

  def show
    @sum = 0
    @deliverycharge = 800 # 配送料
    @order = current_customer.orders.find(params[:id])
    @order_products = OrderProduct.where(order_id: @order.id)
  end

  def new
    @order = Order.new
    @addresses = Address.where(customer: current_customer)
  end

  def confirm
    @sum = 0
    @deliverycharge = 800 # 配送料
    @order = Order.new(order_params)
    @carts = current_customer.carts
    @order.payment_method = params[:order][:payment_method]
    
    if params[:order][:address_option] == "0"
      
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.receve_name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:address_option] == "1"
      @order_address = Address.find(params[:order][:address_id])
      @order.postal_code = @order_address.postal_code
      @order.address = @order_address.street_address
      @order.receve_name = @order_address.receve_name

    elsif params[:order][:address_option] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.receve_name = params[:order][:receve_name]
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @carts = current_customer.carts.all
      @carts.each do |cart|
        @order_products = @order.order_products.new
        @order_products.product_id = cart.product.id
        @order_products.price = cart.product.price
        @order_products.quantity = cart.quantity
        @order_products.save
        current_customer.carts.destroy_all
      end
    redirect_to orders_complete_path
  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :total_price, :payment_method, :postage,
                                  :address, :receve_name, :order_status, :customer_id)
  end
end