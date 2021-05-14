class Public::CartsController < ApplicationController

  # before_action :authenticate_customer!

  def index
    @carts = Cart.all
  end

  def create
    @cart = Cart.new(cart_params)
    @cart.save
    redirect_to carts_path
  end

  def update
    @cart = CartProduct.find(params[:cart][:id])
    @cart.update(quantity: params[:cart][:quantity])
    redirect_to carts_path
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to carts_path
  end

  def destroy_all
    # current_customer.carts.destroy_all
    carts.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def cart_params
    params.require(:cart).permit(:quantity,:customer_id,:product_id)
  end

end
