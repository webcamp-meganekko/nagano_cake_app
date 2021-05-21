class Admin::OrderProductsController < ApplicationController
  
  def update
    @order_product = OrderProduct.find(params[:id])
    @order = @order_product.order
    if @order_product.update(order_product_params)
      @order_product.change_order_status
      redirect_to admin_order_path(@order)
    else
      render 'show'
    end
  end

  
  private
  def order_product_params
    params.require(:order_product).permit(:making_status)
  end
end
