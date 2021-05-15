class Public::AddressesController < ApplicationController
  
  def index
    @addresses = Address.all
    @address = Address.new
    @customer = current_costomer
  end
  
  def create
    @address = Address.new(address_params)
    @address.save
    redirect_to addresses_path
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    address = Address.find(params[:id])
    address.update(address_params)
    redirect_to addresses_path
  end
  
  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end
  
  private
  def address_params
    params.require(:address).permit(:receve_name, :postal_code, :street_address)
  end
end