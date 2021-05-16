class Public::ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page]).per(8).order(:id)
    @product_count = Product.count

  end

  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end

end
