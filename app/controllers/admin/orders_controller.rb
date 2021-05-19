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
    @order_products = @order.order_products
    if @order.update(order_params)
      if @order.order_status == "入金確認"
        making = @order.order_products
        making.update_all(making_status: :製作待ち)
      end
        
      @order.order_status  = 1
      flash[:notice] = "注文ステータスを変更しました。"
      redirect_to admin_order_path(@order)
    else
      render 'show'
    end
  end
  
      # if params[:order][:order_status] = "入金確認"
      # making = @order.order_products
      # making.update_all(making_status: :製作待ち)
      # end
  #making = @order.order_products.pulck(:making_status)
  #making.fill["製作待ち"]
  
  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
end
