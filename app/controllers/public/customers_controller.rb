class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show #@customer = current_user
  end
  

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :tell, :is_valid)
  end
  
end
