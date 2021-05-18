class Public::AddressesController < ApplicationController
  
  def index
    @addresses = Address.all
    @address = Address.new
  end
  
  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:notice] = "配送先を登録しました。"
      redirect_to addresses_path
    else
      @addresses = Address.all
      render 'index'
    end
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    address = Address.find(params[:id])
    if address.update(address_params)
      flash[:notice] = "配送先を更新しました。"
      redirect_to addresses_path
    else
      @address = Address.find(params[:id])
      redirect_to edit_address_path(@address)
    end
  end
  
  def destroy
    address = Address.find(params[:id])
    address.destroy
    flash[:notice] = "配送先を削除しました。"
    redirect_to addresses_path
  end
  
  private
  def address_params
    params.require(:address).permit(:customer_id, :receve_name, :postal_code, :street_address)
  end
end