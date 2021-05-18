
class Public::CartsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @carts = Cart.all
  end

  def create
    @carts = current_customer.carts.all
    same_product = false
    id = 0
    @carts.each do |cart|
      if cart.product_id == cart_params[:product_id].to_i
        same_product = true
        id = cart.id
      end
    end
    if same_product
      cart = Cart.find(id)
      update_quantity = cart.quantity.to_i + cart_params[:quantity].to_i
      cart.update_attributes(quantity: update_quantity)
      redirect_to carts_path
    else
      @cart = current_customer.carts.new(cart_params)
      if  @cart.save
        redirect_to carts_path
      else
        redirect_to product_path(params[:cart][:product_id])
        flash[:notice] = "個数を選択してください"
      end
    end
  end

  def update
    @cart = Cart.find(params[:cart][:id])
    @cart.update(quantity: params[:cart][:quantity])
    redirect_to carts_path
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to carts_path
  end

  def destroy_all
    current_customer.carts.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def cart_params
    params.require(:cart).permit(:quantity,:customer_id,:product_id)
  end

end