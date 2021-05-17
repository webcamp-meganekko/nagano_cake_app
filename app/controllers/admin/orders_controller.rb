class Admin::OrdersController < ApplicationController
  
  def top
    @order_products = OrderProduct.all
  end
  
end
