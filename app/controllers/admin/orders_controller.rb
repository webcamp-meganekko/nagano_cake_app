class Admin::OrdersController < ApplicationController

  def top
    @customer = params[:customer_id]
    if @customer
      @orders = Order.where(customer_id: @customer).page(params[:page]).per(10)
    else
     @orders = Order.page(params[:page]).per(10)
    end
  end

  def show
    @deliverycharge = 800 # 配送料
    @order = Order.find_by(id: params[:id])
    if @order
      @order_products = OrderProduct.where(order_id: @order.id)
    else
      redirect_to admin_customer_path(params[:id])
    end
  end

  def update
    @order = Order.find(params[:id])
    @order_product = OrderProduct.find(params[:id])
    @order_products = @order.order_products
    if @order.update(order_params)
      @order.change_making_status
      redirect_to admin_order_path(@order)
    else
      render 'show'
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end
end
