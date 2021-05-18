class Admin::OrdersController < ApplicationController
  
  def top
    @orders = Order.page(params[:page]).per(10)
  end
  
  def show
    @order = Order.find_by(id: params[:id])
    return  @order_products = OrderProduct.where(order_id: @order.id) if @order
    flash[:notice] = "注文履歴がありません"
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
