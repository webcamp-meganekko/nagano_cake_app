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
    @order = Order.find_by(id: params[:id])
    if @order
      @order_products = OrderProduct.where(order_id: @order.id)
    else
      flash[:notice] = "注文履歴がありません"
      redirect_to admin_customer_path(params[:id])
    end
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
