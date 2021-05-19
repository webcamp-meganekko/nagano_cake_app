class Admin::OrderProductsController < ApplicationController
  
  def update
    @order_product = OrderProduct.find(params[:id])
    if @order_product.update(order_product_params)
      if @order_product.making_status == "製作中"
        @order_product.order.update(order_status: "製作中")
      elsif @order_product.order.order_products.pluck(:making_status).all?{ |status| status == "製作完了"}
        @order_product.order.update(order_status: "発送準備中")
      end
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
