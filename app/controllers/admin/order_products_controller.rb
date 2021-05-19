class Admin::OrderProductsController < ApplicationController
  
  def update
    @order_product = OrderProduct.find(params[:id])
    if @order_product.update(order_product_params)
      flash[:notice] = "製作ステータスを変更しました。"
      redirect_to admin_order_path(@order_product.order.id)
    else
      render 'show'
    end
  end
  
  private
  def order_product_params
    params.require(:order_product).permit(:making_status)
  end
end
