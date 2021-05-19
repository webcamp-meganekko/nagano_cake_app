class Admin::OrderProductsController < ApplicationController
  
  def update
    @order_product = OrderProduct.find(params[:id])
    @order = @order_product.order
    @order_product.update(order_product_params)
    if params[:order_product][:making_status] == '製作中'
      @order.update(order_status: '製作中')
      flash[:notice] = "製作ステータスを変更しました。"
      redirect_to admin_order_path(@order)
    elsif @order.order_products.exists?(making_status: ['着手不可','製作待ち','製作中']) == false
      @order.update(order_status: '発送準備中')
      flash[:notice] = "製作ステータスを変更しました。"
      redirect_to admin_order_path(@order)
    else
      redirect_to admin_order_path(@order)
    end
  end
  
  private
  def order_product_params
    params.require(:order_product).permit(:making_status)
  end
end
