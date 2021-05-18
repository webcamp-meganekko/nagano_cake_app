class Public::AddressesController < ApplicationController
  before_action :baria_customer, only:[ :edit, :destroy, :update]
  
  def index
    @addresses = current_customer.addresses.all #ログインユーザーのアドレスのみ
    @address = Address.new
  end
  
  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:notice] = "配送先を登録しました。"
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses.all
      render 'index'
    end
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "配送先を更新しました。"
      redirect_to addresses_path
    else
      render 'edit'
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
  
  #ログイン中のカスタマーのアドレスのみ変更を許可
  def baria_customer
    unless Address.find(params[:id]).customer == current_customer
      redirect_to customer_show_path
    end
  end
  
end