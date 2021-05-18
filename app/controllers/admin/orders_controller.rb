class Admin::OrdersController < ApplicationController
  
  def top
    if params[:id]
      @orders = Order.where(customer_id: params[:id]).page(params[:page]).per(10)
      ## customer
    else
      @orders = Order.page(params[:page]).per(10)
      ## order
    end
  end
  
  def show
    @order = Order.find(params[:id])
    @order_products = OrderProduct.where(order_id: @order.id)
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end
  
  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end
