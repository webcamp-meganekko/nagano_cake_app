class Public::ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page])
    @product_count = Product.count
    # .reverse_order
  end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end

end
