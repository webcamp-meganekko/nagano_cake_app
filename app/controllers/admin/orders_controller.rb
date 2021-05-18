class Admin::OrdersController < ApplicationController
  
  def top
    # 個人ごとの注文履歴一覧
    if params[:id]
      @orders = Order.where(customer_id: params[:id]).page(params[:page]).per(10)
    else
    # 全注文履歴一覧
      @orders = Order.page(params[:page]).per(10)
    end
  end
  
  def show
    @order = Order.find(params[:id])
    @order_products = OrderProduct.where(order_id: @order.id)
  end
  
  def update
    @order = Order.find(params[:id])
    @order_products = OrderProduct.where(order_id: @order.id)
    if @order.update(order_params)
      flash[:notice] = "注文ステータスを変更しました。"
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
