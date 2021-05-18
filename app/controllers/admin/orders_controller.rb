class Admin::OrdersController < ApplicationController
  before_action :check_order, only:[:show,:update,]
  
  def top
    @orders = Order.page(params[:page]).per(10)
  end
  
  def show
    @order = Order.find_by(id: params[:id])
    @order_products = OrderProduct.where(order_id: @order.id) if @order
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
  
  def check_order
    if Order.find_by(customer_id: params[:id]).nil?
      flash[:notice] = "注文情報がありません"
      redirect_to admin_customer_path(params[:id])
    end
  end
  
end
