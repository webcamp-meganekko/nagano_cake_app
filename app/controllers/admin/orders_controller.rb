class Admin::OrdersController < ApplicationController
  
  def top
    @orders = Order.all
  end
  
end
