class Public::CustomersController < ApplicationController
  
  def show #@customer = current_user
  end
  
  def edit #@customer = current_user
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
       flash[:success] = "登録情報を変更しました"
       redirect_to customers_path
    else
       render :edit
    end
  end
  
  def quit_confirm
  end
  
end
